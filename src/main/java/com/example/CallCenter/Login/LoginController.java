package com.example.CallCenter.Login;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/login")
public class LoginController {

    @GetMapping
    public String mostrarLogin() {
        return "login"; // Vista: WEB-INF/views/login.jsp
    }

    @PostMapping("/ingresar")
    public String ingresar(
            @RequestParam("usuario") String usuario,
            @RequestParam("contrasena") String contrasena,
            Model model) {

        if ("Emp01".equals(usuario) && "Emp01".equals(contrasena)) {
            return "redirect:/dashboard";
        }
        model.addAttribute("error", true);
        return "login";
    }

}
