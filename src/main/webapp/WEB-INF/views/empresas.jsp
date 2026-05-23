<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Lista de empresas registradas en el sistema call center.">
  <title>Lista de Empresas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación SuperAdmin">
      <a href="/dashboard/superadmin">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/empresas" class="active">Lista de Empresas</a>
      <a href="/metricas/superadmin">Métricas</a>
      <a href="/login/salir" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Lista de Empresas</h1>
      <p>Empresas registradas que utilizan el sistema de call center</p>
    </div>
    <article class="card">
      <div class="actions">
        <a class="button" href="/adicional2">
          <i class="fas fa-plus"></i> Registrar nueva empresa
        </a>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Teléfono</th>
            <th>Correo</th>
            <th>Usuario</th>
            <th>Acciones</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty empresas}">
              <tr>
                <td colspan="6">No hay empresas registradas.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="empresa" items="${empresas}">
                <tr>
                  <td>${empresa.id}</td>
                  <td>${empresa.nombre}</td>
                  <td>${empresa.telefono}</td>
                  <td>${empresa.correo}</td>
                  <td>${empresa.usuario}</td>
                  <td>
                    <a class="button" href="/empresa/editar?id=${empresa.id}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/empresa/eliminar?id=${empresa.id}">
                      <i class="fas fa-trash"></i> Eliminar
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Lista de Empresas</div>
</body>
</html>
