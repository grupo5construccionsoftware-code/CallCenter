package com.example.CallCenter.llamada;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface LlamadaRepository extends JpaRepository<Llamada, Integer> {

    @Query("SELECT l FROM Llamada l WHERE l.id_agente = :idAgente")
    List<Llamada> findByIdAgente(@Param("idAgente") int id_agente);

    @Query("SELECT l FROM Llamada l WHERE l.id_agente IN :idsAgentes")
    List<Llamada> findByIdAgenteIn(@Param("idsAgentes") Collection<Integer> idsAgentes);

    @Query("SELECT t.motivo_tipo FROM Tipificacion t WHERE t.id_tipo = :idTipo")
    String findMotivoByIdTipo(@Param("idTipo") int idTipo);
}
