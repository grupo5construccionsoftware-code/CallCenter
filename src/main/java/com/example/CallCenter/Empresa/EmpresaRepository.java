package com.example.CallCenter.Empresa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmpresaRepository extends JpaRepository<Empresa, Integer> {

    @Query("""
            SELECT e FROM Empresa e
            WHERE LOWER(e.usuario_empresa) = LOWER(:usuario)
              AND e.contrasenia_empresa = :contrasenia
            """)
    Optional<Empresa> findByUsuario_empresaIgnoreCaseAndContrasenia_empresa(
            @Param("usuario") String usuario_empresa,
            @Param("contrasenia") String contrasenia_empresa);
}
