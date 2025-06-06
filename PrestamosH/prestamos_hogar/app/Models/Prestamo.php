<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestamo extends Model
{
    use HasFactory;

    protected $fillable = [
        'codigo',
        'usuario_id',
        'monto',
        'tasa_interes_mensual',
        'plazo_meses',
        'frecuencia_pago',
        'fecha_desembolso',
        'estado',
        'referencia_celular'
    ];

    protected $casts = [
        'fecha_desembolso' => 'date',
    ];

    public function usuario()
    {
        return $this->belongsTo(Usuario::class);
    }

    public function planPagos()
    {
        return $this->hasMany(PlanPago::class);
    }
}