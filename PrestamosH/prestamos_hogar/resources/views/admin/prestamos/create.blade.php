@extends('layouts.app')

@section('page-title', 'Registrar Nuevo Préstamo')

@section('content')
<div class="max-w-4xl mx-auto space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold text-slate-900">Registrar Nuevo Préstamo</h1>
            <p class="mt-1 text-sm text-slate-600">Completa la información para registrar un nuevo préstamo en el sistema</p>
        </div>
        <a href="{{ route('admin.prestamos.index') }}" class="bg-slate-600 hover:bg-slate-700 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200 flex items-center space-x-2">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
            </svg>
            <span>Volver</span>
        </a>
    </div>

    <!-- Form Card -->
    <div class="bg-white rounded-xl shadow-sm border border-slate-200">
        <div class="px-6 py-4 border-b border-slate-200">
            <h3 class="text-lg font-semibold text-slate-900">Información del Préstamo</h3>
            <p class="text-sm text-slate-600">Los campos marcados con * son obligatorios</p>
            <div class="mt-2 bg-blue-50 border-l-4 border-blue-500 p-2 rounded-r">
                <div class="flex items-center">
                    <svg class="w-5 h-5 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span class="font-medium text-blue-800">Capital disponible: Bs. {{ number_format($capitalDisponible, 2) }}</span>
                </div>
            </div>
        </div>

        <form method="POST" action="{{ route('admin.prestamos.store') }}" class="p-6 space-y-6">
            @csrf

            @if($errors->any())
                <div class="p-4 bg-red-50 border border-red-200 rounded-lg">
                    <div class="flex items-center mb-2">
                        <svg class="w-5 h-5 text-red-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                        </svg>
                        <span class="text-red-800 font-medium">Por favor corrige los siguientes errores:</span>
                    </div>
                    <ul class="text-sm text-red-700 list-disc list-inside">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <!-- Cliente Section -->
            <div class="space-y-6">
                <div class="border-l-4 border-blue-500 pl-4">
                    <h4 class="text-lg font-medium text-slate-900">Información del Cliente</h4>
                    <p class="text-sm text-slate-600">Selecciona el usuario que solicita el préstamo</p>
                </div>

                <div class="space-y-2">
                    <label for="usuario_id" class="block text-sm font-medium text-slate-700">
                        Seleccionar Cliente *
                    </label>
                    <select name="usuario_id" id="usuario_id" required
                            class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('usuario_id') border-red-300 @enderror">
                        <option value="">-- Seleccione un cliente --</option>
                        @foreach($usuarios as $usuario)
                            <option value="{{ $usuario->id }}" data-ci="{{ $usuario->carnet_identidad }}" {{ old('usuario_id') == $usuario->id ? 'selected' : '' }}>
                                {{ $usuario->nombre_completo }} - CI: {{ $usuario->carnet_identidad }}
                            </option>
                        @endforeach
                    </select>
                    @error('usuario_id')
                        <p class="text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>
            </div>

            <!-- Detalles del Préstamo -->
            <div class="space-y-6">
                <div class="border-l-4 border-green-500 pl-4">
                    <h4 class="text-lg font-medium text-slate-900">Términos del Préstamo</h4>
                    <p class="text-sm text-slate-600">Define los montos, plazos y condiciones del préstamo</p>
                </div>

                <!-- Monto -->
                <div class="space-y-2">
                    <label for="monto" class="block text-sm font-medium text-slate-700">
                        Monto del Préstamo (Bs.) *
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="text-gray-500">Bs.</span>
                        </div>
                        <input type="number" name="monto" id="monto" step="0.01" min="1" 
                               max="{{ $capitalDisponible }}" value="{{ old('monto') }}"
                               class="pl-10 w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('monto') border-red-300 @enderror"
                               required
                               oninput="validarMonto(this)">
                        @error('monto')
                            <p class="text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>
                    <div id="monto-error" class="hidden mt-1 text-sm text-red-600"></div>
                    <div id="capital-restante" class="mt-4 p-3 bg-red-50 border border-red-300 text-red-800 rounded-md flex items-start space-x-3">
    <svg class="w-5 h-5 mt-1 text-red-600 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
    </svg>
    <div>
        <p class="font-semibold">Capital restante:</p>
        <p class="text-lg font-bold">Bs. {{ number_format($capitalDisponible, 2) }}</p>
        <p class="text-xs text-red-500 mt-1">Este valor determina si es posible otorgar nuevos préstamos.</p>
    </div>
