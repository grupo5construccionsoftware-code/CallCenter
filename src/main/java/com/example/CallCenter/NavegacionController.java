package com.example.CallCenter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.stream.Collectors;
import com.example.CallCenter.llamada.Llamada;
import com.example.CallCenter.llamada.LlamadaService;
import com.example.CallCenter.tipificacion.TipificacionService;
import com.example.CallCenter.Empresa.EmpresaService;
import com.example.CallCenter.agente.Agente;
import com.example.CallCenter.agente.AgenteService;

@Controller
public class NavegacionController {

    private final LlamadaService llamadaService;
    private final TipificacionService tipificacionService;
    private final EmpresaService empresaService;
    private final AgenteService agenteService;

    public NavegacionController(LlamadaService llamadaService,
                                TipificacionService tipificacionService,
                                EmpresaService empresaService,
                                AgenteService agenteService) {
        this.llamadaService = llamadaService;
        this.tipificacionService = tipificacionService;
        this.empresaService = empresaService;
        this.agenteService = agenteService;
    }

    // ─── Páginas públicas ──────────────────────────────────────────────────────

    @GetMapping("/")
    public String home() { return "main"; }

    @GetMapping("/main")
    public String paginamain() { return "main"; }

    @GetMapping("/publicidad")
    public String publicidad() { return "publicidad"; }

    @GetMapping("/contacto")
    public String contacto() { return "contacto"; }

