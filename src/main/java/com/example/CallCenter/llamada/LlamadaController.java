package com.example.CallCenter.llamada;

import com.example.CallCenter.agente.AgenteService;
import com.example.CallCenter.tipificacion.TipificacionService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/llamada")
public class LlamadaController {

    private final LlamadaService llamadaService;
    private final TipificacionService tipificacionService;
    private final AgenteService agenteService;

    public LlamadaController(LlamadaService llamadaService,
                             TipificacionService tipificacionService,
                             AgenteService agenteService) {
        this.llamadaService = llamadaService;
        this.tipificacionService = tipificacionService;
        this.agenteService = agenteService;
    }

    @GetMapping("/list")
    public String listarLlamadas(HttpSession session, Model model) {
        List<Llamada> llamadas = "agente".equals(session.getAttribute("rol"))
                ? llamadaService.listarLlamadasPorAgente(obtenerIdAgenteSesion(session))
                : llamadaService.listarLlamadas();
        model.addAttribute("llamadas", llamadas);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarActivasPorEmpresa(obtenerIdAgenteSesion(session)));
        model.addAttribute("agenteMap", construirAgenteMap());
        model.addAttribute("mostrarTabla", true);
        return "llamadas";
    }

    @PostMapping("/crear")
    public String crearLlamada(@ModelAttribute("llamada") Llamada llamada,
                               HttpSession session, Model model) {
        llamada.setId_agente(obtenerIdAgenteSesion(session));
        llamadaService.crearLlamada(llamada);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tiposLlamada", tipificacionService.listarActivasPorEmpresa(obtenerIdAgenteSesion(session)));
        model.addAttribute("agenteMap", construirAgenteMap());
        model.addAttribute("llamadaCreada", llamada);
        return "llamadas";
    }

    @GetMapping("/editar")
    public String mostrarFormularioEditar(@RequestParam("id") int id_llamada,
                                          HttpSession session, Model model) {
        Llamada llamada = llamadaService.obtenerLlamadaPorId(id_llamada);
        if (llamada == null) return "redirect:/llamada/list";

        List<Llamada> llamadas = "agente".equals(session.getAttribute("rol"))
                ? llamadaService.listarLlamadasPorAgente(obtenerIdAgenteSesion(session))
                : llamadaService.listarLlamadas();

        model.addAttribute("llamadaEditar", llamada);
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("tiposLlamada", tipificacionService.listarActivasPorEmpresa(obtenerIdAgenteSesion(session)));
        model.addAttribute("llamadas", llamadas);
        model.addAttribute("agenteMap", construirAgenteMap());
        model.addAttribute("mostrarTabla", true);
        return "llamadas";
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


    private int obtenerIdAgenteSesion(HttpSession session) {
        Object id = session.getAttribute("id_agente");
        return id instanceof Integer ? (Integer) id : 1;
    }

    private Map<Integer, String> construirAgenteMap() {
        Map<Integer, String> map = new HashMap<>();
        agenteService.listarAgentes().forEach(a ->
                map.put(a.getId_agente(), a.getNombre_agente()));
        return map;
    }
}
