package com.example.CallCenter.tipificacion;

import java.util.List;

public interface TipificacionDAO {
    List<Tipificacion> listarTipificaciones();
    Tipificacion obtenerTipificacionPorId(int id_llamada);
    void crearTipificacion(Tipificacion tipificacion);
    void actualizarTipificacion(Tipificacion tipificacion);
    void eliminarTipificacion(int id_llamada);
}