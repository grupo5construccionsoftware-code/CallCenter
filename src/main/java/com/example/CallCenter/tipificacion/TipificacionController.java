package com.example.CallCenter.tipificacion;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tipificacion")
public class TipificacionController {

    private final TipificacionService tipificacionService;

    public TipificacionController(TipificacionService tipificacionService) {
        this.tipificacionService = tipificacionService;
    }

    @GetMapping("/list")
    public String listarTipificaciones(Model model) {
        model.addAttribute("tipificaciones", tipificacionService.listarTipificaciones());
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/crear")
    public String crearTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion,
                                    Model model) {
        tipificacionService.crearTipificacion(tipificacion);
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tipificacionCreada", tipificacion);
        return "tipificaciones";
    }

    // ─── Edición inline: pone tipificacionEditar en el modelo y devuelve tipificaciones.jsp ──
    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_tipo, Model model) {
        Tipificacion tipificacion = tipificacionService.obtenerTipificacionPorId(id_tipo);
        if (tipificacion == null) return "redirect:/tipificacion/list";

        model.addAttribute("tipificacionEditar", tipificacion);
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("tipificaciones", tipificacionService.listarTipificaciones());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/actualizar")
    public String actualizarTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion) {
        tipificacionService.actualizarTipificacion(tipificacion);
        return "redirect:/tipificacion/list";
    }

    @GetMapping("/eliminar")
    public String eliminarTipificacion(@RequestParam("id") int id_tipo) {
        tipificacionService.eliminarTipificacion(id_tipo);
        return "redirect:/tipificacion/list";
    }
}
