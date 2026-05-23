package com.example.CallCenter.llamada;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import com.example.CallCenter.tipificacion.TipificacionDAO;
import com.example.CallCenter.tipificacion.Tipificacion;

import org.springframework.stereotype.Repository;

@Repository
public class LlamadaRepository implements LlamadaDAO {

    private final List<Llamada> llamadas = new ArrayList<>();
    private final TipificacionDAO tipificacionDAO;

    public LlamadaRepository(TipificacionDAO tipificacionDAO) {
        this.tipificacionDAO = tipificacionDAO;
        cargarLlamadasIniciales();
    }

    @Override
    public List<Llamada> listarLlamadas() {
        return llamadas;
    }

    @Override
    public Llamada obtenerLlamadaPorId(int id_llamada) {
        return llamadas.stream()
                .filter(l -> l.getId_llamada() == id_llamada)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void crearLlamada(Llamada llamada) {
        int nuevoId = llamadas.stream()
                .mapToInt(Llamada::getId_llamada)
                .max()
                .orElse(0) + 1;
        llamada.setId_llamada(nuevoId);
        llamada.setId_agente(1);
        llamada.setFecha_llamada(LocalDate.now().toString());
        llamada.setHora(LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
        asignarMotivo(llamada);
        llamadas.add(llamada);
    }

    @Override
    public void actualizarLlamada(Llamada llamada) {
        for (int i = 0; i < llamadas.size(); i++) {
            if (llamadas.get(i).getId_llamada() == llamada.getId_llamada()) {
                llamada.setFecha_llamada(llamadas.get(i).getFecha_llamada());
                llamada.setHora(llamadas.get(i).getHora());
                llamada.setId_agente(llamadas.get(i).getId_agente());
                llamadas.set(i, llamada);
                break;
            }
        }
    }

    @Override
    public void eliminarLlamada(int id_llamada) {
        llamadas.removeIf(l -> l.getId_llamada() == id_llamada);
    }

    private void cargarLlamadasIniciales() {
        llamadas.add(crearLlamadaInicial(1, "Maria Lopez", "987654321", "2026-05-01", "09:10", 1, 1, "Consulta"));
        llamadas.add(crearLlamadaInicial(2, "Carlos Perez", "923456781", "2026-05-02", "10:25", 1, 2, "Reclamo"));
        llamadas.add(crearLlamadaInicial(3, "Ana Torres", "934567812", "2026-05-03", "11:40", 1, 3, "Venta"));
        llamadas.add(crearLlamadaInicial(4, "Luis Ramirez", "945678123", "2026-05-04", "13:15", 1, 4, "Soporte"));
        llamadas.add(crearLlamadaInicial(5, "Rosa Garcia", "956781234", "2026-05-05", "15:05", 1, 5, "Otros"));
    }

    private Llamada crearLlamadaInicial(int id, String cliente, String telefono, String fecha, String hora, int idAgente, int idTipo, String motivo) {
        Llamada llamada = new Llamada();
        llamada.setId_llamada(id);
        llamada.setNombre_cliente(cliente);
        llamada.setTelefono_cliente(telefono);
        llamada.setFecha_llamada(fecha);
        llamada.setHora(hora);
        llamada.setId_agente(idAgente);
        llamada.setId_tipo(idTipo);
        llamada.setMotivo_tipo(motivo);
        return llamada;
    }

    private void asignarMotivo(Llamada llamada) {
        Integer idTipo = llamada.getId_tipo();
        if (idTipo == null) return;
        Tipificacion tip = tipificacionDAO.obtenerTipificacionPorId(idTipo);
        if (tip != null) {
            llamada.setMotivo_tipo(tip.getMotivo_tipo());
        }
    }
}
