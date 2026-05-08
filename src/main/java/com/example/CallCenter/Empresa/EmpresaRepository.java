package com.example.CallCenter.Empresa;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class EmpresaRepository implements EmpresaDAO {


    private final List<Empresa> listaSimulada = new ArrayList<>();
    private int contadorId = 2
            ;

    @Override
    public void registrarEmpresa(Empresa empresa) {
        empresa.setId(contadorId);
        String num = String.format("%02d", contadorId);
        empresa.setUsuario("empresa" + num);
        empresa.setContrasenia("emp" + num);
        contadorId++;
        listaSimulada.add(empresa);

    }

}

