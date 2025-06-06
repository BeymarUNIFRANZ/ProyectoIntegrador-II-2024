<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;

class Usuario extends Authenticatable
{
    protected $table = 'usuarios';

    protected $fillable = [
        'nombre_completo',
        'correo',
        'contrasena',
        'ci',
        'expedido',
        'celular',
        'rol_id'
    ];

    protected $hidden = [
        'contrasena',
    ];

    public function rol()
    {
        return $this->belongsTo(Rol::class);
    }

    // Esto le dice a Laravel que use "contrasena" en lugar de "password"
    public function getAuthPassword()
    {
        return $this->contrasena;
    }

    public function prestamos()
    {
        return $this->hasMany(Prestamo::class);
    }

    public function notificaciones()
{
    return $this->hasMany(Notificacion::class, );
}

public function notificacionesNoLeidas()
{
    return $this->notificaciones()->where('leida', false);
}
}
