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
    public Tipificacion obtenerTipificacionPorId(int id_llamada) { return tipificacionDAO.obtenerTipificacionPorId(id_llamada); }

    @Override
    public void crearTipificacion(Tipificacion tipificacion) { tipificacionDAO.crearTipificacion(tipificacion); }

    @Override
    public void actualizarTipificacion(Tipificacion tipificacion) { tipificacionDAO.actualizarTipificacion(tipificacion); }

    @Override
    public void eliminarTipificacion(int id_llamada) { tipificacionDAO.eliminarTipificacion(id_llamada); }
}