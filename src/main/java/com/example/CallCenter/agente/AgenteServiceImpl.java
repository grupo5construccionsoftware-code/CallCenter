package com.example.CallCenter.agente;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AgenteServiceImpl implements AgenteService {

    private final AgenteRepository agenteRepository;

    public AgenteServiceImpl(AgenteRepository agenteRepository) {
        this.agenteRepository = agenteRepository;
    }

    @Override
    public List<Agente> listarAgentes() {
        return agenteRepository.findAll();
    }

    @Override
    public Agente obtenerAgentePorId(int id_agente) {
        return agenteRepository.findById(id_agente).orElse(null);
    }

    @Override
    public Agente obtenerPorCredenciales(String usuario, String contrasenia) {
        return agenteRepository
                .findByUsuario_agenteAndContrasenia_agenteAndEstado_agente(
                        usuario, contrasenia, "ACTIVO")
                .orElse(null);
    }

    @Override
    public boolean existeTelefonoAgente(String telefono_agente, int idAgenteExcluir) {
        return agenteRepository.existsByTelefono_agenteAndId_agenteNot(
                telefono_agente, idAgenteExcluir);
    }

    @Override
    public void crearAgente(Agente agente) {
        validarAgente(agente, 0);
        int idEmpresa = agente.getId_empresa() > 0 ? agente.getId_empresa() : 1;
        agente.setEstado_agente("ACTIVO");
        Agente guardado = agenteRepository.save(agente);
        int nuevoId = guardado.getId_agente();
        guardado.setUsuario_agente("Age" + nuevoId + "E" + idEmpresa);
        guardado.setContrasenia_agente("Age" + nuevoId + "E" + idEmpresa);
        agenteRepository.save(guardado);
    }

    @Override
    public void actualizarAgente(Agente agente) {
        validarAgente(agente, agente.getId_agente());
        Agente actual = agenteRepository.findById(agente.getId_agente()).orElse(null);
        if (actual == null) return;
        agente.setUsuario_agente(actual.getUsuario_agente());
        agente.setContrasenia_agente(actual.getContrasenia_agente());
        agente.setId_empresa(actual.getId_empresa());
        if (agente.getEstado_agente() == null || agente.getEstado_agente().isBlank()) {
            agente.setEstado_agente(actual.getEstado_agente());
        }
        agenteRepository.save(agente);
    }

    @Override
    public void eliminarAgente(int id_agente) {
        Agente agente = agenteRepository.findById(id_agente).orElse(null);
        if (agente != null) {
            agente.setEstado_agente("ELIMINADO");
            agenteRepository.save(agente);
        }
    }

    private void validarAgente(Agente agente, int idAgenteExcluir) {
        if (agente.getNombre_agente() == null || agente.getNombre_agente().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del agente es obligatorio.");
        }
        String telefono = agente.getTelefono_agente() == null ? "" : agente.getTelefono_agente().trim();
        if (!telefono.matches("[0-9]{9}")) {
            throw new IllegalArgumentException("El teléfono debe tener exactamente 9 dígitos numéricos.");
        }
        agente.setTelefono_agente(telefono);
        agente.setNombre_agente(agente.getNombre_agente().trim());
        if (agenteRepository.existsByTelefono_agenteAndId_agenteNot(telefono, idAgenteExcluir)) {
            throw new IllegalArgumentException("Ya existe un agente registrado con ese teléfono.");
        }
    }
}