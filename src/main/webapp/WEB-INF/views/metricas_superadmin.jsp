<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Métricas SuperAdmin | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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

    <article class="card">
      <div class="form-grid">
        <div>
          <label for="filtro-empresa">Filtrar por empresa</label>
          <select id="filtro-empresa" name="id_empresa">
            <option value="">Todas las empresas</option>
            <c:forEach var="empresa" items="${empresas}">
              <option value="${empresa.id_empresa}"
                <c:if test="${empresa.id_empresa == empresaSeleccionada}">selected</c:if>>
                ${empresa.nombre_empresa}
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

    <div class="grid metric-grid">
      <article class="card metric">
        <strong><i class="fas fa-building"></i> Empresas registradas</strong>
        <span class="value" id="kpi-empresas">—</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-phone"></i> Llamadas atendidas</strong>
        <span class="value" id="kpi-llamadas">—</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-users"></i> Agentes activos</strong>
        <span class="value" id="kpi-agentes">—</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-stopwatch"></i> Tiempo promedio</strong>
        <span class="value" id="kpi-duracion">—</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-tags"></i> Tipificación más común</strong>
        <span class="value" id="kpi-tipificacion">—</span>
      </article>
    </div>

    <div class="charts-grid">
      <div class="chart-card">
        <h3><i class="fas fa-chart-pie"></i> Distribución por tipificación</h3>
        <canvas id="chart-motivos"></canvas>
      </div>
      <div class="chart-card">
        <h3><i class="fas fa-chart-line"></i> Llamadas por fecha</h3>
        <canvas id="chart-fechas"></canvas>
      </div>
      <div class="chart-card full">
        <h3><i class="fas fa-chart-bar"></i> Llamadas por empresa</h3>
        <canvas id="chart-empresas"></canvas>
      </div>
    </div>

  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas SuperAdmin</div>

<script>
(function () {
  const PALETTE = ['#4f8ef7','#f76f4f','#4fcf70','#f7c94f','#a04ff7','#4fcfcf','#f74fa8'];
  let chartMotivos = null, chartFechas = null, chartEmpresas = null;
  let empresaActual = '${empresaSeleccionada}';

  function renderKpis(d) {
    if (d.totalEmpresas != null) document.getElementById('kpi-empresas').textContent = d.totalEmpresas;
    if (d.totalAgentes  != null) document.getElementById('kpi-agentes').textContent  = d.totalAgentes;
    document.getElementById('kpi-llamadas').textContent    = d.totalLlamadas ?? 0;
    document.getElementById('kpi-duracion').textContent    = d.duracionPromedio ?? '-';
    document.getElementById('kpi-tipificacion').textContent = d.tipificacionComun ?? '-';
  }

  function renderMotivos(motivos) {
    const ctx = document.getElementById('chart-motivos').getContext('2d');
    if (chartMotivos) chartMotivos.destroy();
    chartMotivos = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: Object.keys(motivos),
        datasets: [{ data: Object.values(motivos), backgroundColor: PALETTE, borderWidth: 2 }]
      },
      options: {
        responsive: true,
        plugins: { legend: { position: 'bottom', labels: { padding: 14, font: { size: 12 } } } }
      }
    });
  }

  function renderFechas(fechas) {
    const ctx = document.getElementById('chart-fechas').getContext('2d');
    if (chartFechas) chartFechas.destroy();
    chartFechas = new Chart(ctx, {
      type: 'line',
      data: {
        labels: Object.keys(fechas),
        datasets: [{
          label: 'Llamadas', data: Object.values(fechas),
          fill: true, tension: 0.35,
          borderColor: '#4f8ef7', backgroundColor: 'rgba(79,142,247,.15)',
          pointBackgroundColor: '#4f8ef7', pointRadius: 5
        }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
        plugins: { legend: { display: false } }
      }
    });
  }

  function renderEmpresas(lista) {
    if (!lista || !lista.length) return;
    const ctx = document.getElementById('chart-empresas').getContext('2d');
    if (chartEmpresas) chartEmpresas.destroy();
    chartEmpresas = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: lista.map(e => e.nombre),
        datasets: [{
          label: 'Llamadas', data: lista.map(e => e.totalLlamadas),
          backgroundColor: PALETTE, borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
        plugins: { legend: { display: false } }
      }
    });
  }

  function cargarMetricas(idEmpresa) {
    const url = '/api/metricas/superadmin' +
                (idEmpresa ? '?id_empresa=' + encodeURIComponent(idEmpresa) : '');
    fetch(url)
      .then(r => r.json())
      .then(d => {
        renderKpis(d);
        if (d.llamadasPorMotivo && Object.keys(d.llamadasPorMotivo).length)
          renderMotivos(d.llamadasPorMotivo);
        if (d.llamadasPorFecha && Object.keys(d.llamadasPorFecha).length)
          renderFechas(d.llamadasPorFecha);
        if (d.llamadasPorEmpresa)
          renderEmpresas(d.llamadasPorEmpresa);
      });
  }

  document.getElementById('btn-filtrar').addEventListener('click', function () {
    empresaActual = document.getElementById('filtro-empresa').value;
    cargarMetricas(empresaActual);
  });

  document.getElementById('btn-limpiar').addEventListener('click', function () {
    document.getElementById('filtro-empresa').value = '';
    empresaActual = '';
    cargarMetricas('');
  });

  cargarMetricas(empresaActual);
})();
</script>
</body>
</html>