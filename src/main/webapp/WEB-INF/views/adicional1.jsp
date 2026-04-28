<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Historial de llamadas del sistema call center.">
  <title>Historial de llamadas | Sistema Call Center</title>
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
      <a href="/usuarios">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1" class="active">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Historial de llamadas</h1>
      <p>Consulta de registros con actualización manual</p>
    </div>
    <article class="card">
      <div class="form-grid">
        <div>
          <label for="buscar-cliente">Buscar por cliente</label>
          <input type="text" id="buscar-cliente" name="buscar_cliente" placeholder="Nombre del cliente...">
        </div>
        <div>
          <label for="filtrar-motivo">Filtrar por motivo</label>
          <select id="filtrar-motivo" name="filtrar_motivo">
            <option value="">Todos</option>
            <option value="reclamo">Reclamo</option>
            <option value="consulta">Consulta</option>
            <option value="venta">Venta</option>
            <option value="soporte">Soporte</option>
          </select>
        </div>
        <div>
          <label for="fecha-llamada">Fecha de llamada</label>
          <input type="date" id="fecha-llamada" name="fecha_llamada">
        </div>
      </div>
      <div class="actions">
        <button type="button">
          <i class="fas fa-search"></i> Buscar
        </button>
        <button type="button" class="secondary">
          <i class="fas fa-redo"></i> Actualizar historial
        </button>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Código llamada</th>
              <th>Cliente</th>
              <th>Teléfono cliente</th>
              <th>Motivo</th>
              <th>Fecha llamada</th>
              <th>Hora</th>
              <th>Agente</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>LL01</td>
              <td>Alex Pérez</td>
              <td>123456789</td>
              <td>Reclamo</td>
              <td>2026-04-10</td>
              <td>10:30</td>
              <td>Pepito García</td>
            </tr>
          </tbody>
        </table>
      </div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Historial de llamadas</div>
</body>
</html>
