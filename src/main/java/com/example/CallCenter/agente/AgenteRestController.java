package com.example.CallCenter.agente;

import com.example.CallCenter.agente.model.Agente;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/agente")
public class AgenteRestController {

    private final AgenteService agenteService;

    public AgenteRestController(AgenteService agenteService) {
        this.agenteService = agenteService;
    }

    @PostMapping("/crear")
    public Agente crearAgente(@RequestBody Agente agente) {
        agenteService.crearAgente(agente);
        return agente;
    }

    @PutMapping("/actualizar")
    public Agente actualizarAgente(@RequestBody Agente agente) {
        agenteService.actualizarAgente(agente);
        return agenteService.obtenerAgentePorId(agente.getId_agente());
    }
}
