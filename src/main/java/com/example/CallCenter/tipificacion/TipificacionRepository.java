package com.example.CallCenter.tipificacion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.example.CallCenter.llamada.LlamadaDAO;
import com.example.CallCenter.llamada.Llamada;

@Repository
public class TipificacionRepository implements TipificacionDAO {

    private final List<Tipificacion> tipificaciones = new ArrayList<>();
    private final String[] motivos = {"", "Consulta", "Reclamo", "Venta", "Soporte", "Otros"};
    private final LlamadaDAO llamadaDAO;

    public TipificacionRepository(LlamadaDAO llamadaDAO) {
        this.llamadaDAO = llamadaDAO;
    }

    @Override
    public List<Tipificacion> listarTipificaciones() {
        return tipificaciones;
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
        if (tipificacion.getId_tipo() >= 1 && tipificacion.getId_tipo() <= 5) {
            tipificacion.setMotivo_tipo(motivos[tipificacion.getId_tipo()]);
        }
        tipificaciones.add(tipificacion);
    }

    @Override
    public void actualizarTipificacion(Tipificacion tipificacion) {
        for (int i = 0; i < tipificaciones.size(); i++) {
            if (tipificaciones.get(i).getId_llamada() == tipificacion.getId_llamada()) {
                tipificacion.setNombre_cliente(tipificaciones.get(i).getNombre_cliente());
                if (tipificacion.getId_tipo() >= 1 && tipificacion.getId_tipo() <= 5) {
                    tipificacion.setMotivo_tipo(motivos[tipificacion.getId_tipo()]);
                }
                tipificaciones.set(i, tipificacion);
                break;
            }
        }
    }

    @Override
    public void eliminarTipificacion(int id_llamada) {
        tipificaciones.removeIf(t -> t.getId_llamada() == id_llamada);
    }
}