    // ─── Dashboard por rol ─────────────────────────────────────────────────────

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        String rol = (String) session.getAttribute("rol");
        if ("superadmin".equals(rol)) return "redirect:/dashboard/superadmin";
        if ("agente".equals(rol))     return "redirect:/dashboard/agente";
        if ("empresa".equals(rol))    return "redirect:/dashboard/empresa";
        return "redirect:/login";
    }

    @GetMapping("/dashboard/superadmin")
    public String dashboardSuperadmin(HttpSession session) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        return "dashboard_superadmin";
    }

    @GetMapping("/dashboard/empresa")
    public String dashboardEmpresa(HttpSession session) {
        if (!"empresa".equals(session.getAttribute("rol"))) return "redirect:/login";
        return "dashboard_empresa";
    }

    @GetMapping("/dashboard/agente")
    public String dashboardAgente(HttpSession session) {
        if (!"agente".equals(session.getAttribute("rol"))) return "redirect:/login";
        return "dashboard_agente";
    }

    // ─── Páginas privadas comunes ──────────────────────────────────────────────

    @GetMapping("/gestion")
    public String gestion(HttpSession session) {
        if (session.getAttribute("rol") == null) return "redirect:/login";
        return "gestion";
    }

    @GetMapping("/metricas")
    public String metricas(HttpSession session) {
        if (session.getAttribute("rol") == null) return "redirect:/login";
        return "metricas";
    }

    // ─── SuperAdmin exclusivo ──────────────────────────────────────────────────

    @GetMapping("/empresas")
    public String empresas(
            HttpSession session,
            @RequestParam(value = "mostrar", defaultValue = "false") boolean mostrar,
            Model model) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        model.addAttribute("mostrarEmpresas", mostrar);
        if (mostrar) {
            model.addAttribute("empresas", empresaService.listarEmpresas());
        }
        return "empresas";
    }

    @GetMapping("/metricas/superadmin")
    public String metricasSuperadmin(
            HttpSession session,
            @RequestParam(value = "id_empresa", required = false) Long idEmpresa,
            Model model) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        model.addAttribute("empresas", empresaService.listarEmpresas());
        model.addAttribute("empresaSeleccionada", idEmpresa);
        model.addAttribute("totalEmpresas", empresaService.listarEmpresas().size());
        model.addAttribute("totalLlamadas", llamadaService.listarLlamadas().size());
        model.addAttribute("totalAgentes", agenteService.listarAgentes().size());
        model.addAttribute("clientesSatisfechos", 114);
        model.addAttribute("tipificacionComun", "Consulta");
        return "metricas_superadmin";
    }

    // ─── Empresa y Agente ──────────────────────────────────────────────────────

    @GetMapping("/llamadas")
    public String llamadas(HttpSession session, Model model) {
        String rol = (String) session.getAttribute("rol");
        if (!"agente".equals(rol) && !"empresa".equals(rol) && !"superadmin".equals(rol))
            return "redirect:/login";
        model.addAttribute("llamada", new Llamada());
        model.addAttribute("mostrarTabla", false);
        model.addAttribute("tiposLlamada", tipificacionService.listarTipificaciones());
        return "llamadas";
    }

    @GetMapping("/tipificaciones")
    public String tipificaciones(HttpSession session, Model model) {
        String rol = (String) session.getAttribute("rol");
        if (!"empresa".equals(rol) && !"superadmin".equals(rol)) return "redirect:/login";
        model.addAttribute("tipificacion", new com.example.CallCenter.tipificacion.Tipificacion());
        model.addAttribute("tiposLlamada", tipificacionService.listarTiposLlamada());
        model.addAttribute("mostrarTabla", false);
        return "tipificaciones";
    }

    @GetMapping("/usuarios")
    public String usuarios(HttpSession session, Model model) {
        String rol = (String) session.getAttribute("rol");
        if (!"empresa".equals(rol) && !"superadmin".equals(rol)) return "redirect:/login";
        model.addAttribute("agente", new Agente());
        model.addAttribute("mostrarTabla", false);
        return "usuarios";
    }

    @GetMapping("/adicional1")
    public String adicional1(HttpSession session, Model model) {
        if (session.getAttribute("rol") == null) return "redirect:/login";

        String rol = (String) session.getAttribute("rol");
        int idEmpresa = obtenerIdEmpresaSesion(session);

        List<Agente> agentesVisibles = obtenerAgentesVisibles(rol, idEmpresa);
        List<Integer> idsAgentesVisibles = agentesVisibles.stream()
                .map(Agente::getId_agente)
                .collect(Collectors.toList());

        List<Llamada> historial = "agente".equals(rol)
                ? llamadaService.listarLlamadasPorAgente(obtenerIdAgenteSesion(session))
                : llamadaService.listarLlamadasPorAgentes(idsAgentesVisibles);

        Map<Integer, Agente> agentesPorId = agentesVisibles.stream()
                .collect(Collectors.toMap(Agente::getId_agente, a -> a, (a, b) -> a));

        List<String> motivosBase = Arrays.asList("Consulta", "Reclamo", "Venta", "Soporte", "Otros");
        List<String> motivosDisponibles = new ArrayList<>(motivosBase);
        tipificacionService.listarTiposLlamada().stream()
                .filter(m -> m != null && !m.trim().isEmpty())
                .map(String::trim)
                .filter(m -> motivosBase.stream().noneMatch(b -> b.equalsIgnoreCase(m)))
                .forEach(motivosDisponibles::add);

        model.addAttribute("historialLlamadas", historial);
        model.addAttribute("motivosDisponibles", motivosDisponibles);
        model.addAttribute("agentesPorId", agentesPorId);
        model.addAttribute("modoHistorialEmpresa", "empresa".equals(rol));
        return "adicional1";
    }

    @GetMapping("/adicional3")
    public String adicional3() { return "adicional3"; }

    @GetMapping("/adicional4")
    public String adicional4() { return "adicional4"; }

    @GetMapping("/adicional5")
    public String adicional5() { return "adicional5"; }

    // ─── Helpers de sesión ─────────────────────────────────────────────────────

    private List<Agente> obtenerAgentesVisibles(String rol, int idEmpresa) {
        if ("superadmin".equals(rol)) return agenteService.listarAgentes();
        return agenteService.listarAgentes().stream()
                .filter(a -> a.getId_empresa() == idEmpresa)
                .collect(Collectors.toList());
    }

    private int obtenerIdEmpresaSesion(HttpSession session) {
        Object id = session.getAttribute("id_empresa");
        return id instanceof Integer ? (Integer) id : 1;
    }

    private int obtenerIdAgenteSesion(HttpSession session) {
        Object id = session.getAttribute("id_agente");
        return id instanceof Integer ? (Integer) id : 1;
    }
}
