<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Sistema de call center con acceso público e ingreso privado.">
  <title>Inicio | Sistema Call Center</title>
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
      <a href="/main" class="active">Inicio</a>
      <a href="/contacto">Contacto</a>
      <a href="/publicidad">Publicidad</a>
      <a href="/login" class="session">Login</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="hero">
    <div class="hero-inner">
      <div class="hero-copy">
        <h1>Control claro para la atención del call center</h1>
        <p>Sistema de call center que permite registrar, gestionar y tipificar las llamadas. Si tiene una cuenta inicie sesión para acceder a todas las funcionalidades o si conocernos siga navegando en el menu.</p>
        <div class="hero-actions">
          <a class="button" href="/login">
            <i class="fas fa-sign-in-alt"></i>Ir al login
          </a>
          <a class="button secondary" href="/publicidad">
            <i class="fas fa-eye"></i>Ver lo que ofrece
          </a>
        </div>
      </div>
    </div>
  </section>
  <section class="section">
      <div class="section-title">
        <h2>Accesos que ofrece el sistema:</h2>
      </div>
      <div class="grid">
        <article class="card">
          <h3><i class="fas fa-unlock"></i>Acceso público</h3>
          <p>Navegue entra la página principal, vea cómo contactarnos y vea la presentación general del sistema.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-lock"></i>Ingreso privado</h3>
          <p>Acceso total a las funcionalidades del sistema para el registro y tipifiación de llamadas, además de la supervisión de las métricas.</p>
        </article>
      </div>
  </section>
  <section class="section">
      <div class="section-title">
        <h2>¿Por qué usar este sistema?</h2>
      </div>
      <div class="grid">
        <article class="card">
          <h3><i class="fas fa-clipboard-list"></i>Registro ordenado</h3>
          <p>Centraliza todas las llamadas con código automático, estado y motivo de contacto.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-chart-bar"></i>Métricas en tiempo real</h3>
          <p>Visualiza indicadores de atención para tomar decisiones operativas con datos reales.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-users"></i>Gestión de usuarios</h3>
          <p>Administra clientes y agentes del call center desde un único panel seguro.</p>
        </article>
      </div>
    </section>
</div>
<div class="footer">Sistema de Call Center - Página principal</div>
</body>
</html>
