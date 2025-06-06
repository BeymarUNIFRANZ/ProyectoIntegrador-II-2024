@extends('layouts.app')

@section('page-title', 'Gestión de Préstamos')

@section('content')
<div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold text-slate-900">Préstamos Registrados</h1>
            <p class="mt-1 text-sm text-slate-600">Listado general de préstamos realizados en el sistema</p>
        </div>
        <a href="{{ route('admin.prestamos.create') }}" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200 flex items-center space-x-2">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
            </svg>
            <span>Nuevo Préstamo</span>
        </a>
    </div>

    <!-- Tabla de préstamos -->
    <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Código</th>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Cliente</th>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Monto</th>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Plazo</th>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Estado</th>
                        <th class="text-left py-3 px-6 text-sm font-medium text-slate-600">Fecha</th>
                        <th class="text-right py-3 px-6 text-sm font-medium text-slate-600">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-200">
                    @forelse($prestamos as $prestamo)
                        <tr class="hover:bg-slate-50 transition">
                            <td class="py-4 px-6 text-slate-900">{{ $prestamo->codigo }}</td>
                            <td class="py-4 px-6">
                                <div class="text-sm font-medium text-slate-800">{{ $prestamo->usuario->nombre_completo }}</div>
                                <div class="text-sm text-slate-500">{{ $prestamo->usuario->correo }}</div>
                            </td>
                            <td class="py-4 px-6 text-green-600 font-semibold">Bs {{ number_format($prestamo->monto, 2) }}</td>
                            <td class="py-4 px-6 text-slate-700">{{ $prestamo->plazo_meses }} meses ({{ ucfirst($prestamo->frecuencia_pago) }})</td>
                            <td class="py-4 px-6">
                                @php
                                    $estadoColor = [
                                        'vigente' => 'bg-blue-100 text-blue-800',
                                        'cancelado' => 'bg-green-100 text-green-800',
                                        'mora' => 'bg-red-100 text-red-800'
                                    ][$prestamo->estado];
                                @endphp
                                <span class="px-2.5 py-0.5 text-xs font-medium rounded-full {{ $estadoColor }}">
                                    {{ ucfirst($prestamo->estado) }}
                                </span>
                            </td>
                            <td class="py-4 px-6 text-sm text-slate-600">
                                {{ \Carbon\Carbon::parse($prestamo->fecha_desembolso)->format('d/m/Y') }}
                            </td>
                            
                            <!-- Dentro de tu tabla -->
<td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
    <a href="{{ route('admin.prestamos.plan-pagos', $prestamo->id) }}" class="text-blue-600 hover:text-blue-900 mr-2">Plan de Pagos</a>
    <a href="{{ route('admin.prestamos.edit', $prestamo->id) }}" class="text-green-600 hover:text-green-900">Editar</a>
</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="text-center py-10 text-slate-500">
                                No hay préstamos registrados aún.
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if($prestamos->hasPages())
            <div class="px-6 py-4 border-t border-slate-200 bg-slate-50">
                {{ $prestamos->links() }}
            </div>
        @endif
    </div>
</div>
@endsection
