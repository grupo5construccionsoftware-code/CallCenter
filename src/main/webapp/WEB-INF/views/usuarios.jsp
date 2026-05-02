<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Gestión de usuarios del sistema call center.">
  <title>Usuarios | Sistema Call Center</title>
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
      <h1>Agentes del Call Center</h1>
      <p>Registro de los agentes que operan el call center y su número telefónico</p>
    </div>
    <article class="card">
      <form:form action="/agente/crear" method="post" modelAttribute="agente">
        <div class="form-grid">
          <div>
            <label for="nombre_agente">Nombre del agente</label>
            <form:input path="nombre_agente" id="nombre_agente" placeholder="Ej: Pérez García, Juan"/>
          </div>
          <div>
            <label for="telefono_agente">Teléfono del agente</label>
            <form:input path="telefono_agente" id="telefono_agente" placeholder="Ej: 123 456 789"/>
          </div>
        </div>
        <div class="actions single align-center">
          <button type="submit">
            <i class="fas fa-save"></i> Guardar agente
          </button>
          <a class="button secondary" href="/agente/list">
            <i class="fas fa-eye"></i> Ver agentes
          </a>
        </div>
      </form:form>
      <c:if test="${mostrarTabla}">
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Código</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${agentes}" var="agente">
              <tr>
                <td>${agente.id_agente}</td>
                <td>${agente.nombre_agente}</td>
                <td>${agente.telefono_agente}</td>
                <td>
                  <a class="button" href="/agente/editar?id=${agente.id_agente}">
                    <i class="fas fa-edit"></i> Editar
                  </a>
                  <a class="button secondary" href="/agente/eliminar?id=${agente.id_agente}">
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
<div class="footer">Sistema de Call Center - Usuarios (Agentes)</div>
</body>
</html>
