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
    private int contadorId = 6;

    {
        llamadas.add(new Llamada(1, "Maria Lopez", "911111111", "2026-04-01", "09:15", 1));
        llamadas.add(new Llamada(2, "Carlos Perez", "922222222", "2026-04-02", "10:30", 2));
        llamadas.add(new Llamada(3, "Ana Torres", "933333333", "2026-04-03", "11:45", 3));
        llamadas.add(new Llamada(4, "Luis Ramirez", "944444444", "2026-04-04", "14:00", 4));
        llamadas.add(new Llamada(5, "Rosa García", "955555555", "2026-04-05", "15:30", 5));
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
        llamada.setId_llamada(contadorId);
        llamada.setId_agente(1);
        llamada.setFecha_llamada(LocalDate.now().toString());
        llamada.setHora(LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
        contadorId++;
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