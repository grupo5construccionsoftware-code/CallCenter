package com.example.CallCenter.llamada.adapter;

import com.example.CallCenter.llamada.entity.LlamadaTipoEntity;
import com.example.CallCenter.llamada.model.LlamadaTipo;
import org.springframework.stereotype.Component;

@Component
public class LlamadaTipoAdapter {

    public LlamadaTipo toModel(LlamadaTipoEntity entity) {
        if (entity == null) return null;
        return new LlamadaTipo(entity.getId_llamada(), entity.getId_empresa_tipo());
    }

    public LlamadaTipoEntity toEntity(LlamadaTipo model) {
        if (model == null) return null;
        return new LlamadaTipoEntity(model.getId_llamada(), model.getId_empresa_tipo());
    }
}