package com.example.CallCenter.tipificacion;

public class Tipificacion {

    private Integer id_llamada;
    private Integer id_tipo;
    private String descripcion_tipo;
    private String nombre_cliente;
    private String motivo_tipo;

    public Tipificacion() {}

    public Integer getId_llamada() { return id_llamada; }
    public void setId_llamada(Integer id_llamada) { this.id_llamada = id_llamada; }

    public Integer getId_tipo() { return id_tipo; }
    public void setId_tipo(Integer id_tipo) { this.id_tipo = id_tipo; }

    public String getDescripcion_tipo() { return descripcion_tipo; }
    public void setDescripcion_tipo(String descripcion_tipo) { this.descripcion_tipo = descripcion_tipo; }

    public String getNombre_cliente() { return nombre_cliente; }
    public void setNombre_cliente(String nombre_cliente) { this.nombre_cliente = nombre_cliente; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }
}