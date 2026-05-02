package com.example.CallCenter.llamada;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class LlamadaRepository implements LlamadaDAO {

    private final List<Llamada> llamadas = new ArrayList<>();

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
        int nuevoId = llamadas.size() + 1;
        llamada.setId_llamada(nuevoId);
        llamada.setId_agente(1);
        llamada.setFecha_llamada(LocalDate.now().toString());
        llamada.setHora(LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
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
}