package com.example.CallCenter.agente;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class AgenteRepository implements AgenteDAO {

    private final List<Agente> agentes = new ArrayList<>();
    private int contadorId = 6;

    {
        agentes.add(new Agente(1, "Carlos García",   "987654321", "agente01", "age01", 1));
        agentes.add(new Agente(2, "Ana Mendoza",    "912345678", "agente02", "age02", 1));
        agentes.add(new Agente(3, "Luis Quispe",     "923456789", "agente03", "age03", 1));
        agentes.add(new Agente(4, "María Flores",   "934567890", "agente04", "age04", 1));
        agentes.add(new Agente(5, "Roberto Vargas", "945678901", "agente05", "age05", 1));
    }

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
        agente.setId_agente(contadorId);
        agente.setUsuario_agente("agente0" + contadorId);
        agente.setContrasenia_agente("age0" + contadorId);
        agente.setId_empresa(1);
        contadorId++;
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