package com.example.CallCenter.tipificacion.adapter;

import com.example.CallCenter.tipificacion.entity.TipificacionEntity;
import com.example.CallCenter.tipificacion.model.Tipificacion;
import org.springframework.stereotype.Component;

@Component
public class TipificacionAdapter {

    public Tipificacion toModel(TipificacionEntity entity) {
        if (entity == null) return null;
        return new Tipificacion(
                entity.getId_tipo(),
                entity.getMotivo_tipo(),
                entity.getEstado_tipo()
        );
    }

    public TipificacionEntity toEntity(Tipificacion model) {
        if (model == null) return null;
        TipificacionEntity entity = new TipificacionEntity();
        entity.setId_tipo(model.getId_tipo());
        entity.setMotivo_tipo(model.getMotivo_tipo());
        entity.setEstado_tipo(model.getEstado_tipo());
        return entity;
    }
}