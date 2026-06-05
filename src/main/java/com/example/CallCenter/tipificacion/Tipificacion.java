package com.example.CallCenter.tipificacion;

import jakarta.persistence.*;

@Entity
@Table(name = "tipificacion")
public class Tipificacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_tipo;

    private String motivo_tipo;
    private String estado_tipo;

    public Tipificacion() {}

    public Tipificacion(int id_tipo, String motivo_tipo, String estado_tipo) {
        this.id_tipo = id_tipo;
        this.motivo_tipo = motivo_tipo;
        this.estado_tipo = estado_tipo;
    }

    public int getId_tipo() { return id_tipo; }
    public void setId_tipo(int id_tipo) { this.id_tipo = id_tipo; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }

    public String getEstado_tipo() { return estado_tipo; }
    public void setEstado_tipo(String estado_tipo) { this.estado_tipo = estado_tipo; }
}
