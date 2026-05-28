package com.example.CallCenter.Empresa;

import java.util.List;

public interface EmpresaService {
    void registrarEmpresa(Empresa empresa);
    List<Empresa> listarEmpresas();
    Empresa obtenerEmpresaPorId(int id);
    void actualizarEmpresa(Empresa empresa);
    void eliminarEmpresa(int id);
    Empresa obtenerPorCredenciales(String usuario, String contrasenia);
}