</div>

                </div>

                <!-- Tasa y Plazo -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Tasa de interés -->
                    <div class="space-y-2">
                        <label for="tasa_interes_mensual" class="block text-sm font-medium text-slate-700">
                            Tasa de Interés Mensual (%) *
                        </label>
                        <div class="relative">
                            <input type="number" name="tasa_interes_mensual" id="tasa_interes_mensual" 
                                   value="{{ old('tasa_interes_mensual', 5) }}" step="0.01" min="0" max="100" required
                                   class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('tasa_interes_mensual') border-red-300 @enderror">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                <span class="text-gray-500">%</span>
                            </div>
                        </div>
                        @error('tasa_interes_mensual')
                            <p class="text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>

                    <!-- Plazo -->
                    <div class="space-y-2">
                        <label for="plazo_meses" class="block text-sm font-medium text-slate-700">
                            Plazo (meses) *
                        </label>
                        <select name="plazo_meses" id="plazo_meses" required
                                class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('plazo_meses') border-red-300 @enderror">
                            <option value="1" {{ old('plazo_meses') == 1 ? 'selected' : '' }}>1 mes</option>
                            <option value="2" {{ old('plazo_meses') == 2 ? 'selected' : '' }}>2 meses</option>
                            <option value="3" {{ old('plazo_meses') == 3 ? 'selected' : '' }} selected>3 meses</option>
                        </select>
                        @error('plazo_meses')
                            <p class="text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>
                </div>

                <!-- Frecuencia y Fecha -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Frecuencia de pago -->
                    <div class="space-y-2">
                        <label for="frecuencia_pago" class="block text-sm font-medium text-slate-700">
                            Frecuencia de Pago *
                        </label>
                        <select name="frecuencia_pago" id="frecuencia_pago" required
                                class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('frecuencia_pago') border-red-300 @enderror">
                            <option value="diario" {{ old('frecuencia_pago') == 'diario' ? 'selected' : '' }}>Diario</option>
                            <option value="semanal" {{ old('frecuencia_pago') == 'semanal' ? 'selected' : '' }}>Semanal</option>
                            <option value="quincenal" {{ old('frecuencia_pago') == 'quincenal' ? 'selected' : '' }} selected>Quincenal</option>
                            <option value="mensual" {{ old('frecuencia_pago') == 'mensual' ? 'selected' : '' }}>Mensual</option>
                        </select>
                        @error('frecuencia_pago')
                            <p class="text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>

                    <!-- Fecha de desembolso -->
                    <div class="space-y-2">
                        <label for="fecha_desembolso" class="block text-sm font-medium text-slate-700">
                            Fecha de Desembolso *
                        </label>
                        <input type="date" name="fecha_desembolso" id="fecha_desembolso" 
                               value="{{ old('fecha_desembolso', date('Y-m-d')) }}"
                               class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('fecha_desembolso') border-red-300 @enderror"
                               required>
                        @error('fecha_desembolso')
                            <p class="text-sm text-red-600">{{ $message }}</p>
                        @enderror
                    </div>
                </div>

                <!-- Referencia celular -->
                <div class="space-y-2">
                    <label for="referencia_celular" class="block text-sm font-medium text-slate-700">
                        Teléfono de Referencia
                    </label>
                    <input type="text" name="referencia_celular" id="referencia_celular"
                           value="{{ old('referencia_celular') }}"
                           placeholder="Ej: 70012345"
                           class="w-full px-3 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200 @error('referencia_celular') border-red-300 @enderror">
                    @error('referencia_celular')
                        <p class="text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>
            </div>

            <!-- Resumen del Préstamo -->
            <div class="bg-blue-50 p-4 rounded-lg border border-blue-200">
                <h4 class="text-lg font-medium text-blue-800 mb-3">Resumen del Préstamo</h4>
                <div class="grid grid-cols-2 gap-4 text-sm">
                    <div class="text-slate-600">Monto solicitado:</div>
                    <div id="resumen-monto" class="font-medium text-right">Bs. 0.00</div>
                    
                    <div class="text-slate-600">Tasa de interés:</div>
                    <div id="resumen-interes" class="font-medium text-right">5% mensual</div>
                    
                    <div class="text-slate-600">Plazo total:</div>
                    <div id="resumen-plazo" class="font-medium text-right">3 meses</div>
                    
                    <div class="text-slate-600">Frecuencia de pagos:</div>
                    <div id="resumen-frecuencia" class="font-medium text-right">Quincenal</div>
                    
                    <div class="text-slate-600">Número de cuotas:</div>
                    <div id="resumen-cuotas" class="font-medium text-right">6</div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex items-center justify-end space-x-4 pt-6 border-t border-slate-200">
                <a href="{{ route('admin.prestamos.index') }}" class="px-6 py-3 bg-slate-100 hover:bg-slate-200 text-slate-700 font-medium rounded-lg transition-colors duration-200">
                    Cancelar
                </a>
                <button type="submit" id="submit-btn"
                        class="px-6 py-3 bg-green-600 hover:bg-green-700 text-white font-medium rounded-lg transition-colors duration-200 flex items-center space-x-2 disabled:opacity-50 disabled:cursor-not-allowed">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Registrar Préstamo</span>
                </button>
            </div>
        </form>
    </div>
