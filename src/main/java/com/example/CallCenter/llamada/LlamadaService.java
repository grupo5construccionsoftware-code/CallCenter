package com.example.CallCenter.llamada;

import com.example.CallCenter.llamada.model.Llamada;
import java.util.Collection;
import java.util.List;

public interface LlamadaService {
    List<Llamada> listarLlamadas();
    List<Llamada> listarLlamadasPorAgente(int idAgente);
    List<Llamada> listarLlamadasPorAgentes(Collection<Integer> idsAgentes);
    Llamada obtenerLlamadaPorId(int id_llamada);
    void crearLlamada(Llamada llamada);
    void actualizarLlamada(Llamada llamada);
    void eliminarLlamada(int id_llamada);
}