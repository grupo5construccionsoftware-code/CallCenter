package com.example.CallCenter.tipificacion.adapter;

import com.example.CallCenter.tipificacion.entity.EmpresaTipoEntity;
import com.example.CallCenter.tipificacion.model.EmpresaTipo;
import org.springframework.stereotype.Component;

@Component
public class EmpresaTipoAdapter {

    public EmpresaTipo toModel(EmpresaTipoEntity entity) {
        if (entity == null) return null;
        EmpresaTipo model = new EmpresaTipo(entity.getId_empresa(), entity.getId_tipo());
        model.setId(entity.getId());
        model.setEstado_asignacion(entity.getEstado_asignacion());
        return model;
    }

    public EmpresaTipoEntity toEntity(EmpresaTipo model) {
        if (model == null) return null;
        EmpresaTipoEntity entity = new EmpresaTipoEntity();
        entity.setId(model.getId());
        entity.setId_empresa(model.getId_empresa());
        entity.setId_tipo(model.getId_tipo());
        entity.setEstado_asignacion(model.getEstado_asignacion());
        return entity;
    }
}