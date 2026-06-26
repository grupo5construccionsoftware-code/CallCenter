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
      <p>Indicadores de tiempo de las llamadas registradas</p>
    </div>

    <div class="grid metric-grid">
      <article class="card metric">
        <strong><i class="fas fa-stopwatch"></i> Tiempo promedio</strong>
        <span class="value" id="kpi-duracion">-</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-hourglass-half"></i> Tiempo total</strong>
        <span class="value" id="kpi-tiempo-total">-</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-arrow-up"></i> Llamada más larga</strong>
        <span class="value" id="kpi-mas-larga">-</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-arrow-down"></i> Llamada más corta</strong>
        <span class="value" id="kpi-mas-corta">-</span>
      </article>
      <article class="card metric">
        <strong><i class="fas fa-clock"></i> Hora pico</strong>
        <span class="value" id="kpi-hora-pico">-</span>
      </article>
    </div>

    <div class="actions single align-center metric-actions">
      <button type="button" id="btn-actualizar">
        <i class="fas fa-redo"></i> Actualizar métricas
      </button>
    </div>

    <div class="charts-grid">
      <div class="chart-card">
        <h3><i class="fas fa-chart-bar"></i> Llamadas por hora</h3>
        <canvas id="chart-horas"></canvas>
      </div>
      <div class="chart-card">
        <h3><i class="fas fa-chart-line"></i> Tiempo acumulado por fecha</h3>
        <canvas id="chart-tiempo-fechas"></canvas>
      </div>
    </div>

  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas</div>

<script>
(function () {
  const PALETTE = ['#4f8ef7','#f76f4f','#4fcf70','#f7c94f','#a04ff7','#4fcfcf'];
  const ENDPOINT_METRICAS = '${endpointMetricas}';
  let chartHoras = null, chartTiempoFechas = null;

  function renderKpis(d) {
    document.getElementById('kpi-duracion').textContent     = d.duracionPromedio ?? '-';
    document.getElementById('kpi-tiempo-total').textContent = d.tiempoTotal ?? '-';
    document.getElementById('kpi-mas-larga').textContent    = d.llamadaMasLarga ?? '-';
    document.getElementById('kpi-mas-corta').textContent    = d.llamadaMasCorta ?? '-';
    document.getElementById('kpi-hora-pico').textContent    = d.horaPico ?? '-';
  }

  function renderHoras(horas) {
    const ctx = document.getElementById('chart-horas').getContext('2d');
    if (chartHoras) chartHoras.destroy();
    chartHoras = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: Object.keys(horas),
        datasets: [{ label: 'Llamadas', data: Object.values(horas), backgroundColor: PALETTE, borderRadius: 6 }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
        plugins: { legend: { display: false } }
      }
    });
  }

  function renderTiempoFechas(fechas) {
    const ctx = document.getElementById('chart-tiempo-fechas').getContext('2d');
    if (chartTiempoFechas) chartTiempoFechas.destroy();
    chartTiempoFechas = new Chart(ctx, {
      type: 'line',
      data: {
        labels: Object.keys(fechas),
        datasets: [{
          label: 'Minutos',
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
        if (d.llamadasPorHora && Object.keys(d.llamadasPorHora).length)
          renderHoras(d.llamadasPorHora);
        if (d.tiempoPorFecha && Object.keys(d.tiempoPorFecha).length)
          renderTiempoFechas(d.tiempoPorFecha);
      });
  }

  document.getElementById('btn-actualizar').addEventListener('click', cargarMetricas);
  cargarMetricas();
})();
</script>
</body>
</html>
