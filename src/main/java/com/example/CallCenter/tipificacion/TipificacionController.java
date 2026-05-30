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

    private void cargarDatosBase(Model model) {
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("tiposLlamada", tipificacionService.listarTiposLlamada());
    }

    @GetMapping("/list")
    public String listarTipificaciones(Model model) {
        cargarDatosBase(model);
        model.addAttribute("tipificaciones", tipificacionService.listarTipificaciones());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/crear")
    public String crearTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion, Model model) {
        tipificacionService.crearTipificacion(tipificacion);
        cargarDatosBase(model);
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tipificacionCreada", tipificacion);
        return "tipificaciones";
    }

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_tipo, Model model) {
        cargarDatosBase(model);
        model.addAttribute("tipificacionEditar", tipificacionService.obtenerTipificacionPorId(id_tipo));
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