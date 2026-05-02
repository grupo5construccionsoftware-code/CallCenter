package com.example.CallCenter.agente;

import java.util.List;

public interface AgenteService {

    List<Agente> listarAgentes();

    Agente obtenerAgentePorId(int id_agente);

    void crearAgente(Agente agente);

    void actualizarAgente(Agente agente);

    void eliminarAgente(int id_agente);
}