</div>

<script>
// Validación en tiempo real del monto
function validarMonto(input) {
    const monto = parseFloat(input.value) || 0;
    const capitalDisponible = parseFloat("{{ $capitalDisponible }}");
    const errorElement = document.getElementById('monto-error');
    const submitBtn = document.getElementById('submit-btn');
    const capitalRestante = document.getElementById('capital-restante');

    if (monto > capitalDisponible) {
        errorElement.textContent = 'El monto excede el capital disponible';
        errorElement.classList.remove('hidden');
        submitBtn.disabled = true;
    } else {
        errorElement.classList.add('hidden');
        submitBtn.disabled = false;
    }

    // Actualizar capital restante
    const restante = capitalDisponible - monto;
    capitalRestante.textContent = `Capital restante después del préstamo: Bs. ${restante.toLocaleString('es-BO', {minimumFractionDigits: 2})}`;

    // Actualizar resumen
    actualizarResumen();
}

// Calcular número de cuotas
function calcularCuotas() {
    const plazo = parseInt(document.getElementById('plazo_meses').value);
    const frecuencia = document.getElementById('frecuencia_pago').value;
    
    switch(frecuencia) {
        case 'diario': return plazo * 30;
        case 'semanal': return plazo * 4;
        case 'quincenal': return plazo * 2;
        case 'mensual': return plazo;
        default: return plazo;
    }
}

// Actualizar resumen del préstamo
function actualizarResumen() {
    const monto = parseFloat(document.getElementById('monto').value) || 0;
    const tasa = document.getElementById('tasa_interes_mensual').value;
    const plazo = document.getElementById('plazo_meses').value;
    const frecuencia = document.getElementById('frecuencia_pago');
    const frecuenciaText = frecuencia.options[frecuencia.selectedIndex].text;
    const cuotas = calcularCuotas();
    
    document.getElementById('resumen-monto').textContent = 
        `Bs. ${monto.toLocaleString('es-BO', {minimumFractionDigits: 2})}`;
    
    document.getElementById('resumen-interes').textContent = 
        `${tasa}% mensual`;
    
    document.getElementById('resumen-plazo').textContent = 
        `${plazo} meses`;
    
    document.getElementById('resumen-frecuencia').textContent = 
        frecuenciaText;
        
    document.getElementById('resumen-cuotas').textContent = 
        cuotas;
}

// Event listeners para actualizar el resumen
document.getElementById('tasa_interes_mensual').addEventListener('input', actualizarResumen);
document.getElementById('plazo_meses').addEventListener('change', actualizarResumen);
document.getElementById('frecuencia_pago').addEventListener('change', actualizarResumen);
document.getElementById('monto').addEventListener('input', actualizarResumen);

// Inicializar el resumen al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    actualizarResumen();
    
    // Validar monto inicial si hay valor
    const montoInput = document.getElementById('monto');
    if (montoInput.value) {
        validarMonto(montoInput);
    }
});
</script>
@endsection