package com.example.CallCenter.tipificacion;

import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;

@Service
public class TipificacionServiceImpl implements TipificacionService {

    private static final String ESTADO_ACTIVO = "ACTIVO";
    private static final String ESTADO_ELIMINADO = "ELIMINADO";

    private final TipificacionRepository tipificacionRepository;
    private final EmpresaTipoRepository empresaTipoRepository;

    public TipificacionServiceImpl(TipificacionRepository tipificacionRepository,
                                   EmpresaTipoRepository empresaTipoRepository) {
        this.tipificacionRepository = tipificacionRepository;
        this.empresaTipoRepository = empresaTipoRepository;
    }

    @Override
    public List<Tipificacion> listarTodas() {
        return tipificacionRepository.findAll();
    }

    @Override
    public List<Tipificacion> listarPorEmpresa(int id_empresa) {
        return empresaTipoRepository.findByEmpresa(id_empresa).stream()
                .map(this::obtenerTipificacionConEstadoAsignacion)
                .filter(Objects::nonNull)
                .toList();
    }

    @Override
    public List<Tipificacion> listarActivasPorEmpresa(int id_empresa) {
        return empresaTipoRepository.findByEmpresaAndEstado(id_empresa, ESTADO_ACTIVO).stream()
                .map(this::obtenerTipificacionConEstadoAsignacion)
                .filter(tipificacion -> tipificacion != null
                        && ESTADO_ACTIVO.equalsIgnoreCase(tipificacion.getEstado_tipo()))
                .toList();
    }

    @Override
    public List<String> listarMotivosPorEmpresa(int id_empresa) {
        return listarActivasPorEmpresa(id_empresa).stream()
                .map(Tipificacion::getMotivo_tipo)
                .toList();
    }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_tipo) {
        return tipificacionRepository.findById(id_tipo).orElse(null);
    }

    @Override
    public void crearTipificacion(Tipificacion tipificacion, int id_empresa) {
        validarMotivo(tipificacion);
        tipificacion.setMotivo_tipo(tipificacion.getMotivo_tipo().trim());

        Tipificacion tipificacionGuardada = tipificacionRepository
                .findByMotivoTipoIgnoreCase(tipificacion.getMotivo_tipo())
                .orElseGet(() -> guardarNuevaTipificacion(tipificacion));

        asignarTipificacionAEmpresa(id_empresa, tipificacionGuardada.getId_tipo(), ESTADO_ACTIVO);
        tipificacion.setId_tipo(tipificacionGuardada.getId_tipo());
        tipificacion.setEstado_tipo(ESTADO_ACTIVO);
    }

    @Override
    public void cambiarEstadoAsignacion(int id_tipo, int id_empresa, String estado) {
        String estadoNormalizado = normalizarEstado(estado);
        asignarTipificacionAEmpresa(id_empresa, id_tipo, estadoNormalizado);
    }

    @Override
    public void asignarTipificacionesBase(int id_empresa) {
        tipificacionRepository.findByEstado(ESTADO_ACTIVO).forEach(tipificacion ->
                asignarTipificacionAEmpresa(id_empresa, tipificacion.getId_tipo(), ESTADO_ACTIVO)
        );
    }

    private Tipificacion guardarNuevaTipificacion(Tipificacion tipificacion) {
        if (tipificacion.getEstado_tipo() == null || tipificacion.getEstado_tipo().isBlank()) {
            tipificacion.setEstado_tipo(ESTADO_ACTIVO);
        } else {
            tipificacion.setEstado_tipo(tipificacion.getEstado_tipo().trim().toUpperCase());
        }
        return tipificacionRepository.save(tipificacion);
    }

    private void asignarTipificacionAEmpresa(int id_empresa, int id_tipo, String estado) {
        if (!tipificacionRepository.existsById(id_tipo)) {
            return;
        }

        EmpresaTipo asignacion = empresaTipoRepository.findByEmpresaAndTipo(id_empresa, id_tipo)
                .orElseGet(() -> new EmpresaTipo(id_empresa, id_tipo));
        asignacion.setEstado_asignacion(estado);
        empresaTipoRepository.save(asignacion);
    }

    private Tipificacion obtenerTipificacionConEstadoAsignacion(EmpresaTipo asignacion) {
        return tipificacionRepository.findById(asignacion.getId_tipo())
                .map(tipificacion -> new Tipificacion(
                        tipificacion.getId_tipo(),
                        tipificacion.getMotivo_tipo(),
                        asignacion.getEstado_asignacion()))
                .orElse(null);
    }

    private void validarMotivo(Tipificacion tipificacion) {
        if (tipificacion == null || tipificacion.getMotivo_tipo() == null
                || tipificacion.getMotivo_tipo().trim().isEmpty()) {
            throw new IllegalArgumentException("El motivo de la tipificación es obligatorio.");
        }
    }

    private String normalizarEstado(String estado) {
        if (estado == null || estado.isBlank()) {
            return ESTADO_ACTIVO;
        }
        return estado.trim().toUpperCase();
    }
}