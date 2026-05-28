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
    public Empresa obtenerEmpresaPorId(int id) { return empresaDAO.obtenerEmpresaPorId(id); }

    @Override
    public void actualizarEmpresa(Empresa empresa) { empresaDAO.actualizarEmpresa(empresa); }

    @Override
    public void eliminarEmpresa(int id) { empresaDAO.eliminarEmpresa(id); }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return empresaDAO.obtenerPorCredenciales(usuario, contrasenia);
    }
}
