package com.example.CallCenter.Login;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

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
            return "redirect:/dashboard/empresa";
        }
        if ("Age01".equals(usuario) && "Age01".equals(contrasena)) {
            session.setAttribute("rol", "agente");
            session.setAttribute("usuario", usuario);
            return "redirect:/dashboard/agente";
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