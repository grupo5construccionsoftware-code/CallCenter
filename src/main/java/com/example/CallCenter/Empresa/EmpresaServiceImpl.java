package com.example.CallCenter.Empresa;

import org.springframework.stereotype.Service;

@Service
public class EmpresaServiceImpl implements EmpresaService {

    private final EmpresaDAO empresaDAO;

    public EmpresaServiceImpl(EmpresaDAO empresaDAO) {
        this.empresaDAO = empresaDAO;
    }

    @Override
    public void registrarEmpresa(Empresa empresa) {
        empresaDAO.registrarEmpresa(empresa);
    }

}
