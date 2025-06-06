<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Usuario;
use App\Models\Rol;
use Illuminate\Support\Facades\Hash;

class AdminUsuarioController extends Controller
{
    public function index()
    {
        // Obtener usuarios paginados (10 por página) con su relación rol
        $usuarios = Usuario::with('rol')->paginate(10);
        
        // Contadores para las tarjetas de estadísticas
        $totalAdmin = Usuario::whereHas('rol', function($q) {
            $q->where('nombre', 'admin');
        })->count();
        
        $totalGestor = Usuario::whereHas('rol', function($q) {
            $q->where('nombre', 'gestor');
        })->count();
        
        $totalUsuario = Usuario::whereHas('rol', function($q) {
            $q->where('nombre', 'usuario');
        })->count();
        
        return view('admin.usuarios.index', compact(
            'usuarios',
            'totalAdmin',
            'totalGestor',
            'totalUsuario'
        ));
    }

    public function create()
    {
        $roles = Rol::all();
        return view('admin.usuarios.create', compact('roles'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre_completo' => 'required|string|max:255',
            'correo' => 'required|email|unique:usuarios,correo',
            'contrasena' => 'required|min:6|confirmed',
            'ci' => 'required|unique:usuarios,ci',
            'expedido' => 'nullable|string|max:5',
            'celular' => 'nullable|string|max:20',
            'rol_id' => 'required|exists:roles,id',
        ]);

        Usuario::create([
            'nombre_completo' => $validated['nombre_completo'],
            'correo' => $validated['correo'],
            'contrasena' => Hash::make($validated['contrasena']),
            'ci' => $validated['ci'],
            'expedido' => $validated['expedido'],
            'celular' => $validated['celular'],
            'rol_id' => $validated['rol_id'],
        ]);

        return redirect()
            ->route('admin.usuarios.index')
            ->with('success', 'Usuario creado correctamente.');
    }

    public function edit($id)
    {
        $usuario = Usuario::findOrFail($id);
        $roles = Rol::all();
        return view('admin.usuarios.edit', compact('usuario', 'roles'));
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'nombre_completo' => 'required|string|max:255',
            'correo' => "required|email|unique:usuarios,correo,$id",
            'ci' => "required|unique:usuarios,ci,$id",
            'expedido' => 'nullable|string|max:5',
            'celular' => 'nullable|string|max:20',
            'rol_id' => 'required|exists:roles,id',
            'contrasena' => 'nullable|min:6|confirmed',
        ]);

        $usuario = Usuario::findOrFail($id);
        $data = [
            'nombre_completo' => $validated['nombre_completo'],
            'correo' => $validated['correo'],
            'ci' => $validated['ci'],
            'expedido' => $validated['expedido'],
            'celular' => $validated['celular'],
            'rol_id' => $validated['rol_id'],
        ];

        if ($request->filled('contrasena')) {
            $data['contrasena'] = Hash::make($validated['contrasena']);
        }

        $usuario->update($data);

        return redirect()
            ->route('admin.usuarios.index')
            ->with('success', 'Usuario actualizado correctamente.');
    }

    // Método adicional para eliminar usuarios (opcional)
    public function destroy($id)
    {
        $usuario = Usuario::findOrFail($id);
        $usuario->delete();
        
        return redirect()
            ->route('admin.usuarios.index')
            ->with('success', 'Usuario eliminado correctamente.');
    }
}