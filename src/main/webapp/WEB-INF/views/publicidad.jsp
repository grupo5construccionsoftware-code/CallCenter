<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Publicidad e información del sistema call center.">
  <title>Publicidad | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación principal">
      <a href="/main">Inicio</a>
      <a href="/contacto">Contacto</a>
      <a href="/publicidad" class="active">Publicidad</a>
      <a href="/login" class="session">Login</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Lo que ofrece el sistema</h1>
      <p>Resumen ordenado de sus módulos y utilidades.</p>
    </div>
    <div class="grid">
      <article class="card">
        <h3><i class="fas fa-phone-alt"></i>Atención de llamadas</h3>
        <p>Registro organizado con código automático, estados y mensajes de validación.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-tags"></i>Tipificaciones</h3>
        <p>Categorización de motivos para registrar consultas, reclamos, ventas y soporte.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-users"></i>Gestión de usuarios</h3>
        <p>Registro, actualización y eliminación de usuarios mediante controles básicos.</p>
      </article>
      </div>
      <p></p>
      <div class="grid">
      <article class="card">
        <h3><i class="fas fa-chart-bar"></i>Métricas</h3>
        <p>Indicadores internos y un espacio preparado para futuros gráficos estadísticos.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-history"></i>Historial y seguimiento</h3>
        <p>Consulta de registros y actualización del historial para controlar la operación diaria.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-lock"></i>Acceso interno</h3>
        <p>El panel privado se habilita después del login.</p>
      </article>
    </div>
  </section>
  <section class="section">
    <article class="card">
    <div class="hero-copy">
        <h1>¡¡¡Optimiza tu call center!!!</h1>
        <div class="hero-actions">
          <a class="button" href="/contacto">
            <i class="fas fa-paper-plane"></i>Contactate con nosotros
          </a>
          <a class="button secondary" href="/login">
            <i class="fas fa-sign-in-alt"></i>Acceder al sistema
          </a>
        </div>
    </div>
    </article>
</section>
</div>
<div class="footer">Sistema de Call Center - Publicidad</div>
</body>
</html>
