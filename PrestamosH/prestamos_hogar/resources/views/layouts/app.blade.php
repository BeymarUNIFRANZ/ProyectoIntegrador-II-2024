<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel | Sistema de Préstamos</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <meta name="csrf-token" content="{{ csrf_token() }}">
</head>
<body class="bg-slate-50 font-inter">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="hidden md:flex md:w-64 md:flex-col">
            <div class="flex flex-col flex-grow pt-5 overflow-y-auto bg-white border-r border-slate-200 shadow-sm">
                <!-- Logo -->
                <div class="flex items-center flex-shrink-0 px-6 pb-6">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"></path>
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-xl font-bold text-slate-900">PréstamosFácil</h1>
                            <p class="text-xs text-slate-500">Sistema de Gestión</p>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <nav class="flex-1 px-4 pb-4 space-y-1">
                    @auth
                        @if(auth()->user()->rol->nombre === 'admin')
                            <a href="{{ route('dashboard') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('dashboard') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
                                <svg class="mr-3 w-5 h-5 {{ request()->routeIs('dashboard') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5a2 2 0 012-2h4a2 2 0 012 2v6H8V5z"></path>
                                </svg>
                                Dashboard
                            </a>
                            
                            <a href="{{ route('admin.usuarios.index') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('admin.usuarios.*') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
                                <svg class="mr-3 w-5 h-5 {{ request()->routeIs('admin.usuarios.*') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                                </svg>
                                Usuarios
                            </a>
                            
                            <a href="{{ route('admin.prestamos.index') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('prestamos.*') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
                                <svg class="mr-3 w-5 h-5 {{ request()->routeIs('prestamos.*') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                </svg>
                                Préstamos
                            </a>

                               <a href="{{ route('admin.capital.index') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('admin.capital.*') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
        <svg class="mr-3 w-5 h-5 {{ request()->routeIs('admin.capital.*') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
        </svg>
        Capital
    </a>


                          <!-- DASHBOARD GESTOR -->
                        @elseif(auth()->user()->rol->nombre === 'gestor')
                            <a href="{{ route('gestor.dashboard') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('gestor.dashboard') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
                                <svg class="mr-3 w-5 h-5 {{ request()->routeIs('gestor.dashboard') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                                Dashboard
                            </a>
                            <!-- DASHBOARD USUARIOS -->
                        @else
                            <a href="{{ route('usuario.dashboard') }}" class="group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-all duration-200 {{ request()->routeIs('usuario.dashboard') ? 'bg-blue-50 text-blue-700 border-r-2 border-blue-700' : 'text-slate-700 hover:bg-slate-50 hover:text-slate-900' }}">
                                <svg class="mr-3 w-5 h-5 {{ request()->routeIs('usuario.dashboard') ? 'text-blue-600' : 'text-slate-400 group-hover:text-slate-500' }}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                                Mi Préstamo
                            </a>
                        @endif

                        <!-- Divider -->
                        <div class="pt-4 mt-4 border-t border-slate-200">
                            <div class="px-3 py-2">
                                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Cuenta</p>
                            </div>
                        </div>

                        <!-- User Profile -->
                        <div class="px-3 py-2">
                            <div class="flex items-center space-x-3 p-2 rounded-lg bg-slate-50">
                                <div class="w-8 h-8 bg-gradient-to-br from-slate-400 to-slate-500 rounded-full flex items-center justify-center">
                                    <span class="text-xs font-medium text-white">{{ substr(auth()->user()->nombre_completo, 0, 2) }}</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-medium text-slate-900 truncate">{{ auth()->user()->nombre_completo }}</p>
                                    <p class="text-xs text-slate-500 truncate">{{ auth()->user()->rol->nombre }}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Logout -->
                        <form method="POST" action="{{ route('logout') }}" class="mt-2">
                            @csrf
                            <button type="submit" class="group flex items-center w-full px-3 py-2.5 text-sm font-medium text-red-600 rounded-lg hover:bg-red-50 hover:text-red-700 transition-all duration-200">
                                <svg class="mr-3 w-5 h-5 text-red-500 group-hover:text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                </svg>
                                Cerrar Sesión
                            </button>
                        </form>
                    @endauth
                </nav>
            </div>
        </aside>

        <!-- Mobile sidebar -->
        <div class="md:hidden">
            <div class="fixed inset-0 flex z-40" id="mobile-menu" style="display: none;">
                <div class="fixed inset-0 bg-slate-600 bg-opacity-75" onclick="toggleMobileMenu()"></div>
                <div class="relative flex-1 flex flex-col max-w-xs w-full bg-white">
                    <div class="absolute top-0 right-0 -mr-12 pt-2">
                        <button type="button" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white" onclick="toggleMobileMenu()">
                            <svg class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                    <!-- Mobile navigation content (same as desktop) -->
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="flex flex-col flex-1 overflow-hidden">
            <!-- Top bar -->
            <header class="bg-white border-b border-slate-200 shadow-sm">
                <div class="flex items-center justify-between px-4 py-3 sm:px-6 lg:px-8">
                    <div class="flex items-center">
                        <button type="button" class="md:hidden -ml-0.5 -mt-0.5 h-12 w-12 inline-flex items-center justify-center rounded-md text-slate-500 hover:text-slate-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500" onclick="toggleMobileMenu()">
                            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                            </svg>
                        </button>
                        <h1 class="ml-2 text-lg font-semibold text-slate-900">@yield('page-title', 'Dashboard')</h1>
                    </div>
                    
                    <div class="flex items-center space-x-4">
                        <!-- Notifications -->
                       <a href="{{ route('admin.notificaciones.index') }}" 
   class="p-2 text-slate-400 hover:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 rounded-lg">
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM10.5 3.75a6 6 0 0 1 6 6v2.25l2.25 2.25v2.25H2.25V14.25L4.5 12V9.75a6 6 0 0 1 6-6z"></path>
    </svg>
