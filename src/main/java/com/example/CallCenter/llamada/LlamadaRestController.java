package com.example.CallCenter.llamada;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/llamada")
public class LlamadaRestController {
    private final LlamadaService llamadaService;

    public LlamadaRestController(LlamadaService llamadaService) {
        this.llamadaService = llamadaService;
    }

    @PostMapping("/crear")
    public Llamada crear(@RequestBody Llamada llamada) {
        Llamada llamada_resp = new Llamada();
        //llamada_resp.setNombre_cliente(llamada.getNombre_cliente()); //F2
        //llamada_resp.setTelefono_cliente(llamada.getTelefono_cliente()); //F2
        //llamada_resp.setFecha_llamada(llamada.getFecha_llamada()); //F2
        //llamada_resp.setHora(llamada.getHora()); //F2
        //llamadaService.crearLlamada(llamada); //F3
        return llamada_resp;
    }

    @PutMapping("/actualizar")
    public Llamada actualizar(@RequestBody Llamada llamada) {
        Llamada llamada_resp = new Llamada();
        //llamada_resp.setId_llamada(llamada.getId_llamada()); //F2
        //llamada_resp.setNombre_cliente(llamada.getNombre_cliente()); //F2
        //llamada_resp.setTelefono_cliente(llamada.getTelefono_cliente()); //F2
        //llamadaService.actualizarLlamada(llamada); //F3
        return llamada_resp;
    }
}
