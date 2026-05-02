package com.example.CallCenter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NavegacionController {

    @GetMapping("/")
    public String home() {
        return "main";
    }

    @GetMapping("/main")
    public String paginamain() {
        return "main";
    }


    @GetMapping("/publicidad")
    public String publicidad() {
        return "publicidad";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/gestion")
    public String gestion() {
        return "gestion";
    }

    @GetMapping("/llamadas")
    public String llamadas(Model model) {
        model.addAttribute("llamada", new com.example.CallCenter.llamada.Llamada());
        model.addAttribute("mostrarTabla", false);
        return "llamadas";
    }

    @GetMapping("/contacto")
    public String contacto() {
        return "contacto";
    }

    @GetMapping("/tipificaciones")
    public String tipificaciones(Model model) {
        model.addAttribute("tipificacion", new com.example.CallCenter.tipificacion.Tipificacion());
        model.addAttribute("mostrarTabla", false);
        return "tipificaciones";
    }

    @GetMapping("/usuarios")
    public String usuarios(Model model) {
        model.addAttribute("agente", new com.example.CallCenter.agente.Agente());
        model.addAttribute("mostrarTabla", false);
        return "usuarios";
    }

    @GetMapping("/metricas")
    public String metricas() {
        return "metricas";
    }

    @GetMapping("/adicional1")
    public String adicional1(Model model) {
        List<Map<String, String>> historial = new ArrayList<>();

        Map<String, String> llamada1 = new LinkedHashMap<>();
        llamada1.put("idLlamada", "1");
        llamada1.put("nombreCliente", "Alex Pérez");
        llamada1.put("telefonoCliente", "123456789");
        llamada1.put("motivoTipo", "Reclamo");
        llamada1.put("fechaLlamada", "2026-04-10");
        llamada1.put("hora", "10:30");
        llamada1.put("nombreAgente", "Pepito García");
        historial.add(llamada1);

        Map<String, String> llamada2 = new LinkedHashMap<>();
        llamada2.put("idLlamada", "2");
        llamada2.put("nombreCliente", "Lucía Torres");
        llamada2.put("telefonoCliente", "987654321");
        llamada2.put("motivoTipo", "Consulta");
        llamada2.put("fechaLlamada", "2026-04-11");
        llamada2.put("hora", "11:10");
        llamada2.put("nombreAgente", "María Ramos");
        historial.add(llamada2);

        model.addAttribute("historialLlamadas", historial);

        return "adicional1";
    }

    @GetMapping("/adicional3")
    public String adicional3() {
        return "adicional3";
    }

    @GetMapping("/adicional4")
    public String adicional4() {
        return "adicional4";
    }

    @GetMapping("/adicional5")
    public String adicional5() {
        return "adicional5";
    }
}