</a>

                        
                        <!-- User menu -->
                        <div class="relative">
                            <div class="flex items-center space-x-3">
                                <span class="text-sm font-medium text-slate-700 hidden sm:block">{{ auth()->user()->nombre_completo }}</span>
                                <div class="w-8 h-8 bg-gradient-to-br from-blue-400 to-blue-500 rounded-full flex items-center justify-center">
                                    <span class="text-xs font-medium text-white">{{ substr(auth()->user()->nombre_completo, 0, 2) }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Main content area -->
            <main class="flex-1 overflow-y-auto bg-slate-50">
                <div class="py-6">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        @yield('content')
                    </div>
                </div>
            </main>
        </div>
    </div>

<!-- Notificaciones en el sidebar -->
<div class="mt-auto px-4 py-3 border-t border-slate-200">
    <div x-data="{ open: false }" class="relative">
        <button @click="open = !open" class="flex items-center w-full text-left group">
            <svg class="w-5 h-5 mr-3 text-slate-400 group-hover:text-slate-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
            </svg>
            <span class="flex-1">Notificaciones</span>
            @auth
                @if(auth()->user()->notificacionesNoLeidas->count() > 0)
                    <span class="bg-red-500 text-white text-xs rounded-full px-2 py-1">
                        {{ auth()->user()->notificacionesNoLeidas->count() }}
                    </span>
                @endif
            @endauth
        </button>
        
        <!-- Panel de notificaciones -->
        <div x-show="open" @click.away="open = false" class="absolute bottom-full mb-2 left-0 w-64 bg-white rounded-lg shadow-lg border border-slate-200 z-10">
            <div class="p-3 border-b border-slate-200 font-semibold">Notificaciones recientes</div>
            <div class="max-h-60 overflow-y-auto">
                @forelse(auth()->user()->notificaciones->take(5) as $notif)
                <div class="p-3 border-b border-slate-100 hover:bg-slate-50 {{ $notif->leida ? '' : 'bg-blue-50' }}">
                    <div class="flex justify-between">
                        <p class="text-sm">{{ $notif->mensaje }}</p>
                        @if(!$notif->leida)
                        <button onclick="marcarLeida({{ $notif->id }})" class="text-xs text-blue-600">✓</button>
                        @endif
                    </div>
                    <p class="text-xs text-slate-500 mt-1">{{ $notif->created_at->diffForHumans() }}</p>
                </div>
                @empty
                <div class="p-3 text-center text-sm text-slate-500">No hay notificaciones</div>
                @endforelse
            </div>
            <a href="{{ route('admin.notificaciones.index') }}" class="text-blue-600 text-sm">Ver todas</a>
        </div>
    </div>
</div>

<script>
function marcarLeida(id) {
    fetch(`/notificaciones/${id}/leida`, {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': '{{ csrf_token() }}',
            'Accept': 'application/json'
        }
    }).then(() => window.location.reload());
}
</script>



<script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script>
        function toggleMobileMenu() {
            const menu = document.getElementById('mobile-menu');
            menu.style.display = menu.style.display === 'none' ? 'flex' : 'none';
        }
    </script>
</body>
</html>
