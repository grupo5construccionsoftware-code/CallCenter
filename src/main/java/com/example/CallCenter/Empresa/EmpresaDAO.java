package com.example.CallCenter.Empresa;

import java.util.List;

public interface EmpresaDAO {

    void registrarEmpresa(Empresa empresa);
    List<Empresa> listarEmpresas();
}

