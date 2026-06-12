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
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Métricas</h1>
      <p>Indicadores de los servicios realizados</p>
    </div>

    <div class="grid">
      <article class="card metric">
        <strong><i class="fas fa-phone"></i> Llamadas atendidas</strong>
        <span class="value" id="kpi-total">—</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-users"></i> Clientes frecuentes</strong>
        <span class="value" id="kpi-frecuentes">—</span>
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

    <div class="actions single align-center metric-actions">
      <button type="button" id="btn-actualizar">
        <i class="fas fa-redo"></i> Actualizar métricas
      </button>
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
    </div>

  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas</div>

<script>
(function () {
  const PALETTE = ['#4f8ef7','#f76f4f','#4fcf70','#f7c94f','#a04ff7','#4fcfcf'];
  const ENDPOINT_METRICAS = '${endpointMetricas}';
  let chartMotivos = null, chartFechas = null;

  function renderKpis(d) {
    document.getElementById('kpi-total').textContent        = d.totalLlamadas ?? 0;
    document.getElementById('kpi-frecuentes').textContent   = d.clientesFrecuentes ?? 0;
    document.getElementById('kpi-duracion').textContent     = d.duracionPromedio ?? '-';
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
          label: 'Llamadas',
          data: Object.values(fechas),
          fill: true, tension: 0.35,
          borderColor: '#4f8ef7',
          backgroundColor: 'rgba(79,142,247,.15)',
          pointBackgroundColor: '#4f8ef7',
          pointRadius: 5
        }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
        plugins: { legend: { display: false } }
      }
    });
  }

  function cargarMetricas() {
    fetch(ENDPOINT_METRICAS || '/api/metricas/agente')
      .then(r => r.json())
      .then(d => {
        renderKpis(d);
        if (d.llamadasPorMotivo && Object.keys(d.llamadasPorMotivo).length)
          renderMotivos(d.llamadasPorMotivo);
        if (d.llamadasPorFecha && Object.keys(d.llamadasPorFecha).length)
          renderFechas(d.llamadasPorFecha);
      });
  }

  document.getElementById('btn-actualizar').addEventListener('click', cargarMetricas);
  cargarMetricas();
})();
</script>
</body>
</html>
