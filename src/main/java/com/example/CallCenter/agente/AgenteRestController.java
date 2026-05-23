package com.example.CallCenter.agente;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
        Agente agente_resp = new Agente();//F1
        //agente_resp.setNombre_agente(agente.getNombre_agente()); //F2
        //agente_resp.setTelefono_agente(agente.getTelefono_agente()); //F2
        //agenteService.crearAgente(agente); //F3
        return agente_resp;//F1
        //return agente;//F3
    }

    @PutMapping("/actualizar")
    public Agente actualizarAgente(@RequestBody Agente agente) {

        Agente agente_resp = new Agente();//F1
        //agente_resp.setNombre_agente(agente.getNombre_agente());    //F2
        //agente_resp.setTelefono_agente(agente.getTelefono_agente());//F2
        //agenteService.actualizarAgente(agente);                       //F3
        return agente_resp;//F1
        //return agente;//F3
    }
}