package com.example.CallCenter.llamada.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "llamada_tipo")
public class LlamadaTipoEntity {

    @Id
    private int id_llamada;

    private int id_empresa_tipo;

    public LlamadaTipoEntity() {}

    public LlamadaTipoEntity(int id_llamada, int id_empresa_tipo) {
        this.id_llamada = id_llamada;
        this.id_empresa_tipo = id_empresa_tipo;
    }

    public int getId_llamada() { return id_llamada; }
    public void setId_llamada(int id_llamada) { this.id_llamada = id_llamada; }

    public int getId_empresa_tipo() { return id_empresa_tipo; }
    public void setId_empresa_tipo(int id_empresa_tipo) { this.id_empresa_tipo = id_empresa_tipo; }
}