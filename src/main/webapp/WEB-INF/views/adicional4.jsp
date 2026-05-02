<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Editar tipificación del sistema call center.">
  <title>Editar Tipificación | Sistema Call Center</title>
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
      <a href="/tipificaciones" class="active">Tipificaciones</a>
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
      <h1>Editar tipificación</h1>
      <p>Modifica los detalles de una tipificación registrada</p>
    </div>
    <article class="card">
      <form:form action="/tipificacion/actualizar" method="post" modelAttribute="tipificacion">
        <form:hidden path="id_llamada"/>
        <form:hidden path="nombre_cliente"/>
        <div class="form-grid">
          <div>
            <label>Código de llamada</label>
            <input type="text" value="${tipificacion.id_llamada}" readonly>
          </div>
          <div>
            <label for="id_tipo">Motivo</label>
            <form:select path="id_tipo" id="id_tipo">
              <option value="" disabled>Selecciona un motivo</option>
              <option value="1">Consulta</option>
              <option value="2">Reclamo</option>
              <option value="3">Venta</option>
              <option value="4">Soporte</option>
              <option value="5">Otros</option>
            </form:select>
          </div>
          <div>
            <label for="descripcion_tipo">Descripción</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo" placeholder="Ej: Cliente consulta sobre su factura"/>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Actualizar</button>
          <a class="button secondary" href="/tipificaciones"><i class="fas fa-times"></i> Cancelar</a>
        </div>
      </form:form>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Editar Tipificación</div>
</body>
</html>