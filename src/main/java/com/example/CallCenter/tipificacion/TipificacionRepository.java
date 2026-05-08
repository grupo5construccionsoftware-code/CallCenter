package com.example.CallCenter.tipificacion;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.example.CallCenter.llamada.LlamadaDAO;
import com.example.CallCenter.llamada.Llamada;

@Repository
public class TipificacionRepository implements TipificacionDAO {

    private final List<Tipificacion> tipificaciones = new ArrayList<>();
    private final List<String> motivosBase = Arrays.asList("Consulta", "Reclamo", "Venta", "Soporte");
    private final List<String> tiposLlamada = new ArrayList<>();
    private final LlamadaDAO llamadaDAO;

    public TipificacionRepository(LlamadaDAO llamadaDAO) {
        this.llamadaDAO = llamadaDAO;
        cargarTipificacionesIniciales();
    }

    @Override
    public List<Tipificacion> listarTipificaciones() {
        return tipificaciones;
    }

    @Override
    public List<String> listarTiposLlamada() {
        return tiposLlamada;
    }

    @Override
    public void agregarTipoLlamada(String motivo) {
        if (motivo == null || motivo.trim().isEmpty()) {
            return;
        }

        String motivoLimpio = motivo.trim();
        boolean existe = tiposLlamada.stream()
                .anyMatch(tipo -> tipo.equalsIgnoreCase(motivoLimpio));

        if (!existe) {
            tiposLlamada.add(motivoLimpio);
        }
    }

    @Override
    public void eliminarTipoLlamada(int idTipo) {
        if (idTipo >= 1 && idTipo <= tiposLlamada.size()) {
            tiposLlamada.remove(idTipo - 1);
        }
    }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_llamada) {
        return tipificaciones.stream()
                .filter(t -> t.getId_llamada() == id_llamada)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void crearTipificacion(Tipificacion tipificacion) {
        Llamada llamada = llamadaDAO.obtenerLlamadaPorId(tipificacion.getId_llamada());
        if (llamada != null) {
            tipificacion.setNombre_cliente(llamada.getNombre_cliente());
        }
        asignarMotivo(tipificacion);
        tipificaciones.add(tipificacion);
    }

    @Override
    public void actualizarTipificacion(Tipificacion tipificacion) {
        for (int i = 0; i < tipificaciones.size(); i++) {
            if (tipificaciones.get(i).getId_llamada() == tipificacion.getId_llamada()) {
                tipificacion.setNombre_cliente(tipificaciones.get(i).getNombre_cliente());
                asignarMotivo(tipificacion);
                tipificaciones.set(i, tipificacion);
                break;
            }
        }
    }

    @Override
    public void eliminarTipificacion(int id_llamada) {
        tipificaciones.removeIf(t -> t.getId_llamada() == id_llamada);
    }

    private void asignarMotivo(Tipificacion tipificacion) {
        Integer idTipo = tipificacion.getId_tipo();
        if (idTipo == null) {
            return;
        }

        if (idTipo >= 1 && idTipo <= motivosBase.size()) {
            tipificacion.setMotivo_tipo(motivosBase.get(idTipo - 1));
            return;
        }

        if (idTipo == 5) {
            tipificacion.setMotivo_tipo("Otros");
            return;
        }

        int indiceTipoAgregado = idTipo - 6;
        if (indiceTipoAgregado >= 0 && indiceTipoAgregado < tiposLlamada.size()) {
            tipificacion.setMotivo_tipo(tiposLlamada.get(indiceTipoAgregado));
        }
    }

    private void cargarTipificacionesIniciales() {
        agregarTipificacionInicial(1, 1, "Maria Lopez", "Cliente consulta el estado de su solicitud.");
        agregarTipificacionInicial(2, 2, "Carlos Perez", "Cliente presenta reclamo por cobro duplicado.");
        agregarTipificacionInicial(3, 3, "Ana Torres", "Cliente solicita informacion sobre una promocion.");
        agregarTipificacionInicial(4, 4, "Luis Ramirez", "Cliente requiere soporte para ingresar al sistema.");
        agregarTipificacionInicial(5, 5, "Rosa Garcia", "Cliente reporta un caso adicional durante la atencion.");
    }

    private void agregarTipificacionInicial(int idLlamada, int idTipo, String cliente, String descripcion) {
        agregarTipificacionInicial(idLlamada, idTipo, cliente, descripcion, null);
    }

    private void agregarTipificacionInicial(int idLlamada, int idTipo, String cliente, String descripcion, String tipoAdicional) {
        Tipificacion tipificacion = new Tipificacion();
        tipificacion.setId_llamada(idLlamada);
        tipificacion.setId_tipo(idTipo);
        tipificacion.setNombre_cliente(cliente);
        tipificacion.setDescripcion_tipo(descripcion);
        tipificacion.setTipo_adicional(tipoAdicional);
        asignarMotivo(tipificacion);
        tipificaciones.add(tipificacion);
    }
}
