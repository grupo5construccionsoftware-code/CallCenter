package com.example.CallCenter.Empresa;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class EmpresaRepository implements EmpresaDAO {

    private final List<Empresa> listaSimulada = new ArrayList<>();
    private int contadorId = 2;

    public EmpresaRepository() {
        Empresa demo = new Empresa(1, "Empresa Demo", "900000001", "demo@empresa.com");
        demo.setUsuario("empresa01");
        demo.setContrasenia("emp01");
        demo.setEstado("activo");
        listaSimulada.add(demo);
    }

    @Override
    public void registrarEmpresa(Empresa empresa) {
        empresa.setId(contadorId);
        String num = String.format("%02d", contadorId);
        empresa.setUsuario("empresa" + num);
        empresa.setContrasenia("emp" + num);
        if (empresa.getEstado() == null || empresa.getEstado().trim().isEmpty()) {
            empresa.setEstado("activo");
        }
        contadorId++;
        listaSimulada.add(empresa);
    }

    @Override
    public List<Empresa> listarEmpresas() { return listaSimulada; }

    @Override
    public Empresa obtenerEmpresaPorId(int id) {
        return listaSimulada.stream().filter(e -> e.getId() == id).findFirst().orElse(null);
    }

    @Override
    public void actualizarEmpresa(Empresa empresa) {
        for (int i = 0; i < listaSimulada.size(); i++) {
            Empresa actual = listaSimulada.get(i);
            if (actual.getId() == empresa.getId()) {
                empresa.setUsuario(actual.getUsuario());
                empresa.setContrasenia(actual.getContrasenia());
                if (empresa.getEstado() == null || empresa.getEstado().trim().isEmpty()) {
                    empresa.setEstado(actual.getEstado());
                }
                listaSimulada.set(i, empresa);
                return;
            }
        }
    }

    @Override
    public void eliminarEmpresa(int id) {
        Empresa empresa = obtenerEmpresaPorId(id);
        if (empresa != null) {
            empresa.setEstado("borrado");
        }
    }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return listaSimulada.stream()
                .filter(e -> usuario.equalsIgnoreCase(e.getUsuario()) && contrasenia.equals(e.getContrasenia()))
                .findFirst()
                .orElse(null);
    }
}

