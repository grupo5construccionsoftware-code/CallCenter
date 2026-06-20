package com.example.CallCenter.agente;

import com.example.CallCenter.agente.model.Agente;
import java.util.List;

public interface AgenteService {

    List<Agente> listarAgentes();

    Agente obtenerAgentePorId(int id_agente);

    Agente obtenerPorCredenciales(String usuario, String contrasenia);

    boolean existeTelefonoAgente(String telefono_agente, int idAgenteExcluir);

    void crearAgente(Agente agente);

    void actualizarAgente(Agente agente);

    void eliminarAgente(int id_agente);
}
