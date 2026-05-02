package com.example.CallCenter.Empresa;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/adicional2")
public class EmpresaController {

    private final EmpresaService empresaService;

    public EmpresaController(EmpresaService empresaService) {
        this.empresaService = empresaService;
    }

    // Muestra el formulario de registro
    @GetMapping
    public String mostrarFormulario(Model model) {
        model.addAttribute("empresa", new Empresa());
        return "adicional2";
    }


    @PostMapping("/registrar")
    public String registrarEmpresa(@ModelAttribute("empresa") Empresa empresa, Model model) {
        empresaService.registrarEmpresa(empresa);
        System.out.println("Empresa registrada: " + empresa.getNombre());
        model.addAttribute("empresa", new Empresa());
        model.addAttribute("registrado", true);
        return "adicional2";
    }

}