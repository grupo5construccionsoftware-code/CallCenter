package com.example.CallCenter.llamada.model;

public class LlamadaTipo {

    private int id_llamada;
    private int id_empresa_tipo;

    public LlamadaTipo() {}

    public LlamadaTipo(int id_llamada, int id_empresa_tipo) {
        this.id_llamada = id_llamada;
        this.id_empresa_tipo = id_empresa_tipo;
    }

    public int getId_llamada() { return id_llamada; }
    public void setId_llamada(int id_llamada) { this.id_llamada = id_llamada; }

    public int getId_empresa_tipo() { return id_empresa_tipo; }
    public void setId_empresa_tipo(int id_empresa_tipo) { this.id_empresa_tipo = id_empresa_tipo; }
}