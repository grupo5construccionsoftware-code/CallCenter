package com.example.CallCenter.tipificacion;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Repository;

@Repository
public class TipificacionRepository implements TipificacionDAO {

    private final List<Tipificacion> tipificaciones = new ArrayList<>();
    private final List<EmpresaTipo> empresaTipos = new ArrayList<>();
    private int contadorId = 6;

    public TipificacionRepository() {
        cargarTipificacionesGlobales();
        asignarTipificacionesBase(1);
    }

    @Override
    public List<Tipificacion> listarTodas() {
        return tipificaciones;
    }

    @Override
    public List<Tipificacion> listarPorEmpresa(int id_empresa) {
        return empresaTipos.stream()
                .filter(et -> et.getId_empresa() == id_empresa)
                .map(et -> {
                    Tipificacion t = tipificaciones.stream()
                            .filter(tip -> tip.getId_tipo() == et.getId_tipo())
                            .findFirst().orElse(null);
                    if (t == null) return null;
                    Tipificacion copia = new Tipificacion(t.getId_tipo(), t.getMotivo_tipo(), et.getEstado_asignacion());
                    return copia;
                })
                .filter(t -> t != null)
                .collect(Collectors.toList());
    }

    @Override
    public List<Tipificacion> listarActivasPorEmpresa(int id_empresa) {
        List<Integer> ids = empresaTipos.stream()
                .filter(et -> et.getId_empresa() == id_empresa
                        && "ACTIVO".equals(et.getEstado_asignacion()))
                .map(EmpresaTipo::getId_tipo)
                .collect(Collectors.toList());
        return tipificaciones.stream()
                .filter(t -> ids.contains(t.getId_tipo()))
                .collect(Collectors.toList());
    }

    @Override
    public List<String> listarMotivosPorEmpresa(int id_empresa) {
        return listarPorEmpresa(id_empresa).stream()
                .map(Tipificacion::getMotivo_tipo)
                .collect(Collectors.toList());
    }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_tipo) {
        return tipificaciones.stream()
                .filter(t -> t.getId_tipo() == id_tipo)
                .findFirst().orElse(null);
    }

    @Override
    public Tipificacion buscarPorMotivo(String motivo_tipo) {
        return tipificaciones.stream()
                .filter(t -> t.getMotivo_tipo().equalsIgnoreCase(motivo_tipo))
                .findFirst().orElse(null);
    }

    @Override
    public void crearTipificacion(Tipificacion tipificacion, int id_empresa) {
        Tipificacion existente = buscarPorMotivo(tipificacion.getMotivo_tipo());
        if (existente != null) {
            tipificacion.setId_tipo(existente.getId_tipo());
        } else {
            tipificacion.setId_tipo(contadorId);
            tipificacion.setEstado_tipo("ACTIVO");
            contadorId++;
            tipificaciones.add(tipificacion);
        }
        boolean yaAsignada = empresaTipos.stream()
                .anyMatch(et -> et.getId_empresa() == id_empresa
                        && et.getId_tipo() == tipificacion.getId_tipo());
        if (!yaAsignada) {
            empresaTipos.add(new EmpresaTipo(id_empresa, tipificacion.getId_tipo()));
        }
    }


    @Override
    public void cambiarEstadoAsignacion(int id_tipo, int id_empresa, String estado) {
        empresaTipos.stream()
                .filter(et -> et.getId_tipo() == id_tipo && et.getId_empresa() == id_empresa)
                .findFirst()
                .ifPresent(et -> et.setEstado_asignacion(estado));
    }

    @Override
    public void asignarTipificacionesBase(int id_empresa) {
        for (int i = 1; i <= 5; i++) {
            int finalI = i;
            boolean yaAsignada = empresaTipos.stream()
                    .anyMatch(et -> et.getId_empresa() == id_empresa && et.getId_tipo() == finalI);
            if (!yaAsignada) {
                empresaTipos.add(new EmpresaTipo(id_empresa, i));
            }
        }
    }

    private void cargarTipificacionesGlobales() {
        tipificaciones.add(new Tipificacion(1, "Consulta", "ACTIVO"));
        tipificaciones.add(new Tipificacion(2, "Reclamo",  "ACTIVO"));
        tipificaciones.add(new Tipificacion(3, "Venta",    "ACTIVO"));
        tipificaciones.add(new Tipificacion(4, "Soporte",  "ACTIVO"));
        tipificaciones.add(new Tipificacion(5, "Otros",    "ACTIVO"));
    }
}
