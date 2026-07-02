package com.example.CallCenter.Login;

import com.example.CallCenter.Empresa.model.Empresa;
import com.example.CallCenter.Empresa.EmpresaService;
import com.example.CallCenter.agente.model.Agente;
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


        if ("Sa01".equals(usuario) && "Sa01".equals(contrasena)) {
            session.setAttribute("rol", "superadmin");
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombreSesion", "Superadmin");
            return "redirect:/dashboard/superadmin";
        }


        Empresa empresa = empresaService.obtenerPorCredenciales(usuario, contrasena);
        if (empresa != null) {
            if (empresaPuedeAcceder(empresa, model)) {
                session.setAttribute("rol", "empresa");
                session.setAttribute("usuario", empresa.getUsuario_empresa());
                session.setAttribute("id_empresa", empresa.getId_empresa());
                session.setAttribute("nombreSesion", empresa.getNombre_empresa());
                return "redirect:/dashboard/empresa";
            }
            return "login";
        }


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
                session.setAttribute("nombreSesion", agente.getNombre_agente());
                return "redirect:/dashboard/agente";
            }
            return "login";
        }


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