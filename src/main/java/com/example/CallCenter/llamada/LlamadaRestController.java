package com.example.CallCenter.llamada;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.ArrayList;

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


    @GetMapping("/listar")
    public List<Llamada> listarLlamadas() {
        List<Llamada> llamadas_resp = new ArrayList<>();//F1

        //Llamada llamada_demo = new Llamada(); //F2
        //llamada_demo.setNombre_cliente("Maria Lopez"); //F2
        //llamada_demo.setTelefono_cliente("987654321"); //F2
        //llamadas_resp.add(llamada_demo); //F2

        //llamadas_resp = llamadaService.listarLlamadas(); //F3
        return llamadas_resp;//F1
    }
    
    @DeleteMapping("/borrar/{id}")
    public void borrar(@PathVariable Long id) {
        //llamadaService.borrarLlamada(id); //F3
        //llamadaService.borrarLlamada(id); //F3
    }
}
