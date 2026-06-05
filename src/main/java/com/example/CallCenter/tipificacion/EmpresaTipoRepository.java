package com.example.CallCenter.tipificacion;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EmpresaTipoRepository extends JpaRepository<EmpresaTipo, Integer> {

    // Tipificaciones de una empresa
    List<EmpresaTipo> findByIdEmpresa(int id_empresa);
}
