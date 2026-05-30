package com.example.CallCenter.llamada;

import com.example.CallCenter.tipificacion.Tipificacion;
import com.example.CallCenter.tipificacion.TipificacionService;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public String listarLlamadas(HttpSession session, Model model) {
        List<Llamada> llamadas = "agente".equals(session.getAttribute("rol"))
                ? llamadaService.listarLlamadasPorAgente(obtenerIdAgenteSesion(session))
                : llamadaService.listarLlamadas();
        model.addAttribute("llamadas", llamadas);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        model.addAttribute("mostrarTabla", true);
        model.addAttribute("mostrarFormulario", false);
        return "llamadas";
    }

    // Muestra el formulario de registro con hora de inicio guardada en sesión
    @GetMapping("/comenzar")
    public String comenzarRegistro(HttpSession session, Model model) {
        String horaInicio = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
        session.setAttribute("horaInicio", horaInicio);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        model.addAttribute("mostrarFormulario", true);
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("horaInicio", horaInicio);
        return "llamadas";
    }

    // Finaliza el registro calculando la duración
    @PostMapping("/crear")
public String crearLlamada(@ModelAttribute("llamada") Llamada llamada,
                           HttpSession session, Model model) {
    llamada.setId_agente(obtenerIdAgenteSesion(session));

    String horaInicio = (String) session.getAttribute("horaInicio");
    String horaFin = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));

    if (horaInicio != null) {
        try {
            LocalTime inicio = LocalTime.parse(horaInicio);
            LocalTime fin = LocalTime.parse(horaFin);
            long segundos = java.time.Duration.between(inicio, fin).getSeconds();
            long min = segundos / 60;
            long seg = segundos % 60;
            llamada.setDuracion(String.format("%02d:%02d", min, seg));
        } catch (Exception e) {
            llamada.setDuracion("00:00");
        }
        session.removeAttribute("horaInicio");
    } else {
        llamada.setDuracion("00:00");
    }

    llamada.setFecha_llamada(LocalDate.now().toString());
    llamada.setHora(horaFin);
    llamada.setEstado("activo");

    tipificacionService.listarTipificaciones().stream()
            .filter(t -> t.getId_tipo() == llamada.getId_tipo())
            .findFirst()
            .ifPresent(t -> llamada.setMotivo_tipo(t.getMotivo_tipo()));

    llamadaService.crearLlamada(llamada);

    model.addAttribute("llamada", new Llamada());
    model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
    model.addAttribute("llamadaCreada", llamada);
    model.addAttribute("mostrarFormulario", false);
    model.addAttribute("mostrarTabla", false);
    return "llamadas";
}
    // Editar inline: recarga llamadas.jsp con datos del registro
    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_llamada, Model model) {
        model.addAttribute("llamadaEditar", llamadaService.obtenerLlamadaPorId(id_llamada));
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        model.addAttribute("llamadas", llamadaService.listarLlamadas());
        model.addAttribute("mostrarTabla", true);
        model.addAttribute("mostrarFormulario", false);
        return "llamadas";
    }

    @PostMapping("/actualizar")
    public String actualizarLlamada(@ModelAttribute("llamada") Llamada llamada) {
        // Asignar motivo_tipo desde tipificación
        tipificacionService.listarTipificaciones().stream()
                .filter(t -> t.getId_tipo() == llamada.getId_tipo())
                .findFirst()
                .ifPresent(t -> llamada.setMotivo_tipo(t.getMotivo_tipo()));
        llamadaService.actualizarLlamada(llamada);
        return "redirect:/llamada/list";
    }

    @GetMapping("/eliminar")
    public String eliminarLlamada(@RequestParam("id") int id_llamada) {
        llamadaService.eliminarLlamada(id_llamada);
        return "redirect:/llamada/list";
    }

    private int obtenerIdAgenteSesion(HttpSession session) {
        Object idAgente = session.getAttribute("id_agente");
        return idAgente instanceof Integer ? (Integer) idAgente : 1;
    }
}
