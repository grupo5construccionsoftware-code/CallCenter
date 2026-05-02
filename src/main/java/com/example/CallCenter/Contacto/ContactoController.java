package com.example.CallCenter.Contacto;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contacto")
public class ContactoController {

    private final ContactoService contactoService;

    public ContactoController(ContactoService contactoService) {
        this.contactoService = contactoService;
    }

    // Muestra el formulario de contacto
    @GetMapping
    public String mostrarFormulario(Model model) {
        model.addAttribute("contacto", new Contacto());
        return "contacto"; // Vista: WEB-INF/views/contacto.jsp
    }

    // Procesa el formulario y muestra mensaje de confirmación
    @PostMapping("/enviar")
    public String enviarContacto(@ModelAttribute("contacto") Contacto contacto, Model model) {
        contactoService.enviarContacto(contacto);
        System.out.println("Contacto recibido: " + contacto.getNombre() + " " + contacto.getApellido());
        model.addAttribute("enviado", true);
        model.addAttribute("contacto", new Contacto());
        return "contacto"; // Retorna la vista con el mensaje de éxito
    }

}
