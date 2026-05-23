<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Métricas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Métricas</h1>
      <p>Indicadores internos de los servicios realizados</p>
    </div>
    <div class="grid">
      <article class="card metric">
        <strong><i class="fas fa-phone"></i> Llamadas atendidas</strong>
        <span class="value">128</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-users"></i> Nro de clientes frecuentes</strong>
        <span class="value">14</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-check-circle"></i> Clientes satisfechos</strong>
        <span class="value">114</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-stopwatch"></i> Tiempo promedio</strong>
        <span class="value">4.6 min</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-tags"></i> Tipificación más común</strong>
        <span class="value">Consulta</span>
      </article>
    </div>
    <div class="actions single align-center">
      <button type="button"><i class="fas fa-redo"></i> Actualizar métricas</button>
    </div>
    <p></p>
    <div class="card">
      <div class="graph-placeholder"><div><strong>Espacio para gráficos estadísticos</strong></div></div>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas</div>
</body>
</html>
