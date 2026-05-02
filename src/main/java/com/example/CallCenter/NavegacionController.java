package com.example.CallCenter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

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

    @GetMapping("/login")
    public String login() {
        return "login";
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
    public String adicional1() {
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
