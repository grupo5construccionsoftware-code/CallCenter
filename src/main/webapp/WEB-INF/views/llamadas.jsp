<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Registro de llamadas del sistema call center.">
  <title>Llamadas | Sistema Call Center</title>
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
      <h1>Registro de llamadas</h1>
      <p>Registre las llamadas con los datos solicitados</p>
    </div>
    <article class="card">
      <form:form action="/llamada/crear" method="post" modelAttribute="llamada">
        <div class="form-grid">
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
          <button type="submit"><i class="fas fa-save"></i> Registrar</button>
          <a class="button secondary" href="/llamada/list">
            <i class="fas fa-eye"></i> Ver llamadas
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
                <th>Teléfono cliente</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${llamadas}" var="llamada">
                <tr>
                  <td>${llamada.id_llamada}</td>
                  <td>${llamada.nombre_cliente}</td>
                  <td>${llamada.telefono_cliente}</td>
                  <td>${llamada.fecha_llamada}</td>
                  <td>${llamada.hora}</td>
                  <td>
                    <a class="button" href="/llamada/editar?id=${llamada.id_llamada}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/llamada/eliminar?id=${llamada.id_llamada}">
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
<div class="footer">Sistema de Call Center - Registro de llamadas</div>
</body>
</html>
