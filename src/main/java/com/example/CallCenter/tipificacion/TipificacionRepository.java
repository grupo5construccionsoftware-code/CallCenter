package com.example.CallCenter.tipificacion;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Repository;

@Repository
public class TipificacionRepository implements TipificacionDAO {

    private final List<Tipificacion> tipificaciones = new ArrayList<>();
    private int contadorId = 6;

    public TipificacionRepository() {
        cargarTipificacionesIniciales();
    }

    @Override
    public List<Tipificacion> listarTipificaciones() {
        return tipificaciones;
    }

    @Override
    public List<String> listarTiposLlamada() {
        return tipificaciones.stream()
                .map(Tipificacion::getMotivo_tipo)
                .collect(Collectors.toList());
    }

    @Override
    public Tipificacion obtenerTipificacionPorId(int id_tipo) {
        return tipificaciones.stream()
                .filter(t -> t.getId_tipo() == id_tipo)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void crearTipificacion(Tipificacion tipificacion) {
        tipificacion.setId_tipo(contadorId);
        tipificacion.setId_empresa(1);
        contadorId++;
        tipificaciones.add(tipificacion);
    }

    @Override
    public void actualizarTipificacion(Tipificacion tipificacion) {
        for (int i = 0; i < tipificaciones.size(); i++) {
            if (tipificaciones.get(i).getId_tipo() == tipificacion.getId_tipo()) {
                tipificacion.setId_empresa(tipificaciones.get(i).getId_empresa());
                tipificaciones.set(i, tipificacion);
                break;
            }
        }
    }

    @Override
    public void eliminarTipificacion(int id_tipo) {
        tipificaciones.removeIf(t -> t.getId_tipo() == id_tipo);
    }

    private void cargarTipificacionesIniciales() {
        tipificaciones.add(new Tipificacion(1, "Consulta",  "El cliente solicita información general.", 1));
        tipificaciones.add(new Tipificacion(2, "Reclamo",   "El cliente presenta una queja formal.", 1));
        tipificaciones.add(new Tipificacion(3, "Venta",     "El cliente adquiere un producto o servicio.", 1));
        tipificaciones.add(new Tipificacion(4, "Soporte",   "El cliente necesita asistencia técnica.", 1));
        tipificaciones.add(new Tipificacion(5, "Otros",     "Casos que no encajan en las categorías anteriores.", 1));
    }
}