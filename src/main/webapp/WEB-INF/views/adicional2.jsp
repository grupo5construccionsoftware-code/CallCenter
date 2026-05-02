<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Página de contacto del sistema call center.">
  <title>Contacto | Sistema Call Center</title>
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
      <a href="/contacto" class="active">Contacto</a>
      <a href="/publicidad">Publicidad</a>
      <a href="/login" class="session">Login</a>
    </nav>
  </div>
</header>

<div class="container">

  <%-- ===== FORMULARIO DE CONTACTO ===== --%>
  <section class="section">
    <article class="card">
      <div class="hero-copy">
        <h1>Contáctanos</h1>
        <p>Completa el formulario y nos comunicaremos contigo a la brevedad posible.</p>
      </div>
      <form action="/contacto/enviar" method="post">
        <div class="form-grid">
          <div>
            <label for="nombre"><strong>Nombre</strong></label>
            <input type="text" id="nombre" name="nombre" placeholder="Ingresa tu nombre" required>
          </div>
          <div>
            <label for="apellido"><strong>Apellido</strong></label>
            <input type="text" id="apellido" name="apellido" placeholder="Ingresa tu apellido" required>
          </div>
        </div>
        <div class="form-grid">
          <div>
            <label for="telefono"><strong>Número de teléfono</strong></label>
            <input type="tel" id="telefono" name="telefono" placeholder="Ej: 999 999 999" pattern="[0-9\s\+\-]{7,15}" required>
          </div>
          <div>
            <label for="correo"><strong>Correo electrónico</strong></label>
            <input type="email" id="correo" name="correo" placeholder="Ej: correo@ejemplo.com" required>
          </div>
        </div>
        <div class="actions">
          <button type="submit">
            <i class="fas fa-paper-plane"></i> Enviar mensaje
          </button>
          <button type="reset" class="secondary">
            <i class="fas fa-times"></i> Limpiar
          </button>
        </div>
      </form>
    </article>
  </section>


</div>
<div class="footer">Sistema de Call Center - Contacto</div>
</body>
</html>