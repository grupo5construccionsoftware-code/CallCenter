package com.example.CallCenter.llamada;

import com.example.CallCenter.llamada.entity.LlamadaTipoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LlamadaTipoRepository extends JpaRepository<LlamadaTipoEntity, Integer> {

    @Query("SELECT lt FROM LlamadaTipoEntity lt WHERE lt.id_llamada = :idLlamada")
    Optional<LlamadaTipoEntity> findByIdLlamada(@Param("idLlamada") int idLlamada);
}