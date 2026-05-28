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
    <section class="section">
      <div class="hero-copy">
        <h1>Contacto</h1>
        <p>¿Tienes alguna consulta? Escríbenos y te responderemos a la brevedad.</p>
      </div>
      <div class="grid">
        <article class="card">
          <h3>Envíanos un mensaje</h3>
          <form action="/contacto/enviar" method="post">
            <div>
              <label for="nombre">Nombre completo</label>
              <input type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>
            </div>
            <div>
              <label for="email">Correo electrónico</label>
              <input type="email" id="email" name="email" placeholder="tu@correo.com" required>
            </div>
            <div>
              <label for="asunto">Asunto</label>
              <input type="text" id="asunto" name="asunto" placeholder="Motivo de contacto" required>
            </div>
            <div>
              <label for="mensaje">Mensaje</label>
              <textarea id="mensaje" name="mensaje" rows="5" placeholder="Escribe tu mensaje aquí..." required></textarea>
            </div>
            <div class="actions">
              <button type="submit" class="button">
                <i class="fas fa-paper-plane"></i> Enviar mensaje
              </button>
            </div>
          </form>
        </article>
      </div>
    </section>
  </div>

</div>
<div class="footer">Sistema de Call Center - Contacto</div>
</body>
</html>