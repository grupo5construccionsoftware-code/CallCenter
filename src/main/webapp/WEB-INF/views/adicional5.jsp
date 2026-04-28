<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Editar agente del sistema call center.">
  <title>Editar Agente | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación privada">
      <a href="/dashboard">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/llamadas">Llamadas</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/usuarios" class="active">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Editar agente</h1>
      <p>Modifica los datos de un agente registrado</p>
    </div>
    <article class="card">
      <input type="hidden" name="id_agente" value="age01">
      <input type="hidden" name="id_empresa" value="emp01">
      <div class="form-grid">
        <div>
          <label>Código de agente</label>
          <input type="text" value="age01" readonly>
        </div>
        <div>
          <label for="nombre-editar">Nombre del agente</label>
          <input type="text" id="nombre-editar" name="nombre_agente" placeholder="Ej: Pepito García">
        </div>
        <div>
          <label for="telefono-editar">Teléfono del agente</label>
          <input type="tel" id="telefono-editar" name="telefono_agente" placeholder="Ej: 123 456 789">
        </div>
      </div>
      <div class="actions">
        <button type="button">
            <i class="fas fa-save"></i> Actualizar
        </button>
        <a class="button secondary" href="/usuarios">
            <i class="fas fa-times"></i> Cancelar
        </a>
      </div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Editar Agente</div>
</body>
</html>