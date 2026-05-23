<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Panel SuperAdmin del sistema call center.">
  <title>SuperAdmin | Sistema Call Center</title>
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
      <a href="/dashboard/superadmin" class="active">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/empresas">Lista de Empresas</a>
      <a href="/metricas/superadmin">Métricas</a>
      <a href="/login/salir" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-copy">
        <h1>Panel SuperAdmin</h1>
        <p>Bienvenido al panel de administración global. Desde aquí puedes gestionar todas las empresas registradas, consultar métricas generales y supervisar la operación del sistema.</p>
        <div class="hero-actions">
          <a class="button" href="/empresas">
            <i class="fas fa-building"></i> Lista de Empresas
          </a>
          <a class="button secondary" href="/metricas/superadmin">
            <i class="fas fa-chart-bar"></i> Ver Métricas
          </a>
        </div>
      </div>
    </div>
  </section>
  <section class="section">
    <div class="grid">
      <article class="card">
        <h3><i class="fas fa-building"></i> Lista de Empresas</h3>
        <p>Consulta y administra todas las empresas registradas en el sistema.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-chart-line"></i> Métricas globales</h3>
        <p>Visualiza indicadores filtrados por empresa para un análisis comparativo.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-sitemap"></i> Gestión del sistema</h3>
        <p>Información corporativa, políticas y estructura de procesos del call center.</p>
      </article>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Panel SuperAdmin</div>
</body>
</html>