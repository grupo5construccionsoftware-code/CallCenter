package com.example.CallCenter.llamada;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class LlamadaServiceImpl implements LlamadaService {

    private final LlamadaDAO llamadaDAO;

    public LlamadaServiceImpl(LlamadaDAO llamadaDAO) {
        this.llamadaDAO = llamadaDAO;
    }

    @Override
    public List<Llamada> listarLlamadas() { return llamadaDAO.listarLlamadas(); }

    @Override
    public Llamada obtenerLlamadaPorId(int id_llamada) { return llamadaDAO.obtenerLlamadaPorId(id_llamada); }

    @Override
    public void crearLlamada(Llamada llamada) { llamadaDAO.crearLlamada(llamada); }

    @Override
    public void actualizarLlamada(Llamada llamada) { llamadaDAO.actualizarLlamada(llamada); }

    @Override
    public void eliminarLlamada(int id_llamada) { llamadaDAO.eliminarLlamada(id_llamada); }
}