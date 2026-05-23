package com.example.CallCenter.Empresa;
import java.util.List;
public interface EmpresaService {

    void registrarEmpresa(Empresa empresa);
    List<Empresa> listarEmpresas();
}
