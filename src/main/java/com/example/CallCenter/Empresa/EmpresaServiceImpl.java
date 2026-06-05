package com.example.CallCenter.Empresa;

import com.example.CallCenter.tipificacion.TipificacionService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmpresaServiceImpl implements EmpresaService {

    private final EmpresaRepository empresaRepository;
    private final TipificacionService tipificacionService;

    public EmpresaServiceImpl(EmpresaRepository empresaRepository,
                              TipificacionService tipificacionService) {
        this.empresaRepository = empresaRepository;
        this.tipificacionService = tipificacionService;
    }

    @Override
    public void registrarEmpresa(Empresa empresa) {
        normalizarEmpresa(empresa);
        empresa.setEstado_empresa("ACTIVO");

        Empresa guardada = empresaRepository.save(empresa);
        String credencial = "Emp" + guardada.getId_empresa();
        guardada.setUsuario_empresa(credencial);
        guardada.setContrasenia_empresa(credencial);
        empresaRepository.save(guardada);

        empresa.setId_empresa(guardada.getId_empresa());
        empresa.setUsuario_empresa(guardada.getUsuario_empresa());
        empresa.setContrasenia_empresa(guardada.getContrasenia_empresa());
        empresa.setEstado_empresa(guardada.getEstado_empresa());

        // Asignar tipificaciones base a la nueva empresa
        tipificacionService.asignarTipificacionesBase(guardada.getId_empresa());
    }

    @Override
    public List<Empresa> listarEmpresas() {
        return empresaRepository.findAll();
    }

    @Override
    public Empresa obtenerEmpresaPorId(int id_empresa) {
        return empresaRepository.findById(id_empresa).orElse(null);
    }

    @Override
    public void actualizarEmpresa(Empresa empresa) {
        Empresa actual = empresaRepository.findById(empresa.getId_empresa()).orElse(null);
        if (actual == null) return;

        normalizarEmpresa(empresa);
        empresa.setUsuario_empresa(actual.getUsuario_empresa());
        empresa.setContrasenia_empresa(actual.getContrasenia_empresa());
        if (empresa.getEstado_empresa() == null || empresa.getEstado_empresa().isBlank()) {
            empresa.setEstado_empresa(actual.getEstado_empresa());
        }
        empresaRepository.save(empresa);
    }

    @Override
    public void eliminarEmpresa(int id_empresa) {
        Empresa empresa = empresaRepository.findById(id_empresa).orElse(null);
        if (empresa != null) {
            empresa.setEstado_empresa("ELIMINADO");
            empresaRepository.save(empresa);
        }
    }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return empresaRepository
                .findByUsuario_empresaIgnoreCaseAndContrasenia_empresa(usuario, contrasenia)
                .orElse(null);
    }

    private void normalizarEmpresa(Empresa empresa) {
        if (empresa.getNombre_empresa() != null) {
            empresa.setNombre_empresa(empresa.getNombre_empresa().trim());
        }
        if (empresa.getTelefono_empresa() != null) {
            empresa.setTelefono_empresa(empresa.getTelefono_empresa().trim());
        }
        if (empresa.getCorreo_empresa() != null) {
            empresa.setCorreo_empresa(empresa.getCorreo_empresa().trim());
        }
    }
}