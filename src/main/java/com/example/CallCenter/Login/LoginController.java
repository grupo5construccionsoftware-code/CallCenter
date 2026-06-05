package com.example.CallCenter.Login;

import com.example.CallCenter.Empresa.Empresa;
import com.example.CallCenter.Empresa.EmpresaService;
import com.example.CallCenter.agente.Agente;
import com.example.CallCenter.agente.AgenteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    private final EmpresaService empresaService;
    private final AgenteService agenteService;

    public LoginController(EmpresaService empresaService, AgenteService agenteService) {
        this.empresaService = empresaService;
        this.agenteService = agenteService;
    }

    @GetMapping
    public String mostrarLogin() {
        return "login";
    }

    @PostMapping("/ingresar")
    public String ingresar(
            @RequestParam("usuario") String usuario,
            @RequestParam("contrasena") String contrasena,
            HttpSession session,
            Model model) {

        // 1° DUEÑO - Superadmin siempre primero
        if ("Sa01".equals(usuario) && "Sa01".equals(contrasena)) {
            session.setAttribute("rol", "superadmin");
            session.setAttribute("usuario", usuario);
            return "redirect:/dashboard/superadmin";
        }

        // 2° EMPRESA - Busca en BD segundo
        Empresa empresa = empresaService.obtenerPorCredenciales(usuario, contrasena);
        if (empresa != null) {
            if (empresaPuedeAcceder(empresa, model)) {
                session.setAttribute("rol", "empresa");
                session.setAttribute("usuario", empresa.getUsuario_empresa());
                session.setAttribute("id_empresa", empresa.getId_empresa());
                return "redirect:/dashboard/empresa";
            }
            return "login";
        }

        // 3° AGENTE - Busca en BD tercero
        Agente agente = agenteService.obtenerPorCredenciales(usuario, contrasena);
        if (agente != null) {
            if (!"ACTIVO".equals(agente.getEstado_agente())) {
                model.addAttribute("estadoBloqueado", "Tu cuenta de agente está inactiva.");
                return "login";
            }
            Empresa empresaDelAgente = empresaService.obtenerEmpresaPorId(agente.getId_empresa());
            if (empresaPuedeAcceder(empresaDelAgente, model)) {
                session.setAttribute("rol", "agente");
                session.setAttribute("usuario", agente.getUsuario_agente());
                session.setAttribute("id_agente", agente.getId_agente());
                session.setAttribute("id_empresa", agente.getId_empresa());
                return "redirect:/dashboard/agente";
            }
            return "login";
        }

        // 4° NADIE - Error
        model.addAttribute("error", true);
        return "login";
    }

    private boolean empresaPuedeAcceder(Empresa empresa, Model model) {
        if (empresa == null) {
            model.addAttribute("estadoBloqueado", "La empresa asociada no existe o fue dada de baja.");
            return false;
        }
        String estado = empresa.getEstado_empresa() == null ? "ACTIVO" : empresa.getEstado_empresa().trim();
        if ("ACTIVO".equals(estado)) {
            return true;
        }
        if ("INACTIVO".equals(estado)) {
            model.addAttribute("estadoBloqueado", "Tu empresa está suspendida. Contacta al superadmin.");
            return false;
        }
        if ("ELIMINADO".equals(estado)) {
            model.addAttribute("estadoBloqueado", "Tu empresa fue dada de baja y no tiene acceso.");
            return false;
        }
        model.addAttribute("estadoBloqueado", "Tu empresa no está activa y no puede acceder.");
        return false;
    }

    @GetMapping("/salir")
    public String salir(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }
}
