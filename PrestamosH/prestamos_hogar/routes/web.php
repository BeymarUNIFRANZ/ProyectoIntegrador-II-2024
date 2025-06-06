<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\AdminUsuarioController;
use App\Http\Controllers\PrestamoController;
use App\Http\Controllers\PlanPagoController;
use App\Http\Controllers\NotificacionController;
use App\Http\Controllers\CapitalController;
use App\Http\Controllers\PagoController;
use App\Models\PlanPago;
use App\Models\Mora;
use Carbon\Carbon;

// Ruta raíz redirige al login
Route::get('/', function () {
    return redirect()->route('login');
});

// ======================= AUTENTICACIÓN =======================
Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AuthController::class, 'login']);
Route::get('/register', [AuthController::class, 'showRegister'])->name('register');
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

// Dashboard genérico según rol
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [AuthController::class, 'dashboard'])->name('dashboard');
});

// ======================= RUTAS ADMINISTRADOR =======================
Route::middleware(['auth'])->prefix('admin')->name('admin.')->group(function () {

    // ---------- Usuarios ----------
    Route::prefix('usuarios')->name('usuarios.')->group(function () {
        Route::get('/', [AdminUsuarioController::class, 'index'])->name('index');
        Route::get('/crear', [AdminUsuarioController::class, 'create'])->name('create');
        Route::post('/', [AdminUsuarioController::class, 'store'])->name('store');
        Route::get('/{id}/editar', [AdminUsuarioController::class, 'edit'])->name('edit');
        Route::put('/{id}', [AdminUsuarioController::class, 'update'])->name('update');
    });

    // ---------- Préstamos ----------
    Route::prefix('prestamos')->name('prestamos.')->group(function () {
        Route::get('/', [PrestamoController::class, 'index'])->name('index');
        Route::get('/crear', [PrestamoController::class, 'create'])->name('create');
        Route::post('/', [PrestamoController::class, 'store'])->name('store');
        Route::get('/{id}/editar', [PrestamoController::class, 'edit'])->name('edit');
        Route::put('/{id}', [PrestamoController::class, 'update'])->name('update');
        Route::delete('/{id}', [PrestamoController::class, 'destroy'])->name('destroy');
        Route::get('/{id}/plan-pagos', [PrestamoController::class, 'showPlanPagos'])->name('plan-pagos');
        Route::get('/{id}/plan-pagos/pdf', [PrestamoController::class, 'generarPlanPagosPDF'])->name('plan-pagos.pdf');
    });

    // ---------- Planes de Pago ----------
    Route::prefix('plan-pagos')->name('plan-pagos.')->group(function () {
        Route::get('/{id}/monto', [PlanPagoController::class, 'getMontoCuota']);
        Route::post('/pagar', [PlanPagoController::class, 'registrarPago'])->name('pagar');
        Route::post('/aplicar-mora', [PlanPagoController::class, 'aplicarMora'])->name('aplicar-mora');
    });

    // ---------- Pagos ----------
    Route::prefix('pagos')->name('pagos.')->group(function () {
        Route::post('/', [PagoController::class, 'store'])->name('store');
        Route::get('/{id}', [PagoController::class, 'show'])->name('show');
        Route::get('/plan-pago/{planPagoId}', [PagoController::class, 'getByPlanPago'])->name('by-plan-pago');
        Route::delete('/{id}', [PagoController::class, 'destroy'])->name('destroy');
    });

    // ---------- Notificaciones ----------
    Route::prefix('notificaciones')->name('notificaciones.')->group(function () {
        Route::get('/', [NotificacionController::class, 'index'])->name('index');
        Route::post('/{id}/leida', [NotificacionController::class, 'marcarLeida'])->name('marcar-leida');
    });

    // ---------- Capital ----------
    Route::prefix('capital')->name('capital.')->group(function () {
        Route::get('/', [CapitalController::class, 'index'])->name('index');
        Route::post('/', [CapitalController::class, 'store'])->name('store');
        Route::post('/retirar', [CapitalController::class, 'retirar'])->name('retirar');
    });
});

Route::get('/admin/plan-pagos/{id}/detalle', [App\Http\Controllers\PagoController::class, 'detalleCuota']);

Route::get('/admin/prestamos/{id}/contrato-pdf', [PrestamoController::class, 'generarContratoPDF'])->name('admin.prestamos.contrato-pdf');


// ======================= RUTAS GESTOR =======================
Route::middleware(['auth'])->prefix('gestor')->name('gestor.')->group(function () {
    Route::get('/dashboard', function () {
        return view('gestor.dashboard');
    })->name('dashboard');
});

// ======================= RUTAS USUARIO =======================
Route::middleware(['auth'])->prefix('usuario')->name('usuario.')->group(function () {
    Route::get('/dashboard', function () {
        return view('usuario.dashboard');
    })->name('dashboard');
});

// ======================= DEBUG =======================
Route::get('/debug-auth', function () {
    $usuario = \App\Models\Usuario::where('correo', 'admin@hogar.com')->first();
    return [
        'usuario_existe' => $usuario ? true : false,
        'rol' => $usuario?->rol?->nombre,
        'hash_match' => \Illuminate\Support\Facades\Hash::check('admin123', $usuario->contrasena),
    ];
});

