<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Panel de empresa del sistema call center.">
  <title>Panel Empresa | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación Empresa">
      <a href="/dashboard/empresa" class="active">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/metricas">Métricas</a>
      <a href="/usuarios">Usuarios</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/login/salir" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-copy">
        <h1>Panel interno del call center</h1>
        <p>Bienvenido al sistema de gestión operativa. Desde aquí puedes acceder a todos los módulos para administrar usuarios, tipificaciones y revisar métricas del servicio.</p>
        <div class="hero-actions">
          <a class="button" href="/usuarios">
            <i class="fas fa-users"></i> Gestionar Agentes
          </a>
          <a class="button secondary" href="/metricas">
            <i class="fas fa-chart-bar"></i> Ver Métricas
          </a>
        </div>
      </div>
    </div>
  </section>
  <section class="section">
    <div class="grid">
      <article class="card">
        <h3><i class="fas fa-users"></i> Usuarios (Agentes)</h3>
        <p>Registra, edita y administra los agentes que operan el call center.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-tags"></i> Tipificaciones</h3>
        <p>Categoriza los motivos de llamada: consultas, reclamos, ventas y soporte.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-history"></i> Historial de llamadas</h3>
        <p>Consulta el registro completo de llamadas con filtros por cliente, fecha y motivo.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-chart-line"></i> Métricas internas</h3>
        <p>Indicadores actualizados con los datos reales del sistema.</p>
      </article>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Panel Empresa</div>
</body>
</html>
