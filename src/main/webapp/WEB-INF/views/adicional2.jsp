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
      <c:choose>
        <c:when test="${modoAdmin}">
          <a href="/dashboard/superadmin">Inicio</a>
          <a href="/gestion">Gestión</a>
          <a href="/empresas" class="active">Lista de Empresas</a>
          <a href="/metricas/superadmin">Métricas</a>
          <a href="/login/salir" class="session">Salir</a>
        </c:when>
        <c:otherwise>
          <a href="/main">Inicio</a>
          <a href="${modoAdmin ? '/empresas' : '/contacto'}" class="active">Contacto</a>
          <a href="/publicidad">Publicidad</a>
          <a href="/login" class="session">Login</a>
        </c:otherwise>
      </c:choose>
    </nav>
  </div>
</header>

<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1><c:choose><c:when test="${modoAdmin}">Gestionar empresas</c:when><c:otherwise>Contáctanos</c:otherwise></c:choose></h1>
      <p><c:choose><c:when test="${modoAdmin}">Registra una empresa.</c:when><c:otherwise>Completa el formulario y nos comunicaremos contigo a la brevedad posible.</c:otherwise></c:choose></p>
    </div>

    <article class="card">

      <c:if test="${registrado}">
        <div class="mensaje-exito">
           Tu solicitud se envió correctamente
        </div>
      </c:if>

      <form id="formEmpresa" action="${modoAdmin ? '/empresa/registrar' : '/adicional2/registrar'}" method="post">

        <div class="form-grid">
          <div>
            <label for="nombre">Nombre de la empresa</label>
            <input type="text" id="nombre" name="nombre" placeholder="Ej: Corporacion XYZ S.A.C." required>
          </div>
          <div>
            <label for="telefono">Telefono del gerente</label>
            <input type="tel" id="telefono" name="telefono" placeholder="Ej: 123456789" required pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
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
          <a class="button secondary" href="${modoAdmin ? '/empresas' : '/contacto'}">
            <i class="fas fa-reply"></i> Volver
          </a>
        </div>

      </form>

      <c:if test="${empresaRegistrada != null}">
        <div class="notice-box">
          <h3><i class="fas fa-check-circle"></i> Empresa registrada exitosamente</h3>
          <p><strong>Código:</strong> ${empresaRegistrada.id}</p>
          <p><strong>Nombre:</strong> ${empresaRegistrada.nombre}</p>
          <p><strong>Teléfono:</strong> ${empresaRegistrada.telefono}</p>
          <p><strong>Correo:</strong> ${empresaRegistrada.correo}</p>
          <p><strong>Usuario:</strong> ${empresaRegistrada.usuario}</p>
          <p><strong>Contraseña:</strong> ${empresaRegistrada.contrasenia}</p>
          <p>Guarda estos datos, no se volverán a mostrar.</p>
          <div class="actions">
            <a class="button" href="${modoAdmin ? '/empresas' : '/contacto'}">
              <i class="fas fa-check"></i> Aceptar
            </a>
          </div>
        </div>
      </c:if>


    </article>
  </section>
</div>

<div class="footer">Sistema de Call Center - Registro de Empresa</div>

</body>
</html>
