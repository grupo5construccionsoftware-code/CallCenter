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
    public boolean existeTelefonoAgente(String telefono_agente, int idAgenteExcluir) {
        return agenteDAO.existeTelefonoAgente(telefono_agente, idAgenteExcluir);
    }

    @Override
    public void crearAgente(Agente agente) {
        validarAgente(agente, 0);
        agenteDAO.crearAgente(agente);
    }

    @Override
    public void actualizarAgente(Agente agente) {
        validarAgente(agente, agente.getId_agente());
        agenteDAO.actualizarAgente(agente);
    }

    @Override
    public void eliminarAgente(int id_agente) {
        agenteDAO.eliminarAgente(id_agente);
    }

    private void validarAgente(Agente agente, int idAgenteExcluir) {
        if (agente.getNombre_agente() == null || agente.getNombre_agente().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del agente es obligatorio.");
        }

        String telefono = agente.getTelefono_agente() == null ? "" : agente.getTelefono_agente().trim();
        if (!telefono.matches("[0-9]{9}")) {
            throw new IllegalArgumentException("El teléfono del agente debe tener exactamente 9 dígitos numéricos.");
        }

        agente.setTelefono_agente(telefono);
        agente.setNombre_agente(agente.getNombre_agente().trim());

        if (agenteDAO.existeTelefonoAgente(telefono, idAgenteExcluir)) {
            throw new IllegalArgumentException("Ya existe un agente registrado con ese teléfono.");
        }
    }
}
