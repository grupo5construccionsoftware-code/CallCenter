package com.example.CallCenter.tipificacion;

import com.example.CallCenter.tipificacion.entity.TipificacionEntity;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TipificacionRepository extends JpaRepository<TipificacionEntity, Integer> {

    @Query("SELECT t FROM TipificacionEntity t WHERE UPPER(t.estado_tipo) = UPPER(:estadoTipo)")
    List<TipificacionEntity> findByEstado(@Param("estadoTipo") String estadoTipo);

    @Query("SELECT t FROM TipificacionEntity t WHERE UPPER(t.motivo_tipo) = UPPER(:motivoTipo)")
    Optional<TipificacionEntity> findByMotivoTipoIgnoreCase(@Param("motivoTipo") String motivoTipo);
}