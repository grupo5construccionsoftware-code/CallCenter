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
      <h1>Registro de empresa</h1>
      <p>Completa los datos básicos de tu empresa y nos comunicaremos contigo para continuar el proceso.</p>
    </div>
    <article class="card">
      <div class="form-grid">
        <div>
          <label for="Nombre_empresa">Nombre de la empresa</label>
          <input type="text" id="Nombre_empresa" name="nombre_empresa" placeholder="Ej: Corporación XYZ S.A.C.">
        </div>
        <div>
          <label for="Telefono_empresa">Teléfono del gerente</label>
          <input type="tel" id="Telefono_empresa" name="Telefono_empresa" placeholder="Ej: 123 456 789">
        </div>
      </div>
      <div class="form-grid">
        <div>
          <label for="Correo_empresa">Correo de contacto</label>
          <input type="text" id="Correo_empresa" name="correo_empresa" placeholder="Ej: empresa@correo.com">
        </div>
      </div>
      <div class="actions">
        <button type="button">
          <i class="fas fa-paper-plane"></i>Enviar solicitud
        </button>
        <a class="button secondary" href="/contacto">
          <i class="fas fa-reply"></i>Volver
        </a>
      </div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Registro de Empresa</div>
</body>
</html>