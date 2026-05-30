package com.example.CallCenter.agente;

import jakarta.servlet.http.HttpSession;
import java.util.List;
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
    public String listarAgentes(Model model) {
        model.addAttribute("agentes", agenteService.listarAgentes());
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/crear")
    public String crearAgente(@ModelAttribute("agente") Agente agente, Model model) {
        agenteService.crearAgente(agente);
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("agenteCreado", agente);
        return "usuarios";
    }

    // Editar inline: recarga usuarios.jsp con datos del agente
    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_agente, Model model) {
        model.addAttribute("agenteEditar", agenteService.obtenerAgentePorId(id_agente));
        model.addAttribute("agente", new Agente());
        model.addAttribute("agentes", agenteService.listarAgentes());
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/actualizar")
    public String actualizarAgente(@ModelAttribute("agente") Agente agente) {
        agenteService.actualizarAgente(agente);
        return "redirect:/agente/list";
    }

    @GetMapping("/eliminar")
    public String eliminarAgente(@RequestParam("id") int id_agente) {
        agenteService.eliminarAgente(id_agente);
        return "redirect:/agente/list";
    }
}