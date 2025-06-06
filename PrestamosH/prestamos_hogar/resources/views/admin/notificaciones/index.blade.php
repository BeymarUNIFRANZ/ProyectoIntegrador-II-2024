@extends('layouts.app')

@section('content')
<div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">Mis Notificaciones</h1>
    </div>

    <div class="space-y-4">
        @forelse($notificaciones as $notificacion)
        <div class="p-4 border rounded-lg {{ $notificacion->leida ? 'bg-white' : 'bg-blue-50' }}">
            <div class="flex justify-between">
                <p class="{{ $notificacion->leida ? 'text-gray-600' : 'font-medium text-gray-900' }}">
                    {{ $notificacion->mensaje }}
                </p>
                @if(!$notificacion->leida)
                <button onclick="marcarLeida({{ $notificacion->id }})" 
                        class="text-blue-600 text-sm hover:text-blue-800">
                    Marcar como leída
                </button>
                @endif
            </div>
            <p class="text-xs text-gray-500 mt-1">
                {{ $notificacion->created_at->diffForHumans() }}
            </p>
        </div>
        @empty
        <div class="text-center py-8 text-gray-500">
            No tienes notificaciones
        </div>
        @endforelse
    </div>

    @if($notificaciones->hasPages())
    <div class="mt-6">
        {{ $notificaciones->links() }}
    </div>
    @endif
</div>

<script>
function marcarLeida(id) {
   fetch("/admin/notificaciones/" + id + "/leida", {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': '{{ csrf_token() }}',
            'Accept': 'application/json'
        }
    }).then(response => {
        if(response.ok) {
            window.location.reload();
        }
    });
}
</script>
@endsection