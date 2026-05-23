package com.example.CallCenter.tipificacion;

public class Tipificacion {

    private int id_tipo;
    private String motivo_tipo;
    private String descripcion_tipo;
    private int id_empresa;

    public Tipificacion() {}

    public Tipificacion(int id_tipo, String motivo_tipo, String descripcion_tipo, int id_empresa) {
        this.id_tipo = id_tipo;
        this.motivo_tipo = motivo_tipo;
        this.descripcion_tipo = descripcion_tipo;
        this.id_empresa = id_empresa;
    }

    public int getId_tipo() { return id_tipo; }
    public void setId_tipo(int id_tipo) { this.id_tipo = id_tipo; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }

    public String getDescripcion_tipo() { return descripcion_tipo; }
    public void setDescripcion_tipo(String descripcion_tipo) { this.descripcion_tipo = descripcion_tipo; }

    public int getId_empresa() { return id_empresa; }
    public void setId_empresa(int id_empresa) { this.id_empresa = id_empresa; }
}