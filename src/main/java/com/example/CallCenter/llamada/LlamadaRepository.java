package com.example.CallCenter.llamada;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Collection;
import java.util.List;

@Repository
public interface LlamadaRepository extends JpaRepository<Llamada, Integer> {

    // Llamadas de un agente
    List<Llamada> findByIdAgente(int id_agente);

    // Llamadas de varios agentes (para empresa)
    List<Llamada> findByIdAgenteIn(Collection<Integer> idsAgentes);
}


