package com.example.CallCenter.agente;

public class Agente {

    private int id_agente;
    private String nombre_agente;
    private String telefono_agente;
    private String usuario_agente;
    private String contrasenia_agente;
    private int id_empresa;

    public Agente() {}

    public Agente(int id_agente, String nombre_agente, String telefono_agente,
                  String usuario_agente, String contrasenia_agente, int id_empresa) {
        this.id_agente = id_agente;
        this.nombre_agente = nombre_agente;
        this.telefono_agente = telefono_agente;
        this.usuario_agente = usuario_agente;
        this.contrasenia_agente = contrasenia_agente;
        this.id_empresa = id_empresa;
    }

    public int getId_agente() { return id_agente; }
    public void setId_agente(int id_agente) { this.id_agente = id_agente; }

    public String getNombre_agente() { return nombre_agente; }
    public void setNombre_agente(String nombre_agente) { this.nombre_agente = nombre_agente; }

    public String getTelefono_agente() { return telefono_agente; }
    public void setTelefono_agente(String telefono_agente) { this.telefono_agente = telefono_agente; }

    public String getUsuario_agente() { return usuario_agente; }
    public void setUsuario_agente(String usuario_agente) { this.usuario_agente = usuario_agente; }

    public String getContrasenia_agente() { return contrasenia_agente; }
    public void setContrasenia_agente(String contrasenia_agente) { this.contrasenia_agente = contrasenia_agente; }

    public int getId_empresa() { return id_empresa; }
    public void setId_empresa(int id_empresa) { this.id_empresa = id_empresa; }
}