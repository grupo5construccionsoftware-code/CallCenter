<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Gestión del sistema call center.">
  <title>Gestión | Sistema Call Center</title>
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
      <a href="/gestion" class="active">Gestión</a>
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
  <section class="section">
    <div class="hero-copy">
      <h1>Gestión del sistema</h1>
      <p>Información corporativa, políticas y estructura de procesos del call center.</p>
    </div>
    <div class="grid">
      <article class="card">
        <h3><i class="fas fa-building"></i> Información corporativa</h3>
        <p>Sistema de gestión operativa para call centers. Permite registrar, tipificar y hacer seguimiento de llamadas de forma organizada.</p>
      </article>
      <article class="card">
        <h3><i class="fas fa-file-alt"></i> Políticas de uso</h3>
        <p>El acceso al sistema es exclusivo para personal autorizado. Los registros deben completarse con datos verídicos y actualizados.</p>
      </article>
    </div>
    <div class="section">
      <div class="grid">
        <article class="card">
          <h3><i class="fas fa-sitemap"></i> Estructura de procesos</h3>
          <p>1. El agente recibe la llamada y registra los datos del cliente.</p>
          <p>2. Se tipifica la llamada según su motivo.</p>
          <p>3. El historial queda disponible para consulta y seguimiento.</p>
          <p>4. Las métricas se actualizan con cada registro ingresado.</p>
        </article>
        <article class="card">
          <h3><i class="fas fa-users"></i> Directorio del personal</h3>
          <p><i class="fas fa-user"></i> Marcelo Valer, Alessandro</p>
          <p><i class="fas fa-user"></i> Apolinario Orihuela, Denilson</p>
          <p><i class="fas fa-user"></i> Galarza De la Cruz, Noeli</p>
          <p><i class="fas fa-user"></i> Ledesma Huaman, Angelo</p>
          <p><i class="fas fa-user"></i> Pineda Tenicela, Walter</p>
        </article>
      </div>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Gestión</div>
</body>
</html>