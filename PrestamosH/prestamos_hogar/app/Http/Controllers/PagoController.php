<?php

namespace App\Http\Controllers;

use App\Models\{Pago, PlanPago, Capital, Mora};
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{Storage, Auth};
use Carbon\Carbon;

class PagoController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'plan_pago_id' => 'required|exists:plan_pagos,id',
            'fecha_pago' => 'required|date',
            'monto' => 'required|numeric|min:0.01',
            'metodo_pago' => 'required|in:efectivo,transferencia,cheque,deposito,otro',
            'comprobante' => 'nullable|file|mimes:jpg,png,pdf|max:2048',
            'observaciones' => 'nullable|string|max:500'
        ]);

        try {
            $planPago = PlanPago::with(['prestamo', 'mora'])->findOrFail($request->plan_pago_id);
            $fechaVenc = Carbon::parse($planPago->fecha_vencimiento);
            $fechaPago = Carbon::parse($request->fecha_pago);
            $diasEnMora = $fechaVenc->diffInDays($fechaPago, false);

            $interesMora = 0;
            $tasaMoraDiaria = 2; // % diario
            if ($diasEnMora > 3 && !$planPago->mora) {
                $interesMora = $planPago->monto_cuota * ($tasaMoraDiaria / 100) * $diasEnMora;
                Mora::create([
                    'plan_pago_id' => $planPago->id,
                    'fecha_mora' => now(),
                    'dias_en_mora' => $diasEnMora,
                    'interes_mora' => $interesMora,
                    'tasa_mora_diaria' => $tasaMoraDiaria,
                    'estado' => 'activa'
                ]);
                $planPago->update(['estado' => 'mora']);
            } elseif ($planPago->mora && $planPago->mora->estado === 'activa') {
                $interesMora = $planPago->mora->interes_mora;
            }

            // Guardar comprobante si existe
            $comprobantePath = null;
            if ($request->hasFile('comprobante')) {
                $comprobantePath = $request->file('comprobante')->store('comprobantes', 'public');
            }

            // Registrar el pago
            $pago = Pago::create([
                'plan_pago_id' => $planPago->id,
                'monto' => $request->monto,
                'fecha_pago' => $request->fecha_pago,
                'metodo_pago' => $request->metodo_pago,
                'comprobante' => $comprobantePath,
                'observaciones' => $request->observaciones,
                'usuario_registrador_id' => Auth::id()
            ]);

            // Actualizar capital
            $capital = Capital::latest()->first();
            Capital::create([
                'monto_inicial' => $request->monto,
                'monto_actual' => $capital->monto_actual + $request->monto,
                'descripcion' => "Pago cuota #{$planPago->numero_cuota} - Préstamo {$planPago->prestamo->codigo}" . ($interesMora > 0 ? " (con mora)" : ""),
                'usuario_id' => Auth::id()
            ]);

            // Actualizar estado de la cuota
            $totalPagado = $planPago->pagos()->sum('monto');
            $totalDeuda = $planPago->monto_cuota + $interesMora;

            if ($totalPagado >= $totalDeuda) {
                $planPago->update([
                    'estado' => 'pagado',
                    'fecha_pago' => $request->fecha_pago
                ]);

                if ($planPago->mora && $planPago->mora->estado === 'activa') {
                $planPago->mora->update(['estado' => 'inactiva']);
                 }

            }

            return response()->json([
                'success' => true,
                'message' => 'Pago registrado correctamente',
                'pago' => $pago
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al registrar el pago: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        $pago = Pago::with(['planPago.prestamo.usuario', 'usuarioRegistrador'])->findOrFail($id);
        return response()->json($pago);
    }

    public function detalleCuota($id)
{
    $cuota = \App\Models\PlanPago::with('mora')->findOrFail($id);

    $mora = $cuota->mora && $cuota->mora->estado === 'activa' ? $cuota->mora : null;
    $interesMora = $mora ? $mora->interes_mora : 0;

    return response()->json([
        'cuota_id' => $cuota->id,
        'monto_pendiente' => round($cuota->monto_cuota, 2),
        'interes_mora' => round($interesMora, 2),
        'total' => round($cuota->monto_cuota + $interesMora, 2),
        'estado' => $cuota->estado,
        'mora' => $mora
    ]);
}

}
