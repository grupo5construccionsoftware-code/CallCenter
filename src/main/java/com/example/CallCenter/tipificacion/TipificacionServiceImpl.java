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
    public List<Tipificacion> listarTipificaciones() { return tipificacionDAO.listarTipificaciones(); }

    @Override
    public List<String> listarTiposLlamada() { return tipificacionDAO.listarTiposLlamada(); }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_tipo) { return tipificacionDAO.obtenerTipificacionPorId(id_tipo); }

    @Override
    public void crearTipificacion(Tipificacion tipificacion) { tipificacionDAO.crearTipificacion(tipificacion); }

    @Override
    public void actualizarTipificacion(Tipificacion tipificacion) { tipificacionDAO.actualizarTipificacion(tipificacion); }

    @Override
    public void eliminarTipificacion(int id_tipo) { tipificacionDAO.eliminarTipificacion(id_tipo); }
}