<?php

namespace App\Http\Controllers;

use App\Models\Prestamo;
use App\Models\Usuario;
use App\Models\PlanPago;
use App\Models\Capital;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Auth;
use App\Models\Mora;

class PrestamoController extends Controller
{
    public function index()
    {
        $prestamos = Prestamo::with('usuario')->latest()->paginate(10);
        return view('admin.prestamos.index', compact('prestamos'));
    }

    public function create()
    {
        $usuarios = Usuario::all();
        $capitalDisponible = Capital::latest()->first()->monto_actual ?? 0;
        return view('admin.prestamos.create', compact('usuarios', 'capitalDisponible'));
    }

    public function edit($id)
    {
        $prestamo = Prestamo::with('usuario')->findOrFail($id);
        $usuarios = Usuario::all();
        return view('admin.prestamos.edit', compact('prestamo', 'usuarios'));
    }

    public function update(Request $request, $id)
{
    $request->validate([
        'usuario_id' => 'required|exists:usuarios,id',
        'monto' => 'required|numeric|min:1',
        'tasa_interes_mensual' => 'required|numeric|min:0',
        'plazo_meses' => 'required|integer|min:1|max:3',
        'frecuencia_pago' => 'required|in:diario,semanal,quincenal,mensual',
        'fecha_desembolso' => 'required|date',
        'referencia_celular' => 'nullable|string|max:20',
        'estado' => 'required|in:vigente,cancelado,mora'
    ]);

    $prestamo = Prestamo::findOrFail($id);

    // Si se cambió el monto, ajustar el capital
    if ($prestamo->monto != $request->monto) {
        $diferencia = $request->monto - $prestamo->monto;
        $capital = \App\Models\Capital::latest()->first();

        // Validar que hay suficiente capital si la diferencia es positiva (aumento del monto)
        if ($diferencia > 0 && $capital->monto_actual < $diferencia) {
            return back()->with('error', 'No hay suficiente capital para aumentar el monto del préstamo.');
        }

        // Registrar movimiento de ajuste de capital
        \App\Models\Capital::create([
            'monto_inicial' => -$diferencia, // si es negativo se suma, si es positivo se descuenta
            'monto_actual' => $capital->monto_actual - $diferencia,
            'descripcion' => 'Ajuste de capital por edición del préstamo ID: ' . $prestamo->id,
            'usuario_id' => Auth::id()
        ]);
    }

    // Actualizar préstamo
    $prestamo->update($request->all());

    // Regenerar plan de pagos
    $this->generarPlanPagos($prestamo);

    return redirect()->route('admin.prestamos.index')
        ->with('success', 'Préstamo actualizado y capital ajustado correctamente.');
}


    public function store(Request $request)
    {
        $request->validate([
            'usuario_id' => 'required|exists:usuarios,id',
            'monto' => 'required|numeric|min:1',
            'tasa_interes_mensual' => 'required|numeric|min:0',
            'plazo_meses' => 'required|integer|min:1|max:3',
            'frecuencia_pago' => 'required|in:diario,semanal,quincenal,mensual',
            'fecha_desembolso' => 'required|date',
            'referencia_celular' => 'nullable|string|max:20',
        ]);

        // Verificar capital disponible
        $capital = Capital::latest()->first();
        $montoPrestamo = $request->monto;

        if (!$capital || $capital->monto_actual < $montoPrestamo) {
            return back()->with('error', 'No hay suficiente capital disponible para este préstamo');
        }

        // Crear el préstamo
        $prestamo = Prestamo::create([
            'codigo' => 'PRE-' . Str::upper(Str::random(6)),
            'usuario_id' => $request->usuario_id,
            'monto' => $montoPrestamo,
            'tasa_interes_mensual' => $request->tasa_interes_mensual,
            'plazo_meses' => $request->plazo_meses,
            'frecuencia_pago' => $request->frecuencia_pago,
            'fecha_desembolso' => $request->fecha_desembolso,
            'estado' => 'vigente',
            'referencia_celular' => $request->referencia_celular,
        ]);

        // Actualizar el capital
        Capital::create([
            'monto_inicial' => -$montoPrestamo,
            'monto_actual' => $capital->monto_actual - $montoPrestamo,
            'descripcion' => "Préstamo a " . $prestamo->usuario->nombre_completo . " (ID: $prestamo->id)",
            'usuario_id' => Auth::id()
        ]);

        // Generar plan de pagos
        $this->generarPlanPagos($prestamo);

        return redirect()->route('admin.prestamos.index')
            ->with('success', 'Préstamo registrado correctamente con plan de pagos generado.');
    }

