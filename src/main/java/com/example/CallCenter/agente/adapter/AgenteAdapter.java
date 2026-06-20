package com.example.CallCenter.agente.adapter;

import com.example.CallCenter.agente.entity.AgenteEntity;
import com.example.CallCenter.agente.model.Agente;
import org.springframework.stereotype.Component;

@Component
public class AgenteAdapter {

    public Agente toModel(AgenteEntity entity) {
        if (entity == null) return null;
        Agente agente = new Agente();
        agente.setId_agente(entity.getId_agente());
        agente.setNombre_agente(entity.getNombre_agente());
        agente.setTelefono_agente(entity.getTelefono_agente());
        agente.setUsuario_agente(entity.getUsuario_agente());
        agente.setContrasenia_agente(entity.getContrasenia_agente());
        agente.setId_empresa(entity.getId_empresa());
        agente.setEstado_agente(entity.getEstado_agente());
        agente.setCodigo_agente(entity.getCodigo_agente());
        return agente;
    }

    public AgenteEntity toEntity(Agente model) {
        if (model == null) return null;
        AgenteEntity entity = new AgenteEntity();
        entity.setId_agente(model.getId_agente());
        entity.setNombre_agente(model.getNombre_agente());
        entity.setTelefono_agente(model.getTelefono_agente());
        entity.setUsuario_agente(model.getUsuario_agente());
        entity.setContrasenia_agente(model.getContrasenia_agente());
        entity.setId_empresa(model.getId_empresa());
        entity.setEstado_agente(model.getEstado_agente());
        entity.setCodigo_agente(model.getCodigo_agente());
        return entity;
    }
}