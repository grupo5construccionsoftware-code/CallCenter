package com.example.CallCenter.Empresa;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpresaServiceImpl implements EmpresaService {

    private final EmpresaDAO empresaDAO;

    public EmpresaServiceImpl(EmpresaDAO empresaDAO) {
        this.empresaDAO = empresaDAO;
    }

    @Override
    public void registrarEmpresa(Empresa empresa) { empresaDAO.registrarEmpresa(empresa); }

    @Override
    public List<Empresa> listarEmpresas() { return empresaDAO.listarEmpresas(); }

    @Override
    public Empresa obtenerEmpresaPorId(int id_empresa) { return empresaDAO.obtenerEmpresaPorId(id_empresa); }

    @Override
    public void actualizarEmpresa(Empresa empresa) { empresaDAO.actualizarEmpresa(empresa); }

    @Override
    public void eliminarEmpresa(int id_empresa) { empresaDAO.eliminarEmpresa(id_empresa); }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return empresaDAO.obtenerPorCredenciales(usuario, contrasenia);
    }
}
