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
    </div>
    <div class="grid">
      <article class="card">
        <h3>Contactese con nuestro personal</h3>
        <div class="grid">
          <article class="card">
            <p><i class="fas fa-user"></i>Marcelo Valer, Alessandro</p>
            <p><i class="fas fa-envelope"></i>76347799@continental.edu.pe</p>
          </article>
          <article class="card">
            <p><i class="fas fa-user"></i>Apolinario Orihuela, Denilson</p>
            <p><i class="fas fa-envelope"></i>71127773@continental.edu.pe</p>
          </article>
        </div>
        <p></p>
        <div class="grid">
          <article class="card">
            <p><i class="fas fa-user"></i>Galarza De la Cruz, Noeli</p>
            <p><i class="fas fa-envelope"></i>72106014@continental.edu.pe</p>
          </article>
          <article class="card">
            <p><i class="fas fa-user"></i>Ledesma Huaman, Angelo</p>
            <p><i class="fas fa-envelope"></i>75608544@continental.edu.pe</p>
          </article>
        </div>
        <p></p>
        <div class="grid">
          <article class="card">
            <p><i class="fas fa-user"></i>Pineda Tenicela, Walter</p>
            <p><i class="fas fa-envelope"></i>72749649@continental.edu.pe</p>
          </article>
        </div>
      </article>
    </div>
  </section>

  <section class="section">
    <div class="grid">


      <article class="card">

        <div class="hero-copy">
          <h1>Contáctanos</h1>
          <p>Completa el formulario y nos comunicaremos contigo a la brevedad posible.</p>
        </div>

        <form action="/contacto" method="get">
          <div class="form-grid">
            <div>
              <label for="nombre">Nombre de la empresa</label>
              <input type="text" id="nombre" name="nombre" placeholder="Ej: Corporacion XYZ S.A.C." required>
            </div>
            <div>
              <label for="telefono">Telefono del gerente</label>
              <input type="tel" id="telefono" name="telefono" placeholder="Ej: 123456789" required
                     pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
            </div>
          </div>
          <div class="form-grid">
            <div>
              <label for="correo">Correo de contacto</label>
              <input type="email" id="correo" name="correo" placeholder="Ej: empresa@correo.com" required>
            </div>
          </div>
          <input type="hidden" name="enviado" value="true">
          <div class="actions">
            <button type="submit">
              <i class="fas fa-paper-plane"></i> Enviar solicitud
            </button>
          </div>
        </form>

        <% if ("true".equals(request.getParameter("enviado"))) { %>
        <div class="mensaje-exito" style="text-align: center; margin-top: 15px;">
          ✅ Tu solicitud se envió correctamente. Nos comunicaremos contigo pronto.
        </div>
        <% } %>

      </article>


      <article class="card">
        <div class="hero-copy">
          <h1>Síguenos en nuestras redes sociales</h1>
        </div>
        <div class="hero-actions">
          <a href="https://facebook.com" target="_blank" class="button" title="Facebook">
            <i class="fab fa-facebook-f"></i> Facebook
          </a>
          <a href="https://web.whatsapp.com" target="_blank" class="button" title="WhatsApp">
            <i class="fab fa-whatsapp"></i> WhatsApp
          </a>
          <a href="https://linkedin.com" target="_blank" class="button" title="LinkedIn">
            <i class="fab fa-linkedin"></i> LinkedIn
          </a>
        </div>
      </article>

    </div>
  </section>

</div>
<div class="footer">Sistema de Call Center - Contacto</div>
</body>
</html>