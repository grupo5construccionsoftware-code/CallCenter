package com.example.CallCenter.Empresa;

import java.util.ArrayList;
import java.util.List;

import com.example.CallCenter.tipificacion.TipificacionDAO;
import org.springframework.stereotype.Repository;

@Repository
public class EmpresaRepository implements EmpresaDAO {

    private final TipificacionDAO tipificacionDAO;
    private final List<Empresa> listaSimulada = new ArrayList<>();
    private int contadorId = 2;

    public EmpresaRepository(TipificacionDAO tipificacionDAO) {
        this.tipificacionDAO = tipificacionDAO;
        Empresa demo = new Empresa(1, "Empresa Demo", "900000001", "demo@empresa.com");
        demo.setUsuario_empresa("Emp1");
        demo.setContrasenia_empresa("Emp1");
        demo.setEstado_empresa("ACTIVO");
        listaSimulada.add(demo);
    }

    @Override
    public void registrarEmpresa(Empresa empresa) {
        empresa.setId_empresa(contadorId);
        empresa.setUsuario_empresa("Emp" + contadorId);
        empresa.setContrasenia_empresa("Emp" + contadorId);
        if (empresa.getEstado_empresa() == null || empresa.getEstado_empresa().trim().isEmpty()) {
            empresa.setEstado_empresa("ACTIVO");
        }
        contadorId++;
        listaSimulada.add(empresa);
        tipificacionDAO.asignarTipificacionesBase(empresa.getId_empresa());
    }

    @Override
    public List<Empresa> listarEmpresas() {
        return listaSimulada;
    }

    @Override
    public Empresa obtenerEmpresaPorId(int id_empresa) {
        return listaSimulada.stream()
                .filter(e -> e.getId_empresa() == id_empresa)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void actualizarEmpresa(Empresa empresa) {
        for (int i = 0; i < listaSimulada.size(); i++) {
            Empresa actual = listaSimulada.get(i);
            if (actual.getId_empresa() == empresa.getId_empresa()) {
                empresa.setUsuario_empresa(actual.getUsuario_empresa());
                empresa.setContrasenia_empresa(actual.getContrasenia_empresa());
                if (empresa.getEstado_empresa() == null || empresa.getEstado_empresa().trim().isEmpty()) {
                    empresa.setEstado_empresa(actual.getEstado_empresa());
                }
                listaSimulada.set(i, empresa);
                return;
            }
        }
    }

    @Override
    public void eliminarEmpresa(int id_empresa) {
        Empresa empresa = obtenerEmpresaPorId(id_empresa);
        if (empresa != null) {
            empresa.setEstado_empresa("ELIMINADO");
        }
    }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return listaSimulada.stream()
                .filter(e -> usuario.equalsIgnoreCase(e.getUsuario_empresa())
                        && contrasenia.equals(e.getContrasenia_empresa())
                        && !"ELIMINADO".equals(e.getEstado_empresa()))
                .findFirst()
                .orElse(null);
    }
}
