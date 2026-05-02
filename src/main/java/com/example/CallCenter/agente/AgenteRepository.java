package com.example.CallCenter.agente;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class AgenteRepository implements AgenteDAO {

    private final List<Agente> agentes = new ArrayList<>();

    @Override
    public List<Agente> listarAgentes() {
        return agentes;
    }

    @Override
    public Agente obtenerAgentePorId(int id_agente) {
        return agentes.stream()
                .filter(a -> a.getId_agente() == id_agente)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void crearAgente(Agente agente) {
        int nuevoId = agentes.size() + 1;
        agente.setId_agente(nuevoId);
        agente.setUsuario_agente("agente" + nuevoId);
        agente.setContrasenia_agente("ag" + nuevoId + "2026");
        agente.setId_empresa(1);
        agentes.add(agente);
    }

    @Override
    public void actualizarAgente(Agente agente) {
        for (int i = 0; i < agentes.size(); i++) {
            if (agentes.get(i).getId_agente() == agente.getId_agente()) {
                agente.setUsuario_agente(agentes.get(i).getUsuario_agente());
                agente.setContrasenia_agente(agentes.get(i).getContrasenia_agente());
                agente.setId_empresa(agentes.get(i).getId_empresa());
                agentes.set(i, agente);
                break;
            }
        }
    }

    @Override
    public void eliminarAgente(int id_agente) {
        agentes.removeIf(a -> a.getId_agente() == id_agente);
    }
}