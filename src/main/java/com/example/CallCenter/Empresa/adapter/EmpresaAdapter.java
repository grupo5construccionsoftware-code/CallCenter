package com.example.CallCenter.Empresa.adapter;

import com.example.CallCenter.Empresa.entity.EmpresaEntity;
import com.example.CallCenter.Empresa.model.Empresa;
import org.springframework.stereotype.Component;

@Component
public class EmpresaAdapter {

    public Empresa toModel(EmpresaEntity entity) {
        if (entity == null) {
            return null;
        }
        Empresa empresa = new Empresa();
        empresa.setId_empresa(entity.getId_empresa());
        empresa.setNombre_empresa(entity.getNombre_empresa());
        empresa.setTelefono_empresa(entity.getTelefono_empresa());
        empresa.setCorreo_empresa(entity.getCorreo_empresa());
        empresa.setUsuario_empresa(entity.getUsuario_empresa());
        empresa.setContrasenia_empresa(entity.getContrasenia_empresa());
        empresa.setEstado_empresa(entity.getEstado_empresa());
        return empresa;
    }

    public EmpresaEntity toEntity(Empresa model) {
        if (model == null) {
            return null;
        }
        EmpresaEntity entity = new EmpresaEntity();
        entity.setId_empresa(model.getId_empresa());
        entity.setNombre_empresa(model.getNombre_empresa());
        entity.setTelefono_empresa(model.getTelefono_empresa());
        entity.setCorreo_empresa(model.getCorreo_empresa());
        entity.setUsuario_empresa(model.getUsuario_empresa());
        entity.setContrasenia_empresa(model.getContrasenia_empresa());
        entity.setEstado_empresa(model.getEstado_empresa());
        return entity;
    }
}