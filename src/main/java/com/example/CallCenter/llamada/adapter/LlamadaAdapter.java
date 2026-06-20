package com.example.CallCenter.llamada.adapter;

import com.example.CallCenter.llamada.entity.LlamadaEntity;
import com.example.CallCenter.llamada.model.Llamada;
import org.springframework.stereotype.Component;

@Component
public class LlamadaAdapter {

    public Llamada toModel(LlamadaEntity entity) {
        if (entity == null) return null;
        Llamada llamada = new Llamada();
        llamada.setId_llamada(entity.getId_llamada());
        llamada.setNombre_cliente(entity.getNombre_cliente());
        llamada.setTelefono_cliente(entity.getTelefono_cliente());
        llamada.setFecha_llamada(entity.getFecha_llamada());
        llamada.setHora_inicio(entity.getHora_inicio());
        llamada.setHora_fin(entity.getHora_fin());
        llamada.setDuracion(entity.getDuracion());
        llamada.setDescripcion_tipo(entity.getDescripcion_tipo());
        llamada.setId_agente(entity.getId_agente());
        llamada.setId_tipo(entity.getId_tipo());
        llamada.setEstado_llamada(entity.getEstado_llamada());
        llamada.setMotivo_tipo(entity.getMotivo_tipo());
        llamada.setCodigo_llamada(entity.getCodigo_llamada());
        return llamada;
    }

    public LlamadaEntity toEntity(Llamada model) {
        if (model == null) return null;
        LlamadaEntity entity = new LlamadaEntity();
        entity.setId_llamada(model.getId_llamada());
        entity.setNombre_cliente(model.getNombre_cliente());
        entity.setTelefono_cliente(model.getTelefono_cliente());
        entity.setFecha_llamada(model.getFecha_llamada());
        entity.setHora_inicio(model.getHora_inicio());
        entity.setHora_fin(model.getHora_fin());
        entity.setDuracion(model.getDuracion());
        entity.setDescripcion_tipo(model.getDescripcion_tipo());
        entity.setId_agente(model.getId_agente());
        entity.setId_tipo(model.getId_tipo() == null ? 0 : model.getId_tipo());
        entity.setEstado_llamada(model.getEstado_llamada());
        entity.setMotivo_tipo(model.getMotivo_tipo());
        entity.setCodigo_llamada(model.getCodigo_llamada());
        return entity;
    }
}