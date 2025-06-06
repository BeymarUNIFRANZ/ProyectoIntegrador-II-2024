<?php

namespace App\Http\Controllers;

use App\Models\Capital;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CapitalController extends Controller
{
   public function index()
{
    $capital = Capital::orderBy('created_at', 'desc')->first();
    $movimientos = Capital::latest()->take(10)->get();

    return view('admin.capital.index', compact('capital', 'movimientos'));
}


    public function store(Request $request)
    {
        $request->validate([
            'monto' => 'required|numeric|min:0',
            'descripcion' => 'nullable|string'
        ]);

        $capitalActual = Capital::latest()->first();
        $montoActual = $capitalActual ? $capitalActual->monto_actual : 0;

        Capital::create([
            'monto_inicial' => $request->monto,
            'monto_actual' => $montoActual + $request->monto,
            'descripcion' => $request->descripcion,
            'usuario_id' => Auth::id()
        ]);

        return redirect()->route('admin.capital.index')
            ->with('success', 'Capital actualizado correctamente');
    }

    public function retirar(Request $request)
    {
        $request->validate([
            'monto' => 'required|numeric|min:0',
            'descripcion' => 'nullable|string'
        ]);

        $capital = Capital::latest()->firstOrFail();

        if ($request->monto > $capital->monto_actual) {
            return back()->with('error', 'No hay suficiente capital disponible');
        }

        Capital::create([
            'monto_inicial' => -$request->monto,
            'monto_actual' => $capital->monto_actual - $request->monto,
            'descripcion' => $request->descripcion,
            'usuario_id' => Auth::id()
        ]);

        return redirect()->route('admin.capital.index')
            ->with('success', 'Retiro realizado correctamente');
    }
}