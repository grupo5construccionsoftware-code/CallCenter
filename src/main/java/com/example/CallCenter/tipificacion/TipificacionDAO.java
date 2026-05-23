package com.example.CallCenter.tipificacion;

import java.util.List;

public interface TipificacionDAO {
    List<Tipificacion> listarTipificaciones();
    List<String> listarTiposLlamada();
    Tipificacion obtenerTipificacionPorId(int id_tipo);
    void crearTipificacion(Tipificacion tipificacion);
    void actualizarTipificacion(Tipificacion tipificacion);
    void eliminarTipificacion(int id_tipo);
}