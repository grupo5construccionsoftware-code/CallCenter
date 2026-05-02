package com.example.CallCenter.llamada;

import java.util.List;

public interface LlamadaDAO {
    List<Llamada> listarLlamadas();
    Llamada obtenerLlamadaPorId(int id_llamada);
    void crearLlamada(Llamada llamada);
    void actualizarLlamada(Llamada llamada);
    void eliminarLlamada(int id_llamada);
}