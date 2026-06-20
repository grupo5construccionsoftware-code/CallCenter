package com.example.CallCenter.llamada;

import com.example.CallCenter.llamada.entity.LlamadaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface LlamadaRepository extends JpaRepository<LlamadaEntity, Integer> {

    @Query("SELECT l FROM LlamadaEntity l WHERE l.id_agente = :idAgente")
    List<LlamadaEntity> findByIdAgente(@Param("idAgente") int id_agente);

    @Query("SELECT l FROM LlamadaEntity l WHERE l.id_agente IN :idsAgentes")
    List<LlamadaEntity> findByIdAgenteIn(@Param("idsAgentes") Collection<Integer> idsAgentes);

    // Corregido: TipificacionEntity en lugar de Tipificacion
    @Query("SELECT t.motivo_tipo FROM TipificacionEntity t WHERE t.id_tipo = :idTipo")
    String findMotivoByIdTipo(@Param("idTipo") int idTipo);

    @Query("""
            SELECT COUNT(l) FROM LlamadaEntity l
            WHERE l.id_agente = :idAgente
              AND l.id_llamada <= :idLlamada
            """)
    int contarLlamadasHastaId(@Param("idAgente") int idAgente,
                              @Param("idLlamada") int idLlamada);
}