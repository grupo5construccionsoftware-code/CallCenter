package com.example.CallCenter.Contacto;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class ContactoRepository implements ContactoDAO {

    // Lista en memoria que simula la base de datos
    private final List<Contacto> listaSimulada = new ArrayList<>();
    private int contadorId = 1;

    @Override
    public void enviarContacto(Contacto contacto) {
        contacto.setId(contadorId++);
        listaSimulada.add(contacto);
    }

}