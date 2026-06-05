package com.example.CallCenter.tipificacion;

import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class TipificacionServiceImpl implements TipificacionService {

    private final TipificacionDAO tipificacionDAO;

    public TipificacionServiceImpl(TipificacionDAO tipificacionDAO) {
        this.tipificacionDAO = tipificacionDAO;
    }

    @Override
    public List<Tipificacion> listarTodas() { return tipificacionDAO.listarTodas(); }

    @Override
    public List<Tipificacion> listarPorEmpresa(int id_empresa) { return tipificacionDAO.listarPorEmpresa(id_empresa); }

    @Override
    public List<Tipificacion> listarActivasPorEmpresa(int id_empresa) { return tipificacionDAO.listarActivasPorEmpresa(id_empresa);
    }

    @Override
    public List<String> listarMotivosPorEmpresa(int id_empresa) { return tipificacionDAO.listarMotivosPorEmpresa(id_empresa); }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_tipo) { return tipificacionDAO.obtenerTipificacionPorId(id_tipo); }

    @Override
    public void crearTipificacion(Tipificacion tipificacion, int id_empresa) { tipificacionDAO.crearTipificacion(tipificacion, id_empresa); }

    @Override
    public void cambiarEstadoAsignacion(int id_tipo, int id_empresa, String estado) { tipificacionDAO.cambiarEstadoAsignacion(id_tipo, id_empresa, estado); }

    @Override
    public void asignarTipificacionesBase(int id_empresa) { tipificacionDAO.asignarTipificacionesBase(id_empresa); }
}
