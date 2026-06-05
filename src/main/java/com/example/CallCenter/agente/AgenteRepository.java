package com.example.CallCenter.agente;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgenteRepository extends JpaRepository<Agente, Integer> {

    // Buscar por usuario y contraseña (para login)
    Optional<Agente> findByUsuario_agenteAndContrasenia_agenteAndEstado_agente(
            String usuario_agente, String contrasenia_agente, String estado_agente);

    // Buscar por empresa
    List<Agente> findByIdEmpresa(int id_empresa);

    // Verificar teléfono duplicado
    boolean existsByTelefono_agenteAndId_agenteNot(String telefono_agente, int id_agente);
}

