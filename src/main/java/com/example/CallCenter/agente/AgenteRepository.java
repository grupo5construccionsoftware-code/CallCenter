package com.example.CallCenter.agente;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class AgenteRepository implements AgenteDAO {

    private final List<Agente> agentes = new ArrayList<>();
    private int contadorId = 6;

    public AgenteRepository() {
        agentes.add(new Agente(1, "Carlos García",  "987654321", "Age1E1", "Age1E1", 1));
        agentes.add(new Agente(2, "Ana Mendoza",    "912345678", "Age2E1", "Age2E1", 1));
        agentes.add(new Agente(3, "Luis Quispe",    "923456789", "Age3E1", "Age3E1", 1));
        agentes.add(new Agente(4, "María Flores",   "934567890", "Age4E1", "Age4E1", 1));
        agentes.add(new Agente(5, "Roberto Vargas", "945678901", "Age5E1", "Age5E1", 1));
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
    public Agente obtenerPorCredenciales(String usuario, String contrasenia) {
        return agentes.stream()
                .filter(a -> usuario.equalsIgnoreCase(a.getUsuario_agente())
                        && contrasenia.equals(a.getContrasenia_agente())
                        && "ACTIVO".equals(a.getEstado_agente()))
                .findFirst()
                .orElse(null);
    }

    @Override
    public boolean existeTelefonoAgente(String telefono_agente, int idAgenteExcluir) {
        return agentes.stream()
                .anyMatch(a -> a.getId_agente() != idAgenteExcluir
                        && a.getTelefono_agente() != null
                        && a.getTelefono_agente().equals(telefono_agente));
    }

    @Override
    public void crearAgente(Agente agente) {
        agente.setId_agente(contadorId);
        int idEmpresa = agente.getId_empresa() > 0 ? agente.getId_empresa() : 1;
        agente.setUsuario_agente("Age" + contadorId + "E" + idEmpresa);
        agente.setContrasenia_agente("Age" + contadorId + "E" + idEmpresa);
        if (agente.getEstado_agente() == null || agente.getEstado_agente().isBlank()) {
            agente.setEstado_agente("ACTIVO");
        }
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
                if (agente.getEstado_agente() == null || agente.getEstado_agente().isBlank()) {
                    agente.setEstado_agente(agentes.get(i).getEstado_agente());
                }
                agentes.set(i, agente);
                break;
            }
        }
    }

    @Override
    public void eliminarAgente(int id_agente) {
        Agente agente = obtenerAgentePorId(id_agente);
        if (agente != null) {
            agente.setEstado_agente("ELIMINADO");
        }
    }
}

