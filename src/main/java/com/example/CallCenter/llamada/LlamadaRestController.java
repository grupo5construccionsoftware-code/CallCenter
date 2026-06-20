package com.example.CallCenter.llamada;

import com.example.CallCenter.llamada.model.Llamada;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/llamada")
public class LlamadaRestController {
    private final LlamadaService llamadaService;

    public LlamadaRestController(LlamadaService llamadaService) {
        this.llamadaService = llamadaService;
    }

    @PostMapping("/crear")
    public Llamada crear(@RequestBody Llamada llamada) {
        return llamada;
    }

    @PutMapping("/actualizar")
    public Llamada actualizar(@RequestBody Llamada llamada) {
        return llamada;
    }


    @GetMapping("/listar")
    public List<Llamada> listarLlamadas() {
        return llamadaService.listarLlamadas();
    }
    
    @DeleteMapping("/borrar/{id}")
    public void borrar(@PathVariable Long id) {
    }
}
