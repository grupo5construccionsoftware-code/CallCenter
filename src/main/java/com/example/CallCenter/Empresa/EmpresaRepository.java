package com.example.CallCenter.Empresa;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class EmpresaRepository implements EmpresaDAO {

    // Lista en memoria que simula la base de datos
    private final List<Empresa> listaSimulada = new ArrayList<>();
    private int contadorId = 1;

    @Override
    public void registrarEmpresa(Empresa empresa) {
        empresa.setId(contadorId++);
        listaSimulada.add(empresa);
    }

}

