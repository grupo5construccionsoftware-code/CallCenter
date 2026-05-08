package com.example.CallCenter.tipificacion;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/tipificacion")
public class TipificacionController {

    private final TipificacionService tipificacionService;

    public TipificacionController(TipificacionService tipificacionService) {
        this.tipificacionService = tipificacionService;
    }

    @GetMapping("/list")
    public String listarTipificaciones(Model model) {
        List<Tipificacion> tipificaciones = tipificacionService.listarTipificaciones();
        model.addAttribute("tipificaciones", tipificaciones);
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("tiposLlamada", tipificacionService.listarTiposLlamada());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/crear")
    public String crearTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion, Model model) {
        tipificacionService.crearTipificacion(tipificacion);
        model.addAttribute("tipificaciones", tipificacionService.listarTipificaciones());
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("tiposLlamada", tipificacionService.listarTiposLlamada());
        model.addAttribute("mostrarTabla", true);
        model.addAttribute("guardado", true);
        return "tipificaciones";
    }

    @PostMapping("/tipo/crear")
    public String crearTipoLlamada(@RequestParam("nuevoTipo") String nuevoTipo) {
        tipificacionService.agregarTipoLlamada(nuevoTipo);
        return "redirect:/tipificaciones";
    }

    @PostMapping("/tipo/eliminar")
    public String eliminarTipoLlamada(@RequestParam("idTipo") int idTipo) {
        tipificacionService.eliminarTipoLlamada(idTipo);
        return "redirect:/tipificaciones";
    }

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_llamada, Model model) {
        Tipificacion tipificacion = tipificacionService.obtenerTipificacionPorId(id_llamada);
        model.addAttribute("tipificacion", tipificacion);
        model.addAttribute("tiposLlamada", tipificacionService.listarTiposLlamada());
        return "adicional4";
    }

    @PostMapping("/actualizar")
    public String actualizarTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion) {
        tipificacionService.actualizarTipificacion(tipificacion);
        return "redirect:/tipificacion/list";
    }

    @GetMapping("/eliminar")
    public String eliminarTipificacion(@RequestParam("id") int id_llamada) {
        tipificacionService.eliminarTipificacion(id_llamada);
        return "redirect:/tipificacion/list";
    }
}
