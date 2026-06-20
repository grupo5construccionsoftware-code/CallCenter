package com.example.CallCenter.tipificacion;

import com.example.CallCenter.tipificacion.model.Tipificacion;
import jakarta.servlet.http.HttpSession;
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

    private int obtenerIdEmpresaSesion(HttpSession session) {
        Object id = session.getAttribute("id_empresa");
        return id instanceof Integer ? (Integer) id : 1;
    }

    @GetMapping("/list")
    public String listarTipificaciones(HttpSession session, Model model) {
        int id_empresa = obtenerIdEmpresaSesion(session);
        model.addAttribute("tipificaciones", tipificacionService.listarPorEmpresa(id_empresa));
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/crear")
    public String crearTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion,
                                    HttpSession session, Model model) {
        int idEmpresa = obtenerIdEmpresaSesion(session);
        tipificacionService.crearTipificacion(tipificacion, idEmpresa);
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tipificacionCreada", tipificacion);
        return "tipificaciones";
    }

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_tipo, Model model) {
        Tipificacion tipificacion = tipificacionService.obtenerTipificacionPorId(id_tipo);
        if (tipificacion == null) return "redirect:/tipificacion/list";

        model.addAttribute("tipificacionEditar", tipificacion);
        model.addAttribute("tipificacion", new Tipificacion());
        model.addAttribute("tipificaciones", tipificacionService.listarTodas());
        model.addAttribute("mostrarTabla", true);
        return "tipificaciones";
    }

    @PostMapping("/actualizar")
    public String actualizarTipificacion(@ModelAttribute("tipificacion") Tipificacion tipificacion,
                                         HttpSession session) {
        tipificacionService.cambiarEstadoAsignacion(
                tipificacion.getId_tipo(),
                obtenerIdEmpresaSesion(session),
                tipificacion.getEstado_tipo()
        );
        return "redirect:/tipificacion/list";
    }

    @GetMapping("/eliminar")
    public String eliminarTipificacion(@RequestParam("id") int id_tipo, HttpSession session) {
        tipificacionService.cambiarEstadoAsignacion(id_tipo, obtenerIdEmpresaSesion(session), "ELIMINADO");
        return "redirect:/tipificacion/list";
    }
}
