package com.example.CallCenter.tipificacion.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "empresa_tipo")
public class EmpresaTipoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int id_empresa;
    private int id_tipo;
    private String estado_asignacion;

    public EmpresaTipoEntity() {}

    public EmpresaTipoEntity(int id_empresa, int id_tipo) {
        this.id_empresa = id_empresa;
        this.id_tipo = id_tipo;
        this.estado_asignacion = "ACTIVO";
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getId_empresa() { return id_empresa; }
    public void setId_empresa(int id_empresa) { this.id_empresa = id_empresa; }

    public int getId_tipo() { return id_tipo; }
    public void setId_tipo(int id_tipo) { this.id_tipo = id_tipo; }

    public String getEstado_asignacion() { return estado_asignacion; }
    public void setEstado_asignacion(String estado_asignacion) { this.estado_asignacion = estado_asignacion; }
}