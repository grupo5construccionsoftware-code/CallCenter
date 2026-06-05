package com.example.CallCenter.llamada;

import java.util.Collection;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class LlamadaServiceImpl implements LlamadaService {

    private final LlamadaRepository llamadaRepository;

    public LlamadaServiceImpl(LlamadaRepository llamadaRepository) {
        this.llamadaRepository = llamadaRepository;
    }

    @Override
    public List<Llamada> listarLlamadas() {
        return llamadaRepository.findAll();
    }

    @Override
    public List<Llamada> listarLlamadasPorAgente(int idAgente) {
        return llamadaRepository.findByIdAgente(idAgente);
    }

    @Override
    public List<Llamada> listarLlamadasPorAgentes(Collection<Integer> idsAgentes) {
        return llamadaRepository.findByIdAgenteIn(idsAgentes);
    }

    @Override
    public Llamada obtenerLlamadaPorId(int id_llamada) {
        return llamadaRepository.findById(id_llamada).orElse(null);
    }

    @Override
    public void crearLlamada(Llamada llamada) {
        llamadaRepository.save(llamada);
    }

    @Override
    public void actualizarLlamada(Llamada llamada) {
        llamadaRepository.save(llamada);
    }

    @Override
    public void eliminarLlamada(int id_llamada) {
        llamadaRepository.deleteById(id_llamada);
    }
}