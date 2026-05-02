<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Ingreso al sistema call center.">
  <title>Login | Sistema Call Center</title>
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
      <a href="/contacto">Contacto</a>
      <a href="/publicidad">Publicidad</a>
      <a href="/login" class="active session">Login</a>
    </nav>
  </div>
</header>

<div class="container">
  <section class="login-shell">
    <main class="login-box">
      <h2>Ingreso al sistema</h2>
      <p>El acceso interno habilita los modulos operativos, las metricas y el resto de pantallas privadas.</p>

      <%-- Formulario apunta al controller POST /login/ingresar --%>
      <form action="/login/ingresar" method="post">
        <div class="form-grid">
          <div>
            <label for="usuario-login">Usuario</label>
            <input type="text" id="usuario-login" name="usuario" placeholder="Tu usuario" required>
          </div>
          <div>
            <label for="contrasena-login">Contrasena</label>
            <input type="password" id="contrasena-login" name="contrasena" placeholder="Tu contrasena" required>
          </div>
        </div>

        <%-- Mensaje de error si las credenciales son incorrectas --%>
        <c:if test="${error == true}">
          <div class="notice-box error">
            <p>
              <i class="fas fa-exclamation-circle"></i>
              <strong> Usuario o contrasena incorrectos.</strong> Por favor verifica tus datos.
            </p>
          </div>
        </c:if>

        <div class="actions single align-center">
          <button type="submit">
            <i class="fas fa-sign-in-alt"></i> Ingresar
          </button>
        </div>
      </form>

      <p></p>
    </main>
  </section>
</div>

<div class="footer">Sistema de Call Center - Login</div>
</body>
</html>
