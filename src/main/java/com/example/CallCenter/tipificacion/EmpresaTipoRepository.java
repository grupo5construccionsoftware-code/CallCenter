package com.example.CallCenter.tipificacion;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface EmpresaTipoRepository extends JpaRepository<EmpresaTipo, Integer> {

    @Query("SELECT et FROM EmpresaTipo et WHERE et.id_empresa = :idEmpresa")
    List<EmpresaTipo> findByEmpresa(@Param("idEmpresa") int idEmpresa);

    @Query("""
            SELECT et FROM EmpresaTipo et
            WHERE et.id_empresa = :idEmpresa
              AND UPPER(et.estado_asignacion) = UPPER(:estadoAsignacion)
            """)
    List<EmpresaTipo> findByEmpresaAndEstado(@Param("idEmpresa") int idEmpresa,
                                             @Param("estadoAsignacion") String estadoAsignacion);

    @Query("""
            SELECT et FROM EmpresaTipo et
            WHERE et.id_empresa = :idEmpresa
              AND et.id_tipo = :idTipo
            """)
    Optional<EmpresaTipo> findByEmpresaAndTipo(@Param("idEmpresa") int idEmpresa,
                                               @Param("idTipo") int idTipo);
}
