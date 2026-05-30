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
        List<Agente> agentes = filtrarAgentesPorSesion(session);
        model.addAttribute("agentes", agentes);
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/crear")
    public String crearAgente(@ModelAttribute("agente") Agente agente, HttpSession session, Model model) {
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

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_agente, HttpSession session, Model model) {
        Agente agente = agenteService.obtenerAgentePorId(id_agente);
        if (agente == null || !puedeGestionarAgente(session, agente)) {
            return "redirect:/agente/list";
        }
        model.addAttribute("agente", agente);
        return "adicional5";
    }

    @PostMapping("/actualizar")
    public String actualizarAgente(@ModelAttribute("agente") Agente agente, HttpSession session, Model model) {
        Agente agenteActual = agenteService.obtenerAgentePorId(agente.getId_agente());
        if (agenteActual == null || !puedeGestionarAgente(session, agenteActual)) {
            return "redirect:/agente/list";
        }
        try {
            agenteService.actualizarAgente(agente);
        } catch (IllegalArgumentException ex) {
            model.addAttribute("agente", agente);
            model.addAttribute("error", ex.getMessage());
            return "adicional5";
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
        Object idEmpresa = session.getAttribute("id_empresa");
        return idEmpresa instanceof Integer ? (Integer) idEmpresa : 1;
    }
}
