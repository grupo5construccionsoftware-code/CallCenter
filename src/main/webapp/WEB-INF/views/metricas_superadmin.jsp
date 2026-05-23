<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Métricas globales del sistema call center.">
  <title>Métricas SuperAdmin | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación SuperAdmin">
      <a href="/dashboard/superadmin">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/empresas">Lista de Empresas</a>
      <a href="/metricas/superadmin" class="active">Métricas</a>
      <a href="/login/salir" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Métricas globales</h1>
      <p>Indicadores del sistema filtrados por empresa</p>
    </div>

    <%-- Filtro por empresa --%>
    <article class="card">
      <div class="form-grid">
        <div>
          <label for="filtro-empresa">Filtrar por empresa</label>
          <select id="filtro-empresa" name="id_empresa">
            <option value="">Todas las empresas</option>
            <c:forEach var="empresa" items="${empresas}">
              <option value="${empresa.id}"
                      <c:if test="${empresa.id == empresaSeleccionada}">selected</c:if>>
                  ${empresa.nombre}
              </option>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="actions">
        <button type="button" id="btn-filtrar">
          <i class="fas fa-search"></i> Filtrar
        </button>
        <button type="button" class="secondary" id="btn-limpiar">
          <i class="fas fa-redo"></i> Ver todas
        </button>
      </div>
    </article>

    <%-- Métricas --%>
    <div class="grid" style="margin-top:16px;">
      <article class="card metric">
        <strong><i class="fas fa-building"></i> Empresas registradas</strong>
        <span class="value">${totalEmpresas != null ? totalEmpresas : 0}</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-phone"></i> Llamadas atendidas</strong>
        <span class="value">${totalLlamadas != null ? totalLlamadas : 0}</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-users"></i> Agentes activos</strong>
        <span class="value">${totalAgentes != null ? totalAgentes : 0}</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-check-circle"></i> Clientes satisfechos</strong>
        <span class="value">${clientesSatisfechos != null ? clientesSatisfechos : 0}</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-tags"></i> Tipificación más común</strong>
        <span class="value">${tipificacionComun != null ? tipificacionComun : "-"}</span>
      </article>
    </div>

    <div class="actions single align-center" style="margin-top:14px;">
      <button type="button">
        <i class="fas fa-redo"></i> Actualizar métricas
      </button>
    </div>
    <p></p>
    <div class="card">
      <div class="graph-placeholder">
        <div><strong>Espacio para gráficos estadísticos comparativos entre empresas</strong></div>
      </div>
    </div>
  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas SuperAdmin</div>
<script>
  (function () {
    const select = document.getElementById('filtro-empresa');
    const btnFiltrar = document.getElementById('btn-filtrar');
    const btnLimpiar = document.getElementById('btn-limpiar');

    btnFiltrar.addEventListener('click', function () {
      const id = select.value;
      const url = id
              ? '/metricas/superadmin?id_empresa=' + encodeURIComponent(id)
              : '/metricas/superadmin';
      window.location.href = url;
    });

    btnLimpiar.addEventListener('click', function () {
      window.location.href = '/metricas/superadmin';
    });
  })();
</script>
</body>
</html>
