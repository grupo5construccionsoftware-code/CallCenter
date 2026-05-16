package com.example.CallCenter.ControllerTest;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
class AgenteRestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("🔴 Debería crear un agente con nombre válido")
    void deberiaCrearAgente() throws Exception {

        String agenteJson = """
            {
                "nombre_agente": "Juan Pérez",
                "telefono_agente": "999888777"
            }
            """;

        mockMvc.perform(post("/api/agente/crear")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(agenteJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.nombre_agente").value("Juan Pérez"));
    }

    @Test
    @DisplayName("🔴 Debería actualizar un agente")
    void deberiaActualizarAgente() throws Exception {

        String agenteJson = """
        {
            "id_agente": 1,
            "nombre_agente": "Juan Editado",
            "telefono_agente": "999000111"
        }
        """;

        mockMvc.perform(put("/api/agente/actualizar")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(agenteJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.nombre_agente").value("Juan Editado"));
    }
}