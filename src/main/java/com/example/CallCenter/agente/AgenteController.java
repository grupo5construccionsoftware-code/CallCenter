package com.example.CallCenter.agente;

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
        List<Agente> agentes = agenteService.listarAgentes();
        model.addAttribute("agentes", agentes);
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", true);
        return "usuarios";
    }

    @PostMapping("/crear")
    public String crearAgente(@ModelAttribute("agente") Agente agente, Model model) {
        try {
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
    public String mostrarFormularioEditar(@RequestParam("id") int id_agente, Model model) {
        Agente agente = agenteService.obtenerAgentePorId(id_agente);
        model.addAttribute("agente", agente);
        return "adicional5";
    }

    @PostMapping("/actualizar")
    public String actualizarAgente(@ModelAttribute("agente") Agente agente, Model model) {
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
    public String eliminarAgente(@RequestParam("id") int id_agente) {
        agenteService.eliminarAgente(id_agente);
        return "redirect:/agente/list";
    }
}
