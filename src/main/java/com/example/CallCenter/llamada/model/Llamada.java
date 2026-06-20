package com.example.CallCenter.llamada.model;

public class Llamada {

    private int id_llamada;
    private String nombre_cliente;
    private String telefono_cliente;
    private String fecha_llamada;
    private String hora_inicio;
    private String hora_fin;
    private String duracion;
    private String descripcion_tipo;
    private int id_agente;
    private Integer id_tipo;
    private String estado_llamada;
    private String motivo_tipo;
    private String codigo_llamada;

    public Llamada() {}

    public Llamada(int id_llamada, String nombre_cliente, String telefono_cliente,
                   String fecha_llamada, String hora_inicio, String hora_fin, String duracion,
                   String descripcion_tipo, int id_agente, int id_tipo,
                   String estado_llamada, String motivo_tipo) {
        this.id_llamada = id_llamada;
        this.nombre_cliente = nombre_cliente;
        this.telefono_cliente = telefono_cliente;
        this.fecha_llamada = fecha_llamada;
        this.hora_inicio = hora_inicio;
        this.hora_fin = hora_fin;
        this.duracion = duracion;
        this.descripcion_tipo = descripcion_tipo;
        this.id_agente = id_agente;
        this.id_tipo = id_tipo;
        this.estado_llamada = estado_llamada;
        this.motivo_tipo = motivo_tipo;
    }

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

    public String getHora() { return hora_inicio; }
    public void setHora(String hora) { this.hora_inicio = hora; }

    public String getHora_fin() { return hora_fin; }
    public void setHora_fin(String hora_fin) { this.hora_fin = hora_fin; }

    public String getDuracion() { return duracion; }
    public void setDuracion(String duracion) { this.duracion = duracion; }

    public String getDescripcion_tipo() { return descripcion_tipo; }
    public void setDescripcion_tipo(String descripcion_tipo) { this.descripcion_tipo = descripcion_tipo; }

    public String getDescripcion_llamada() { return descripcion_tipo; }
    public void setDescripcion_llamada(String descripcion) { this.descripcion_tipo = descripcion; }

    public int getId_agente() { return id_agente; }
    public void setId_agente(int id_agente) { this.id_agente = id_agente; }

    public Integer getId_tipo() { return id_tipo; }
    public void setId_tipo(Integer id_tipo) { this.id_tipo = id_tipo; }

    public String getEstado_llamada() { return estado_llamada; }
    public void setEstado_llamada(String estado_llamada) { this.estado_llamada = estado_llamada; }

    public String getEstado() { return estado_llamada; }
    public void setEstado(String estado) { this.estado_llamada = estado; }

    public String getMotivo_tipo() { return motivo_tipo; }
    public void setMotivo_tipo(String motivo_tipo) { this.motivo_tipo = motivo_tipo; }

    public String getCodigo_llamada() { return codigo_llamada; }
    public void setCodigo_llamada(String codigo_llamada) { this.codigo_llamada = codigo_llamada; }
}