<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Panel interno del sistema call center.">
  <title>Inicio interno | Sistema Call Center</title>
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
      <a href="/dashboard" class="active">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/llamadas">Llamadas</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/usuarios">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-copy">
        <h1>Panel interno del call center</h1>
        <p>Bienvenido al sistema de gestión operativa. Desde aquí puedes acceder a todos los módulos para registrar llamadas, administrar usuarios y revisar métricas del servicio.</p>
        <div class="hero-actions">
          <a class="button" href="/llamadas">
            <i class="fas fa-clipboard-list"></i>Registrar llamada
          </a>
          <a class="button secondary" href="/metricas">
            <i class="fas fa-chart-bar"></i>Ver métricas
          </a>
        </div>
      </div>
    </div>
  </section>
  <section class="section">
      <div class="grid">
        <article class="card">
          <h3><i class="fas fa-phone"></i> Gestión y llamadas</h3>
          <p>Registra, edita y da seguimiento a cada llamada atendida por el equipo.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-tags"></i> Tipificaciones</h3>
          <p>Categoriza los motivos de llamada: consultas, reclamos, ventas y soporte.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-chart-line"></i> Métricas internas</h3>
          <p>Indicadores actualizados con los datos reales del sistema.</p>
        </article>
      </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Página principal (Acceso privado)</div>
</body>
</html>
