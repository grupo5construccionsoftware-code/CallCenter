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

        if ("Sa01".equals(usuario) && "Sa01".equals(contrasena)) {
            session.setAttribute("rol", "superadmin");
            session.setAttribute("usuario", usuario);
            return "redirect:/dashboard/superadmin";
        }
        if ("Emp01".equals(usuario) && "Emp01".equals(contrasena)) {
            session.setAttribute("rol", "empresa");
            session.setAttribute("usuario", usuario);
            session.setAttribute("id_empresa", 1);
            return "redirect:/dashboard/empresa";
        }
        if ("Age01".equals(usuario) && "Age01".equals(contrasena)) {
            session.setAttribute("rol", "agente");
            session.setAttribute("usuario", usuario);
            session.setAttribute("id_agente", 1);
            session.setAttribute("id_empresa", 1);
            return "redirect:/dashboard/agente";
        }

        Agente agente = agenteService.obtenerPorCredenciales(usuario, contrasena);
        if (agente != null) {
            session.setAttribute("rol", "agente");
            session.setAttribute("usuario", agente.getUsuario_agente());
            session.setAttribute("id_agente", agente.getId_agente());
            session.setAttribute("id_empresa", agente.getId_empresa());
            return "redirect:/dashboard/agente";
        }

        Empresa empresa = empresaService.obtenerPorCredenciales(usuario, contrasena);
        if (empresa != null) {
            String estado = empresa.getEstado() == null ? "activo" : empresa.getEstado().toLowerCase();
            if ("activo".equals(estado)) {
                session.setAttribute("rol", "empresa");
                session.setAttribute("usuario", empresa.getUsuario());
                session.setAttribute("id_empresa", empresa.getId());
                return "redirect:/dashboard/empresa";
            }
            if ("suspendido".equals(estado)) {
                model.addAttribute("estadoBloqueado", "Tu empresa está suspendida. Contacta al superadmin.");
                return "login";
            }
            if ("borrado".equals(estado)) {
                model.addAttribute("estadoBloqueado", "Tu empresa fue dada de baja y no tiene acceso.");
                return "login";
            }
        }

        model.addAttribute("error", true);
        return "login";
    }

    @GetMapping("/salir")
    public String salir(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }
}