    public function cancelar($id)
    {
        $prestamo = Prestamo::findOrFail($id);
        
        // Reintegrar capital si el préstamo estaba activo
        if ($prestamo->estado == 'vigente') {
            $capital = Capital::latest()->first();
            
            Capital::create([
                'monto_inicial' => $prestamo->monto,
                'monto_actual' => $capital->monto_actual + $prestamo->monto,
                'descripcion' => "Cancelación préstamo ID: $prestamo->id",
                'usuario_id' => Auth::id()
            ]);
        }

        $prestamo->update(['estado' => 'cancelado']);

        return back()->with('success', 'Préstamo cancelado y capital reintegrado');
    }

    private function generarPlanPagos($prestamo)
    {
        // Eliminar planes de pago existentes si los hubiera
        PlanPago::where('prestamo_id', $prestamo->id)->delete();

        $monto = $prestamo->monto;
        $tasaInteres = $prestamo->tasa_interes_mensual / 100;
        $plazo = $prestamo->plazo_meses;
        $fechaInicio = Carbon::parse($prestamo->fecha_desembolso);
        
        // Calcular número de cuotas según frecuencia
        switch($prestamo->frecuencia_pago) {
            case 'diario':
                $numCuotas = $plazo * 30;
                $intervalo = '1 day';
                break;
            case 'semanal':
                $numCuotas = $plazo * 4;
                $intervalo = '1 week';
                break;
            case 'quincenal':
                $numCuotas = $plazo * 2;
                $intervalo = '15 days';
                break;
            case 'mensual':
                $numCuotas = $plazo;
                $intervalo = '1 month';
                break;
        }

        // Calcular cuota usando sistema francés (cuota fija)
        $tasaPeriodo = $tasaInteres / ($numCuotas / $plazo);
        $cuota = $monto * ($tasaPeriodo * pow(1 + $tasaPeriodo, $numCuotas)) / (pow(1 + $tasaPeriodo, $numCuotas) - 1);

        $saldo = $monto;
        $fechaPago = $fechaInicio->copy();

        for ($i = 1; $i <= $numCuotas; $i++) {
            $fechaPago->add($intervalo);
            
            $interes = $saldo * $tasaPeriodo;
            $capital = $cuota - $interes;
            $saldo -= $capital;

            PlanPago::create([
                'prestamo_id' => $prestamo->id,
                'numero_cuota' => $i,
                'fecha_vencimiento' => $fechaPago->format('Y-m-d'),
                'monto_cuota' => $cuota,
                'capital' => $capital,
                'interes' => $interes,
                'saldo' => max($saldo, 0),
                'estado' => 'pendiente'
            ]);
        }
    }

    public function showPlanPagos($id)
{
    $prestamo = Prestamo::with(['usuario', 'planPagos.mora'])->findOrFail($id);

    foreach ($prestamo->planPagos as $cuota) {
        if ($cuota->estado === 'pendiente' && $cuota->fecha_vencimiento->lt(now()->subDays(3))) {
            if (!$cuota->mora) {
                $diasMora = max(0, (int) now()->diffInDays(Carbon::parse($cuota->fecha_vencimiento), false));
                $interesMora = $cuota->monto_cuota * 0.05 + ($diasMora - 3) * 2; // ejemplo

                Mora::create([
                    'plan_pago_id' => $cuota->id,
                    'interes_mora' => $interesMora,
                    'estado' => 'activa',
                    'dias_atraso' => $diasMora,
                    'fecha_calculo' => now()
                ]);

                $cuota->update(['estado' => 'mora']);
            }
        }
    }

    return view('admin.prestamos.plan-pagos', compact('prestamo'));
}

    public function generarPlanPagosPDF($id)
    {
        $prestamo = Prestamo::with(['usuario', 'planPagos'])->findOrFail($id);
        $pdf = Pdf::loadView('admin.prestamos.pdf.plan-pagos', compact('prestamo'));
        return $pdf->download("plan-pagos-{$prestamo->codigo}.pdf");
    }

    public function generarContratoPDF($id)
    {
        $prestamo = \App\Models\Prestamo::with('usuario')->findOrFail($id);
        $prestamista = Auth::user(); // quien está generando el contrato

        $pdf = Pdf::loadView('admin.contratos.contrato-pdf', compact('prestamo', 'prestamista'));
        return $pdf->download("contrato-prestamo-{$prestamo->codigo}.pdf");
    }

}