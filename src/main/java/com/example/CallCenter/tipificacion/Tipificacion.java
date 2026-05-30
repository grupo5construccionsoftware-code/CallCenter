package com.example.CallCenter.tipificacion;

public class Tipificacion {

    private int id_tipo;
    private String motivo_tipo;
    private int id_empresa;
    private String estado_tipo;

    public Tipificacion() {}

    public Tipificacion(int id_tipo, String motivo_tipo, int id_empresa, String estado_tipo) {
        this.id_tipo = id_tipo;
        this.motivo_tipo = motivo_tipo;
        this.id_empresa = id_empresa;
        this.estado_tipo = estado_tipo;
    }

    public Tipificacion(int id_tipo, String motivo_tipo, String descripcion_tipo, int id_empresa) {
        this(id_tipo, motivo_tipo, id_empresa, "Activo");
    }

    public int getId_tipo() { return id_tipo; }
    public void setId_tipo(int id_tipo) { this.id_tipo = id_tipo; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }

    public int getId_empresa() { return id_empresa; }
    public void setId_empresa(int id_empresa) { this.id_empresa = id_empresa; }

    public String getEstado_tipo() { return estado_tipo; }
    public void setEstado_tipo(String estado_tipo) { this.estado_tipo = estado_tipo; }
}
