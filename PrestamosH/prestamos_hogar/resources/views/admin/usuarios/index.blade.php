@extends('layouts.app')

@section('page-title', 'Gestión de Usuarios')

@section('content')
<div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold text-slate-900">Usuarios Registrados</h1>
            <p class="mt-1 text-sm text-slate-600">Gestiona todos los usuarios del sistema</p>
        </div>
        <a href="{{ route('admin.usuarios.create') }}" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200 flex items-center space-x-2">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
            </svg>
            <span>Nuevo Usuario</span>
        </a>
    </div>

    <!-- Filters -->
    <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-2">Buscar</label>
                <input type="text" placeholder="Nombre o correo..." class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200">
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-2">Rol</label>
                <select class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200">
                    <option value="">Todos los roles</option>
                    <option value="admin">Administrador</option>
                    <option value="gestor">Gestor</option>
                    <option value="usuario">Usuario</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-2">Estado</label>
                <select class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200">
                    <option value="">Todos</option>
                    <option value="activo">Activo</option>
                    <option value="inactivo">Inactivo</option>
                </select>
            </div>
            <div class="flex items-end">
                <button class="w-full bg-slate-600 hover:bg-slate-700 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200">
                    Filtrar
                </button>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-600">Total Usuarios</p>
                    <p class="text-2xl font-bold text-slate-900 mt-1">{{ $usuarios->total() }}</p>
                </div>
                <div class="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-600">Administradores</p>
                    <p class="text-2xl font-bold text-slate-900 mt-1">{{ $usuarios->where('rol.nombre', 'admin')->count() }}</p>
                </div>
                <div class="w-10 h-10 bg-purple-50 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-600">Gestores</p>
                    <p class="text-2xl font-bold text-slate-900 mt-1">{{ $usuarios->where('rol.nombre', 'gestor')->count() }}</p>
                </div>
                <div class="w-10 h-10 bg-green-50 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-slate-600">Clientes</p>
                    <p class="text-2xl font-bold text-slate-900 mt-1">{{ $usuarios->where('rol.nombre', 'usuario')->count() }}</p>
                </div>
                <div class="w-10 h-10 bg-orange-50 rounded-lg flex items-center justify-center">
                    <svg class="w-5 h-5 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                </div>
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
        <div class="px-6 py-4 border-b border-slate-200">
            <div class="flex items-center justify-between">
                <h3 class="text-lg font-semibold text-slate-900">Lista de Usuarios</h3>
                <div class="flex items-center space-x-2">
                    <button class="p-2 text-slate-400 hover:text-slate-600 transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
                        </svg>
                    </button>
                    <button class="p-2 text-slate-400 hover:text-slate-600 transition-colors duration-200">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="text-left py-3 px-6 font-medium text-slate-600 text-sm">Usuario</th>
                        <th class="text-left py-3 px-6 font-medium text-slate-600 text-sm">Información</th>
                        <th class="text-left py-3 px-6 font-medium text-slate-600 text-sm">Rol</th>
                        <th class="text-left py-3 px-6 font-medium text-slate-600 text-sm">Estado</th>
                        <th class="text-left py-3 px-6 font-medium text-slate-600 text-sm">Registro</th>
                        <th class="text-right py-3 px-6 font-medium text-slate-600 text-sm">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-200">
                    @forelse($usuarios as $usuario)
                        <tr class="hover:bg-slate-50 transition-colors duration-200">
                            <!-- Usuario -->
                            <td class="py-4 px-6">
                                <div class="flex items-center space-x-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-blue-500 rounded-full flex items-center justify-center">
                                        <span class="text-sm font-medium text-white">{{ substr($usuario->nombre_completo, 0, 2) }}</span>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-slate-900">{{ $usuario->nombre_completo }}</p>
                                        <p class="text-sm text-slate-500">{{ $usuario->correo }}</p>
                                    </div>
                                </div>
                            </td>

                            <!-- Información -->
                            <td class="py-4 px-6">
                                <div>
                                    <p class="text-sm text-slate-900">CI: {{ $usuario->ci }}</p>
                                    <p class="text-sm text-slate-500">Tel: {{ $usuario->telefono ?? 'No registrado' }}</p>
                                </div>
                            </td>

                            <!-- Rol -->
                            <td class="py-4 px-6">
                                @php
                                    $rolColors = [
                                        'admin' => 'bg-purple-100 text-purple-800',
                                        'gestor' => 'bg-green-100 text-green-800',
                                        'usuario' => 'bg-blue-100 text-blue-800'
                                    ];
                                    $rolColor = $rolColors[$usuario->rol->nombre] ?? 'bg-gray-100 text-gray-800';
                                @endphp
                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium {{ $rolColor }}">
                                    {{ ucfirst($usuario->rol->nombre) }}
                                </span>
                            </td>

                            <!-- Estado -->
                            <td class="py-4 px-6">
                                @if($usuario->activo ?? true)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                        <svg class="w-1.5 h-1.5 mr-1.5" fill="currentColor" viewBox="0 0 8 8">
                                            <circle cx="4" cy="4" r="3"/>
                                        </svg>
                                        Activo
                                    </span>
                                @else
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                        <svg class="w-1.5 h-1.5 mr-1.5" fill="currentColor" viewBox="0 0 8 8">
                                            <circle cx="4" cy="4" r="3"/>
                                        </svg>
                                        Inactivo
                                    </span>
                                @endif
                            </td>

                            <!-- Registro -->
                            <td class="py-4 px-6">
                                <div>
                                    <p class="text-sm text-slate-900">{{ $usuario->created_at->format('d/m/Y') }}</p>
                                    <p class="text-sm text-slate-500">{{ $usuario->created_at->format('H:i') }}</p>
                                </div>
                            </td>

                            <!-- Acciones -->
                            <td class="py-4 px-6 text-right">
                                <div class="flex items-center justify-end space-x-2">
                                    <button class="p-2 text-slate-400 hover:text-blue-600 transition-colors duration-200" title="Ver detalles">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                    </button>
                                    
                                    <a href="{{ route('admin.usuarios.edit', $usuario->id) }}" class="p-2 text-slate-400 hover:text-green-600 transition-colors duration-200" title="Editar">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                        </svg>
                                    </a>

                                    <div class="relative" x-data="{ open: false }">
                                        <button @click="open = !open" class="p-2 text-slate-400 hover:text-slate-600 transition-colors duration-200" title="Más opciones">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"></path>
                                            </svg>
                                        </button>
                                        
                                        <div x-show="open" @click.away="open = false" x-transition class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-slate-200 py-1 z-10">
                                            <a href="#" class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50">Ver préstamos</a>
                                            <a href="#" class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50">Historial</a>
                                            <div class="border-t border-slate-200 my-1"></div>
                                            <button class="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50">Desactivar</button>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="py-12 text-center">
                                <div class="flex flex-col items-center">
                                    <svg class="w-12 h-12 text-slate-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                                    </svg>
                                    <h3 class="text-lg font-medium text-slate-900 mb-2">No hay usuarios registrados</h3>
                                    <p class="text-slate-500 mb-4">Comienza agregando el primer usuario al sistema</p>
                                    <a href="{{ route('admin.usuarios.create') }}" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-medium transition-colors duration-200">
                                        Crear Usuario
                                    </a>
                                </div>
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        @if($usuarios->hasPages())
            <div class="px-6 py-4 border-t border-slate-200 bg-slate-50">
                <div class="flex items-center justify-between">
                    <div class="text-sm text-slate-600">
                        Mostrando {{ $usuarios->firstItem() }} a {{ $usuarios->lastItem() }} de {{ $usuarios->total() }} resultados
                    </div>
                    <div class="flex items-center space-x-2">
                        {{ $usuarios->links() }}
                    </div>
                </div>
            </div>
        @endif
    </div>
</div>

<!-- Alpine.js for dropdowns -->
<script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
@endsection
