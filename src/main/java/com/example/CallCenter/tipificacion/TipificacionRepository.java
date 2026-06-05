package com.example.CallCenter.tipificacion;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TipificacionRepository extends JpaRepository<Tipificacion, Integer> {

    @Query("SELECT t FROM Tipificacion t WHERE UPPER(t.motivo_tipo) = UPPER(:motivoTipo)")
    Optional<Tipificacion> findByMotivoTipoIgnoreCase(@Param("motivoTipo") String motivoTipo);
}
