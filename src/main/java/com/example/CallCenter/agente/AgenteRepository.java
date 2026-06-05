package com.example.CallCenter.agente;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AgenteRepository extends JpaRepository<Agente, Integer> {

    @Query("""
            SELECT a FROM Agente a
            WHERE a.usuario_agente = :usuario
              AND a.contrasenia_agente = :contrasenia
              AND a.estado_agente = :estado
            """)
    Optional<Agente> findByUsuario_agenteAndContrasenia_agenteAndEstado_agente(
            @Param("usuario") String usuario_agente,
            @Param("contrasenia") String contrasenia_agente,
            @Param("estado") String estado_agente);

    @Query("SELECT a FROM Agente a WHERE a.id_empresa = :idEmpresa")
    List<Agente> findByIdEmpresa(@Param("idEmpresa") int id_empresa);

    @Query("""
            SELECT COUNT(a) > 0 FROM Agente a
            WHERE a.telefono_agente = :telefono
              AND a.id_agente <> :idAgente
            """)
    boolean existsByTelefono_agenteAndId_agenteNot(@Param("telefono") String telefono_agente,
                                                   @Param("idAgente") int id_agente);
}
