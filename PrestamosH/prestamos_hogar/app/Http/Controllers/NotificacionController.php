<?php

namespace App\Http\Controllers;

use App\Models\Notificacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificacionController extends Controller
{
    public function index()
    {
        /** @var \App\Models\Usuario|null $user */
        $user = Auth::user();
        $notificaciones = $user->notificaciones()
            ->orderBy('created_at', 'desc')
            ->paginate(10);

        return view('admin.notificaciones.index', compact('notificaciones'));
    }

    public function marcarLeida($id)
    {
        /** @var \App\Models\Usuario|null $user */
        $user = Auth::user();
        $notificacion = $user->notificaciones()->findOrFail($id);
        $notificacion->update(['leida' => true]);
        
        return response()->json(['success' => true]);
    }
    
}