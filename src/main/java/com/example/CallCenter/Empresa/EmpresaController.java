package com.example.CallCenter.Empresa;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class EmpresaController {

    private final EmpresaService empresaService;

    public EmpresaController(EmpresaService empresaService) {
        this.empresaService = empresaService;
    }

    @GetMapping("/adicional2")
    public String mostrarFormularioPublico(Model model) {
        model.addAttribute("empresa", new Empresa());
        model.addAttribute("modoAdmin", false);
        return "adicional2";
    }

    @PostMapping("/adicional2/registrar")
    public String registrarEmpresaPublico(@ModelAttribute("empresa") Empresa empresa, Model model) {
        empresaService.registrarEmpresa(empresa);
        model.addAttribute("empresa", new Empresa());
        model.addAttribute("registrado", true);
        model.addAttribute("empresaRegistrada", empresa);
        model.addAttribute("modoAdmin", false);
        return "adicional2";
    }

    @GetMapping("/empresa/nueva")
    public String mostrarFormularioAdmin(HttpSession session, Model model) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        model.addAttribute("empresa", new Empresa());
        model.addAttribute("modoAdmin", true);
        return "adicional2";
    }

    @PostMapping("/empresa/registrar")
    public String registrarEmpresaAdmin(@ModelAttribute("empresa") Empresa empresa, HttpSession session, Model model) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        empresaService.registrarEmpresa(empresa);
        model.addAttribute("empresa", new Empresa());
        model.addAttribute("registrado", true);
        model.addAttribute("empresaRegistrada", empresa);
        model.addAttribute("modoAdmin", true);
        return "adicional2";
    }

    @GetMapping("/empresa/editar")
    public String mostrarEditar(@RequestParam("id") int id, HttpSession session, Model model) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        model.addAttribute("empresa", empresaService.obtenerEmpresaPorId(id));
        return "empresa_editar";
    }

    @PostMapping("/empresa/actualizar")
    public String actualizarEmpresa(@ModelAttribute("empresa") Empresa empresa, HttpSession session) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        empresaService.actualizarEmpresa(empresa);
        return "redirect:/empresas";
    }

    @GetMapping("/empresa/eliminar")
    public String eliminarEmpresa(@RequestParam("id") int id, HttpSession session) {
        if (!"superadmin".equals(session.getAttribute("rol"))) return "redirect:/login";
        empresaService.eliminarEmpresa(id);
        return "redirect:/empresas";
    }
}
