<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      <div class="form-grid">
        <input type="hidden" name="id_agente" value="age01">
        <div>
          <label for="cliente-llamada">Nombre del cliente</label>
          <input type="text" id="cliente-llamada" name="nombre_cliente" placeholder="Ej: Alex Pérez">
        </div>
        <div>
          <label for="telefono-llamada">Teléfono del cliente</label>
          <input type="tel" id="telefono-llamada" name="telefono_cliente" placeholder="Ej: 123 456 789">
        </div>
      </div>
      <p></p>
      <div class="actions">
        <button type="button">
          <i class="fas fa-save"></i>Registrar
        </button>
        <button type="button" class="secondary">
          <i class="fas fa-eye"></i>Ver llamadas
        </button>
      </div>
      <p></p>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>ID llamada</th>
              <th>Cliente</th>
              <th>Teléfono cliente</th>
              <th>Agente</th>
              <th>Fecha</th>
              <th>Hora</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>LL01</td>
              <td>Alex Pérez</td>
              <td>123 456 789</td>
              <td>Pepito García</td>
              <td>2026-04-19</td>
              <td>10:30</td>
              <td>
          <a class="button" href="/adicional3">
            <i class="fas fa-edit"></i> Editar
          </a>
          <button type="button" class="secondary">
            <i class="fas fa-trash"></i> Eliminar
          </button>
        </td>
      </tr>
    </tbody>
  </table>
</div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Registro de llamadas</div>
</body>
</html>
