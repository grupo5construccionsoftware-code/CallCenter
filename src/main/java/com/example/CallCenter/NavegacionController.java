package com.example.CallCenter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import java.util.List;
import com.example.CallCenter.llamada.Llamada;
import com.example.CallCenter.llamada.LlamadaService;
import com.example.CallCenter.tipificacion.Tipificacion;
import com.example.CallCenter.tipificacion.TipificacionService;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Arrays;


@Controller
public class NavegacionController {

    private final LlamadaService llamadaService;
    private final TipificacionService tipificacionService;

    public NavegacionController(LlamadaService llamadaService, TipificacionService tipificacionService) {
        this.llamadaService = llamadaService;
        this.tipificacionService = tipificacionService;
    }

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
        List<Llamada> historial = llamadaService.listarLlamadas();
        Map<Integer, Tipificacion> tipificacionesPorLlamada = tipificacionService.listarTipificaciones()
                .stream()
                .collect(Collectors.toMap(Tipificacion::getId_llamada, tipificacion -> tipificacion, (actual, ignorar) -> actual));

        List<String> motivosDisponibles = tipificacionService.listarTipificaciones()
                .stream()
                .map(Tipificacion::getMotivo_tipo)
                .filter(motivo -> motivo != null && !motivo.trim().isEmpty())
                .distinct()
                .collect(Collectors.toList());

        if (motivosDisponibles.isEmpty()) {
            motivosDisponibles = Arrays.asList("Consulta", "Reclamo", "Venta", "Soporte", "Otros");
        }

        model.addAttribute("historialLlamadas", historial);
        model.addAttribute("tipificacionesPorLlamada", tipificacionesPorLlamada);
        model.addAttribute("motivosDisponibles", motivosDisponibles);
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
