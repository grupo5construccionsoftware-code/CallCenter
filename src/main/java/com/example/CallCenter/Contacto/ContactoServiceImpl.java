package com.example.CallCenter.Contacto;


import org.springframework.stereotype.Service;

@Service
public class ContactoServiceImpl implements ContactoService {

    private final ContactoDAO contactoDAO;

    public ContactoServiceImpl(ContactoDAO contactoDAO) {
        this.contactoDAO = contactoDAO;
    }

    @Override
    public void enviarContacto(Contacto contacto) {
        contactoDAO.enviarContacto(contacto);
    }

}