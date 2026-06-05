package com.example.CallCenter.tipificacion;

import java.util.List;

public interface TipificacionService {
    List<Tipificacion> listarTodas();
    List<Tipificacion> listarPorEmpresa(int id_empresa);
    List<Tipificacion> listarActivasPorEmpresa(int id_empresa);
    List<String> listarMotivosPorEmpresa(int id_empresa);
    Tipificacion obtenerTipificacionPorId(int id_tipo);
    void crearTipificacion(Tipificacion tipificacion, int id_empresa);
    void cambiarEstadoAsignacion(int id_tipo, int id_empresa, String estado);
    void asignarTipificacionesBase(int id_empresa);
}
