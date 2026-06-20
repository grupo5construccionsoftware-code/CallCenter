package com.example.CallCenter.Empresa;

import com.example.CallCenter.Empresa.adapter.EmpresaAdapter;
import com.example.CallCenter.Empresa.entity.EmpresaEntity;
import com.example.CallCenter.Empresa.model.Empresa;
import com.example.CallCenter.tipificacion.TipificacionService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class EmpresaServiceImpl implements EmpresaService {

    private final EmpresaRepository empresaRepository;
    private final EmpresaAdapter empresaAdapter;
    private final TipificacionService tipificacionService;

    public EmpresaServiceImpl(EmpresaRepository empresaRepository,
                              EmpresaAdapter empresaAdapter,
                              TipificacionService tipificacionService) {
        this.empresaRepository = empresaRepository;
        this.empresaAdapter = empresaAdapter;
        this.tipificacionService = tipificacionService;
    }

    @Override
    public void registrarEmpresa(Empresa empresa) {
        normalizarEmpresa(empresa);
        empresa.setEstado_empresa("ACTIVO");

        EmpresaEntity entity = empresaAdapter.toEntity(empresa);
        EmpresaEntity guardada = empresaRepository.save(entity);

        String credencial = "Emp" + guardada.getId_empresa();
        guardada.setUsuario_empresa(credencial);
        guardada.setContrasenia_empresa(credencial);
        guardada = empresaRepository.save(guardada);

        empresa.setId_empresa(guardada.getId_empresa());
        empresa.setUsuario_empresa(guardada.getUsuario_empresa());
        empresa.setContrasenia_empresa(guardada.getContrasenia_empresa());
        empresa.setEstado_empresa(guardada.getEstado_empresa());

        tipificacionService.asignarTipificacionesBase(guardada.getId_empresa());
    }

    @Override
    public List<Empresa> listarEmpresas() {
        return empresaRepository.findAll().stream()
                .map(empresaAdapter::toModel)
                .collect(Collectors.toList());
    }

    @Override
    public Empresa obtenerEmpresaPorId(int id_empresa) {
        return empresaRepository.findById(id_empresa)
                .map(empresaAdapter::toModel)
                .orElse(null);
    }

    @Override
    public void actualizarEmpresa(Empresa empresa) {
        EmpresaEntity actual = empresaRepository.findById(empresa.getId_empresa()).orElse(null);
        if (actual == null) return;

        normalizarEmpresa(empresa);
        empresa.setUsuario_empresa(actual.getUsuario_empresa());
        empresa.setContrasenia_empresa(actual.getContrasenia_empresa());
        if (empresa.getEstado_empresa() == null || empresa.getEstado_empresa().isBlank()) {
            empresa.setEstado_empresa(actual.getEstado_empresa());
        }

        EmpresaEntity entity = empresaAdapter.toEntity(empresa);
        empresaRepository.save(entity);
    }

    @Override
    public void eliminarEmpresa(int id_empresa) {
        EmpresaEntity entity = empresaRepository.findById(id_empresa).orElse(null);
        if (entity != null) {
            entity.setEstado_empresa("ELIMINADO");
            empresaRepository.save(entity);
        }
    }

    @Override
    public Empresa obtenerPorCredenciales(String usuario, String contrasenia) {
        return empresaRepository
                .findByUsuario_empresaIgnoreCaseAndContrasenia_empresa(usuario, contrasenia)
                .map(empresaAdapter::toModel)
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