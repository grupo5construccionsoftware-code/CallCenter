package com.example.CallCenter.agente;

import java.util.List;

public interface AgenteDAO {

    List<Agente> listarAgentes();

    Agente obtenerAgentePorId(int id_agente);

    void crearAgente(Agente agente);

    void actualizarAgente(Agente agente);

    void eliminarAgente(int id_agente);
}