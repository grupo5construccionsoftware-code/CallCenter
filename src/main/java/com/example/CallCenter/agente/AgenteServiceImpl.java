package com.example.CallCenter.agente;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AgenteServiceImpl implements AgenteService {

    private final AgenteDAO agenteDAO;

    public AgenteServiceImpl(AgenteDAO agenteDAO) {
        this.agenteDAO = agenteDAO;
    }

    @Override
    public List<Agente> listarAgentes() {
        return agenteDAO.listarAgentes();
    }

    @Override
    public Agente obtenerAgentePorId(int id_agente) {
        return agenteDAO.obtenerAgentePorId(id_agente);
    }

    @Override
    public void crearAgente(Agente agente) {
        agenteDAO.crearAgente(agente);
    }

    @Override
    public void actualizarAgente(Agente agente) {
        agenteDAO.actualizarAgente(agente);
    }

    @Override
    public void eliminarAgente(int id_agente) {
        agenteDAO.eliminarAgente(id_agente);
    }
}