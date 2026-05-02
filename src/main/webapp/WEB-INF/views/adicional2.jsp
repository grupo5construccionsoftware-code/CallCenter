<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro de Empresa | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegacion principal">
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
      <h1>Contáctanos</h1>
      <p>Completa el formulario y nos comunicaremos contigo a la brevedad posible.</p>
    </div>

    <article class="card">

      <c:if test="${registrado}">
        <div class="mensaje-exito">
           Tu solicitud se envió correctamente
        </div>
      </c:if>

      <form id="formEmpresa" action="/adicional2/registrar" method="post">

        <div class="form-grid">
          <div>
            <label for="nombre">Nombre de la empresa</label>
            <input type="text" id="nombre" name="nombre" placeholder="Ej: Corporacion XYZ S.A.C." required>
          </div>
          <div>
            <label for="telefono">Telefono del gerente</label>
            <input type="tel" id="telefono" name="telefono" placeholder="Ej: 999 999 999" required>
          </div>
        </div>

        <div class="form-grid">
          <div>
            <label for="correo">Correo de contacto</label>
            <input type="email" id="correo" name="correo" placeholder="Ej: empresa@correo.com" required>
          </div>
        </div>

        <div class="actions">
          <button type="submit">
            <i class="fas fa-paper-plane"></i> Enviar solicitud
          </button>
          <a class="button secondary" href="/contacto">
            <i class="fas fa-reply"></i> Volver
          </a>
        </div>

      </form>
    </article>
  </section>
</div>

<div class="footer">Sistema de Call Center - Registro de Empresa</div>

</body>
</html>
