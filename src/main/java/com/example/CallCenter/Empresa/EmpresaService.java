package com.example.CallCenter.Empresa;

import com.example.CallCenter.Empresa.model.Empresa;
import java.util.List;

public interface EmpresaService {
    void registrarEmpresa(Empresa empresa);
    List<Empresa> listarEmpresas();
    Empresa obtenerEmpresaPorId(int id_empresa);
    void actualizarEmpresa(Empresa empresa);
    void eliminarEmpresa(int id_empresa);
    Empresa obtenerPorCredenciales(String usuario, String contrasenia);
}
