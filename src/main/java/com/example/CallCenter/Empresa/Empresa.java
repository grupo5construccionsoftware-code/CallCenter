package com.example.CallCenter.Empresa;

public class Empresa {

    private int id_empresa;
    private String nombre_empresa;
    private String telefono_empresa;
    private String correo_empresa;
    private String usuario_empresa;
    private String contrasenia_empresa;
    private String estado_empresa;

    public Empresa() {
    }

    public Empresa(int id_empresa, String nombre_empresa, String telefono_empresa, String correo_empresa) {
        this.id_empresa = id_empresa;
        this.nombre_empresa = nombre_empresa;
        this.telefono_empresa = telefono_empresa;
        this.correo_empresa = correo_empresa;
        this.estado_empresa = "ACTIVO";
    }

    public int getId_empresa() { return id_empresa; }
    public void setId_empresa(int id_empresa) { this.id_empresa = id_empresa; }

    public String getNombre_empresa() { return nombre_empresa; }
    public void setNombre_empresa(String nombre_empresa) { this.nombre_empresa = nombre_empresa; }

    public String getTelefono_empresa() { return telefono_empresa; }
    public void setTelefono_empresa(String telefono_empresa) { this.telefono_empresa = telefono_empresa; }

    public String getCorreo_empresa() { return correo_empresa; }
    public void setCorreo_empresa(String correo_empresa) { this.correo_empresa = correo_empresa; }

    public String getUsuario_empresa() { return usuario_empresa; }
    public void setUsuario_empresa(String usuario_empresa) { this.usuario_empresa = usuario_empresa; }

    public String getContrasenia_empresa() { return contrasenia_empresa; }
    public void setContrasenia_empresa(String contrasenia_empresa) { this.contrasenia_empresa = contrasenia_empresa; }

    public String getEstado_empresa() { return estado_empresa; }
    public void setEstado_empresa(String estado_empresa) { this.estado_empresa = estado_empresa; }
}
