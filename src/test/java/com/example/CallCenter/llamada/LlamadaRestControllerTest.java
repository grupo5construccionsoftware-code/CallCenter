package com.example.CallCenter.llamada;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.DisplayName;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.boot.test.context.SpringBootTest;

import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;

import org.springframework.http.MediaType;

import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
class LlamadaRestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("Crear llamada con nombre válido")
    void deberiaCrearLlamadaConNombreValido() throws Exception {

        String llamadaJson = """
            {
                "nombre_cliente": "Maria Lopez",
                "telefono_cliente": "987654321"
            }
            """;

        mockMvc.perform(
                        post("/api/llamada/crear")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(llamadaJson)
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.nombre_cliente").value("Maria Lopez"))
                .andExpect(jsonPath("$.telefono_cliente").value("987654321"));
    }

    @Test
    @DisplayName("Actualizar datos del cliente")
    void deberiaActualizarDatosDelCliente() throws Exception {

        String llamadaJson = """
            {
                "id_llamada": 1,
                "nombre_cliente": "Maria Hernandez",
                "telefono_cliente": "999888777"
            }
            """;

        mockMvc.perform(
                        put("/api/llamada/actualizar")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(llamadaJson)
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.nombre_cliente").value("Maria Hernandez"))
                .andExpect(jsonPath("$.telefono_cliente").value("999888777"));
    }



    @Test
    @DisplayName("Listar llamadas")
    void deberiaListarLlamadas() throws Exception {
        mockMvc.perform(get("/api/llamada/listar"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].nombre_cliente").value("Maria Lopez"));
    }

    @Test
    @DisplayName("Borrar llamada por ID")
    void deberiaBorrarLlamada() throws Exception {
        mockMvc.perform(delete("/api/llamada/borrar/1"))
               .andExpect(status().isOk());
    }
}
