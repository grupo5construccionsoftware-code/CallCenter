package com.example.CallCenter.tipificacion;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TipificacionRepository extends JpaRepository<Tipificacion, Integer> {

    // Tipificaciones activas
    List<Tipificacion> findByEstado_tipo(String estado_tipo);
}
