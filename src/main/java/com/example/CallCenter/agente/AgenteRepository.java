package com.example.CallCenter.agente;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class AgenteRepository implements AgenteDAO {

    private final List<Agente> agentes = new ArrayList<>();
    private int contadorId = 6;

    public AgenteRepository() {
        Agente a1 = new Agente(1, "Carlos García",  "987654321", "agente01", "age01", 1);
        Agente a2 = new Agente(2, "Ana Mendoza",    "912345678", "agente02", "age02", 1);
        Agente a3 = new Agente(3, "Luis Quispe",    "923456789", "agente03", "age03", 1);
        Agente a4 = new Agente(4, "María Flores",   "934567890", "agente04", "age04", 1);
        Agente a5 = new Agente(5, "Roberto Vargas", "945678901", "agente05", "age05", 1);
        a1.setEstado("activo"); a2.setEstado("activo"); a3.setEstado("activo");
        a4.setEstado("activo"); a5.setEstado("activo");
        agentes.add(a1); agentes.add(a2); agentes.add(a3);
        agentes.add(a4); agentes.add(a5);
    }

    @Override
    public List<Agente> listarAgentes() {
        // Devuelve todos, incluyendo borrados (se muestran en tabla con su estado)
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
                        && contrasenia.equals(a.getContrasenia_agente()))
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
    String num = String.format("%02d", contadorId);
    agente.setUsuario_agente("agente" + num);
    agente.setContrasenia_agente("age" + num);
    if (agente.getId_empresa() <= 0) {
        agente.setId_empresa(1);
    }
    agente.setEstado("activo");
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
                if (agente.getEstado() == null || agente.getEstado().trim().isEmpty()) {
                    agente.setEstado(agentes.get(i).getEstado());
                }
                agentes.set(i, agente);
                break;
            }
        }
    }

    @Override
    public void eliminarAgente(int id_agente) {
        agentes.stream()
                .filter(a -> a.getId_agente() == id_agente)
                .findFirst()
                .ifPresent(a -> a.setEstado("borrado"));
    }
}
