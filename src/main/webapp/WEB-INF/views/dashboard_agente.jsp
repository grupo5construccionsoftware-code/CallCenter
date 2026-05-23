<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Panel de agente del sistema call center.">
  <title>Panel Agente | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación Agente">
      <a href="/dashboard/agente" class="active">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/llamadas">Llamadas</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/login/salir" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-copy">
        <h1>Panel del Agente</h1>
        <p>Bienvenido al sistema operativo del agente. Desde aquí puedes registrar llamadas, consultar el historial y revisar las métricas de tu actividad.</p>
        <div class="hero-actions">
          <a class="button" href="/llamadas">
            <i class="fas fa-clipboard-list"></i> Registrar llamada
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
        <h3><i class="fas fa-phone"></i> Llamadas</h3>
        <p>Registra, edita y da seguimiento a cada llamada atendida.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-history"></i> Historial de llamadas</h3>
        <p>Consulta el registro completo de llamadas con filtros por cliente, fecha y motivo.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-chart-line"></i> Métricas</h3>
        <p>Indicadores actualizados con los datos reales del sistema.</p>
      </article>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Panel Agente</div>
</body>
</html>
