package com.example.CallCenter.tipificacion;

import com.example.CallCenter.tipificacion.entity.EmpresaTipoEntity;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EmpresaTipoRepository extends JpaRepository<EmpresaTipoEntity, Integer> {

    @Query("SELECT et FROM EmpresaTipoEntity et WHERE et.id_empresa = :idEmpresa")
    List<EmpresaTipoEntity> findByEmpresa(@Param("idEmpresa") int idEmpresa);

    @Query("""
            SELECT et FROM EmpresaTipoEntity et
            WHERE et.id_empresa = :idEmpresa
              AND UPPER(et.estado_asignacion) = UPPER(:estadoAsignacion)
            """)
    List<EmpresaTipoEntity> findByEmpresaAndEstado(@Param("idEmpresa") int idEmpresa,
                                                   @Param("estadoAsignacion") String estadoAsignacion);

    @Query("""
            SELECT et FROM EmpresaTipoEntity et
            WHERE et.id_empresa = :idEmpresa
              AND et.id_tipo = :idTipo
            """)
    Optional<EmpresaTipoEntity> findByEmpresaAndTipo(@Param("idEmpresa") int idEmpresa,
                                                     @Param("idTipo") int idTipo);
}