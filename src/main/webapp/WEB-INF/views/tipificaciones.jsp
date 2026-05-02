<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Tipificaciones del sistema call center.">
  <title>Tipificaciones | Sistema Call Center</title>
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
      <h1>Tipificaciones</h1>
      <p>Agregar detalles de la llamada</p>
    </div>
    <article class="card">
      <form:form action="/tipificacion/crear" method="post" modelAttribute="tipificacion">
        <div class="form-grid">
          <div>
            <label for="id_llamada">Código de llamada</label>
            <form:input path="id_llamada" id="id_llamada" placeholder="Ej: 1"/>
          </div>
          <div>
            <label for="id_tipo">Motivo</label>
            <form:select path="id_tipo" id="id_tipo">
              <option value="" disabled selected>Selecciona un motivo</option>
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
          <button type="submit"><i class="fas fa-save"></i> Guardar</button>
          <a class="button secondary" href="/tipificacion/list">
            <i class="fas fa-eye"></i> Ver tipificaciones
          </a>
        </div>
      </form:form>
      <c:if test="${mostrarTabla}">
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>ID llamada</th>
                <th>Cliente</th>
                <th>Motivo</th>
                <th>Descripción</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${tipificaciones}" var="tipificacion">
                <tr>
                  <td>${tipificacion.id_llamada}</td>
                  <td>${tipificacion.nombre_cliente}</td>
                  <td>${tipificacion.motivo_tipo}</td>
                  <td>${tipificacion.descripcion_tipo}</td>
                  <td>
                    <a class="button" href="/tipificacion/editar?id=${tipificacion.id_llamada}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/tipificacion/eliminar?id=${tipificacion.id_llamada}">
                      <i class="fas fa-trash"></i> Eliminar
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Tipificación de llamadas</div>
</body>
</html>
