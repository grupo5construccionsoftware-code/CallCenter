<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
      <form:form action="/agente/actualizar" method="post" modelAttribute="agente">
        <form:hidden path="id_agente"/>
        <form:hidden path="id_empresa"/>
        <form:hidden path="usuario_agente"/>
        <form:hidden path="contrasenia_agente"/>
        <div class="form-grid">
          <div>
            <label>Código de agente</label>
            <input type="text" value="${agente.id_agente}" readonly>
          </div>
          <div>
            <label for="nombre_agente">Nombre del agente</label>
            <form:input path="nombre_agente" id="nombre_agente" placeholder="Ej: Pérez García, Juan"/>
          </div>
          <div>
            <label for="telefono_agente">Teléfono del agente</label>
            <form:input path="telefono_agente" id="telefono_agente" placeholder="Ej: 123 456 789"/>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Actualizar</button>
          <a class="button secondary" href="/usuarios"><i class="fas fa-times"></i> Cancelar</a>
        </div>
      </form:form>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Editar Agente</div>
</body>
</html>