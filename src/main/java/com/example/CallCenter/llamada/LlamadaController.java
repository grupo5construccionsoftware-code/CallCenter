package com.example.CallCenter.llamada;

import com.example.CallCenter.tipificacion.TipificacionService;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/llamada")
public class LlamadaController {

    private final LlamadaService llamadaService;
    private final TipificacionService tipificacionService;

    public LlamadaController(LlamadaService llamadaService, TipificacionService tipificacionService) {
        this.llamadaService = llamadaService;
        this.tipificacionService = tipificacionService;
    }

    @GetMapping("/list")
    public String listarLlamadas(Model model) {
        List<Llamada> llamadas = llamadaService.listarLlamadas();
        model.addAttribute("llamadas", llamadas);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        model.addAttribute("mostrarTabla", true);
        return "llamadas";
    }

    @PostMapping("/crear")
    public String crearLlamada(@ModelAttribute("llamada") Llamada llamada, Model model) {
        llamadaService.crearLlamada(llamada);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        model.addAttribute("llamadaCreada", llamada);
        return "llamadas";
    }

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_llamada, Model model) {
        Llamada llamada = llamadaService.obtenerLlamadaPorId(id_llamada);
        model.addAttribute("llamada", llamada);
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        return "adicional3";
    }

    @PostMapping("/actualizar")
    public String actualizarLlamada(@ModelAttribute("llamada") Llamada llamada) {
        llamadaService.actualizarLlamada(llamada);
        return "redirect:/llamada/list";
    }

    @GetMapping("/eliminar")
    public String eliminarLlamada(@RequestParam("id") int id_llamada) {
        llamadaService.eliminarLlamada(id_llamada);
        return "redirect:/llamada/list";
    }
}