package com.example.CallCenter.Empresa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface EmpresaRepository extends JpaRepository<Empresa, Integer> {

    // Buscar por credenciales (para login)
    Optional<Empresa> findByUsuario_empresaIgnoreCaseAndContrasenia_empresa(
            String usuario_empresa, String contrasenia_empresa);
}
