package com.example.CallCenter.llamada;

public class Llamada {

    private int id_llamada;
    private String nombre_cliente;
    private String telefono_cliente;
    private String fecha_llamada;
    private String hora;
    private int id_agente;

    public Llamada() {}

    public Llamada(int id_llamada, String nombre_cliente, String telefono_cliente,
                   String fecha_llamada, String hora, int id_agente) {
        this.id_llamada = id_llamada;
        this.nombre_cliente = nombre_cliente;
        this.telefono_cliente = telefono_cliente;
        this.fecha_llamada = fecha_llamada;
        this.hora = hora;
        this.id_agente = id_agente;
    }

    public int getId_llamada() { return id_llamada; }
    public void setId_llamada(int id_llamada) { this.id_llamada = id_llamada; }

    public String getNombre_cliente() { return nombre_cliente; }
    public void setNombre_cliente(String nombre_cliente) { this.nombre_cliente = nombre_cliente; }

    public String getTelefono_cliente() { return telefono_cliente; }
    public void setTelefono_cliente(String telefono_cliente) { this.telefono_cliente = telefono_cliente; }

    public String getFecha_llamada() { return fecha_llamada; }
    public void setFecha_llamada(String fecha_llamada) { this.fecha_llamada = fecha_llamada; }

    public String getHora() { return hora; }
    public void setHora(String hora) { this.hora = hora; }

    public int getId_agente() { return id_agente; }
    public void setId_agente(int id_agente) { this.id_agente = id_agente; }
}