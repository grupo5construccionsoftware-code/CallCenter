package com.example.CallCenter.llamada.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "llamada")
public class LlamadaEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_llamada;

    private String nombre_cliente;
    private String telefono_cliente;
    private String fecha_llamada;
    private String hora_inicio;
    private String hora_fin;
    private String duracion;
    private String descripcion_tipo;
    private int id_agente;
    private int id_tipo;
    private String estado_llamada;
    private String motivo_tipo;
    private String codigo_llamada;

    public LlamadaEntity() {}

    public int getId_llamada() { return id_llamada; }
    public void setId_llamada(int id_llamada) { this.id_llamada = id_llamada; }

    public String getNombre_cliente() { return nombre_cliente; }
    public void setNombre_cliente(String nombre_cliente) { this.nombre_cliente = nombre_cliente; }

    public String getTelefono_cliente() { return telefono_cliente; }
    public void setTelefono_cliente(String telefono_cliente) { this.telefono_cliente = telefono_cliente; }

    public String getFecha_llamada() { return fecha_llamada; }
    public void setFecha_llamada(String fecha_llamada) { this.fecha_llamada = fecha_llamada; }

    public String getHora_inicio() { return hora_inicio; }
    public void setHora_inicio(String hora_inicio) { this.hora_inicio = hora_inicio; }

    public String getHora_fin() { return hora_fin; }
    public void setHora_fin(String hora_fin) { this.hora_fin = hora_fin; }

    public String getDuracion() { return duracion; }
    public void setDuracion(String duracion) { this.duracion = duracion; }

    public String getDescripcion_tipo() { return descripcion_tipo; }
    public void setDescripcion_tipo(String descripcion_tipo) { this.descripcion_tipo = descripcion_tipo; }

    public int getId_agente() { return id_agente; }
    public void setId_agente(int id_agente) { this.id_agente = id_agente; }

    public int getId_tipo() { return id_tipo; }
    public void setId_tipo(int id_tipo) { this.id_tipo = id_tipo; }

    public String getEstado_llamada() { return estado_llamada; }
    public void setEstado_llamada(String estado_llamada) { this.estado_llamada = estado_llamada; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }

    public String getCodigo_llamada() { return codigo_llamada; }
    public void setCodigo_llamada(String codigo_llamada) { this.codigo_llamada = codigo_llamada; }
}