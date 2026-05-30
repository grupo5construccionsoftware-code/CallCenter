package com.example.CallCenter.agente;

import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/agente")
public class AgenteController {

    private final AgenteService agenteService;

    public AgenteController(AgenteService agenteService) {
        this.agenteService = agenteService;
    }

    @GetMapping("/list")
    public String listarAgentes(HttpSession session, Model model) {
        model.addAttribute("agentes", filtrarAgentesPorSesion(session));
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/crear")
    public String crearAgente(@ModelAttribute("agente") Agente agente,
                              HttpSession session, Model model) {
        try {
            agente.setId_empresa(obtenerIdEmpresaSesion(session));
            agenteService.crearAgente(agente);
        } catch (IllegalArgumentException ex) {
            model.addAttribute("agente", agente);
            model.addAttribute("mostrarTabla", false);
            model.addAttribute("error", ex.getMessage());
            return "usuarios";
        }
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("agenteCreado", agente);
        return "usuarios";
    }

    // ─── Edición inline: carga el agente en agenteEditar y devuelve usuarios.jsp ──
    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_agente,
                                          HttpSession session, Model model) {
        Agente agente = agenteService.obtenerAgentePorId(id_agente);
        if (agente == null || !puedeGestionarAgente(session, agente)) {
            return "redirect:/agente/list";
        }
        model.addAttribute("agenteEditar", agente);           // activa el bloque de edición
        model.addAttribute("agente", new Agente());           // necesario para el form:form
        model.addAttribute("agentes", filtrarAgentesPorSesion(session));
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/actualizar")
    public String actualizarAgente(@ModelAttribute("agente") Agente agente,
                                   HttpSession session, Model model) {
        Agente agenteActual = agenteService.obtenerAgentePorId(agente.getId_agente());
        if (agenteActual == null || !puedeGestionarAgente(session, agenteActual)) {
            return "redirect:/agente/list";
        }
        try {
            agenteService.actualizarAgente(agente);
        } catch (IllegalArgumentException ex) {
            model.addAttribute("agenteEditar", agente);
            model.addAttribute("agente", new Agente());
            model.addAttribute("agentes", filtrarAgentesPorSesion(session));
            model.addAttribute("mostrarTabla", true);
            model.addAttribute("error", ex.getMessage());
            return "usuarios";
        }
        return "redirect:/agente/list";
    }

    @GetMapping("/eliminar")
    public String eliminarAgente(@RequestParam("id") int id_agente, HttpSession session) {
        Agente agente = agenteService.obtenerAgentePorId(id_agente);
        if (agente != null && puedeGestionarAgente(session, agente)) {
            agenteService.eliminarAgente(id_agente);
        }
        return "redirect:/agente/list";
    }

    // ─── Helpers ───────────────────────────────────────────────────────────────

    private List<Agente> filtrarAgentesPorSesion(HttpSession session) {
        if ("superadmin".equals(session.getAttribute("rol"))) {
            return agenteService.listarAgentes();
        }
        int idEmpresa = obtenerIdEmpresaSesion(session);
        return agenteService.listarAgentes().stream()
                .filter(a -> a.getId_empresa() == idEmpresa)
                .collect(Collectors.toList());
    }

    private boolean puedeGestionarAgente(HttpSession session, Agente agente) {
        return "superadmin".equals(session.getAttribute("rol"))
                || agente.getId_empresa() == obtenerIdEmpresaSesion(session);
    }

    private int obtenerIdEmpresaSesion(HttpSession session) {
        Object id = session.getAttribute("id_empresa");
        return id instanceof Integer ? (Integer) id : 1;
    }
}

