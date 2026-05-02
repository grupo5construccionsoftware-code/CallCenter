<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Editar llamada del sistema call center.">
  <title>Editar Llamada | Sistema Call Center</title>
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
      <a href="/llamadas" class="active">Llamadas</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/usuarios">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Editar llamada</h1>
      <p>Modifica los datos de una llamada registrada</p>
    </div>
    <article class="card">
      <form:form action="/llamada/actualizar" method="post" modelAttribute="llamada">
        <form:hidden path="id_llamada"/>
        <form:hidden path="id_agente"/>
        <form:hidden path="fecha_llamada"/>
        <form:hidden path="hora"/>
        <div class="form-grid">
          <div>
            <label>Código de llamada</label>
            <input type="text" value="${llamada.id_llamada}" readonly>
          </div>
          <div>
            <label for="nombre_cliente">Nombre del cliente</label>
            <form:input path="nombre_cliente" id="nombre_cliente" placeholder="Ej: Alex Pérez"/>
          </div>
          <div>
            <label for="telefono_cliente">Teléfono del cliente</label>
            <form:input path="telefono_cliente" id="telefono_cliente" placeholder="Ej: 123 456 789"/>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Actualizar</button>
          <a class="button secondary" href="/llamadas"><i class="fas fa-times"></i> Cancelar</a>
        </div>
      </form:form>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Editar Llamada</div>
</body>
</html>