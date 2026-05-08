package com.example.CallCenter.tipificacion;

import java.util.List;

public interface TipificacionService {
    List<Tipificacion> listarTipificaciones();
    List<String> listarTiposLlamada();
    void agregarTipoLlamada(String motivo);
    void eliminarTipoLlamada(int idTipo);
    Tipificacion obtenerTipificacionPorId(int id_llamada);
    void crearTipificacion(Tipificacion tipificacion);
    void actualizarTipificacion(Tipificacion tipificacion);
    void eliminarTipificacion(int id_llamada);
}
