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

    <!-- ANTES: 2 graficas. AHORA: 5 series de tiempo -->
    <div class="charts-grid">

      <div class="chart-card">
        <h3><i class="fas fa-chart-line"></i> Llamadas por día</h3>
        <canvas id="chart-llamadas-fecha"></canvas>
      </div>

      <div class="chart-card">
        <h3><i class="fas fa-chart-line"></i> Duración promedio por día (min)</h3>
        <canvas id="chart-promedio-fecha"></canvas>
      </div>

      <div class="chart-card">
        <h3><i class="fas fa-chart-bar"></i> Llamadas por hora (08:00–22:00)</h3>
        <canvas id="chart-llamadas-hora"></canvas>
      </div>

      <div class="chart-card">
        <h3><i class="fas fa-chart-bar"></i> Duración promedio por hora (min)</h3>
        <canvas id="chart-promedio-hora"></canvas>
      </div>

      <div class="chart-card full">
              <h3><i class="fas fa-tags"></i> Tipificaciones por período</h3>
              <canvas id="chart-dia-semana"></canvas>
            </div>

    </div>

  </section>
</div>
<div class="footer">Sistema de Call Center - Métricas</div>

<script>
(function () {
  const PALETTE = ['#4f8ef7','#f76f4f','#4fcf70','#f7c94f','#a04ff7','#4fcfcf'];
  const ENDPOINT_METRICAS = '${endpointMetricas}';
  const g = {};

  function renderKpis(d) {
    document.getElementById('kpi-duracion').textContent     = d.duracionPromedio ?? '-';
    document.getElementById('kpi-tiempo-total').textContent = d.tiempoTotal ?? '-';
    document.getElementById('kpi-mas-larga').textContent    = d.llamadaMasLarga ?? '-';
    document.getElementById('kpi-mas-corta').textContent    = d.llamadaMasCorta ?? '-';
    document.getElementById('kpi-hora-pico').textContent    = d.horaPico ?? '-';
  }

       function segundosAFormato(seg) {
        seg = Math.round(seg);
        const m = Math.floor(seg / 60);
        const s = seg % 60;
        return m > 0 ? (m + 'm ' + s + 's') : (s + 's');
      }

      function linea(id, labels, datos, label, color, formatoSegundos) {
        const ctx = document.getElementById(id).getContext('2d');
        if (g[id]) g[id].destroy();
        const opciones = {
          responsive: true,
          scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
          plugins: { legend: { display: false } }
        };
        if (formatoSegundos) {
          opciones.scales.y.ticks.callback = (valor) => segundosAFormato(valor);
          opciones.plugins.tooltip = { callbacks: { label: (c) => segundosAFormato(c.parsed.y) } };
        }
        g[id] = new Chart(ctx, {
          type: 'line',
          data: {
            labels: labels,
            datasets: [{
              label: label, data: datos,
              fill: true, tension: 0.35,
              borderColor: color,
              backgroundColor: color + '26',
              pointBackgroundColor: color,
              pointRadius: 5
            }]
          },
          options: opciones
        });
      }

   function barras(id, labels, datos, label, colores, formatoSegundos) {
       const ctx = document.getElementById(id).getContext('2d');
       if (g[id]) g[id].destroy();
       const opciones = {
         responsive: true,
         scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
         plugins: { legend: { display: false } }
       };
       if (formatoSegundos) {
         opciones.scales.y.ticks.callback = (valor) => segundosAFormato(valor);
         opciones.plugins.tooltip = { callbacks: { label: (c) => segundosAFormato(c.parsed.y) } };
       }
       g[id] = new Chart(ctx, {
         type: 'bar',
         data: {
           labels: labels,
           datasets: [{ label: label, data: datos, backgroundColor: colores, borderRadius: 6 }]
         },
         options: opciones
       });
     }

  function cargarMetricas() {
    fetch(ENDPOINT_METRICAS || '/api/metricas/agente')
      .then(r => r.json())
      .then(d => {
        renderKpis(d);

        if (d.llamadasPorFecha && Object.keys(d.llamadasPorFecha).length)
          linea('chart-llamadas-fecha', Object.keys(d.llamadasPorFecha), Object.values(d.llamadasPorFecha), 'Llamadas', '#4f8ef7');

       if (d.promedioPorFecha && Object.keys(d.promedioPorFecha).length)
         linea('chart-promedio-fecha', Object.keys(d.promedioPorFecha), Object.values(d.promedioPorFecha), 'Duración', '#4fcf70', true);

        if (d.llamadasPorHora && Object.keys(d.llamadasPorHora).length)
          barras('chart-llamadas-hora', Object.keys(d.llamadasPorHora), Object.values(d.llamadasPorHora), 'Llamadas', PALETTE);

        if (d.promedioPorHora && Object.keys(d.promedioPorHora).length)
          barras('chart-promedio-hora', Object.keys(d.promedioPorHora), Object.values(d.promedioPorHora), 'Duración', '#ff8a00', true);

        if (d.llamadasPorTipificacion && Object.keys(d.llamadasPorTipificacion).length)
                  barras('chart-dia-semana', Object.keys(d.llamadasPorTipificacion), Object.values(d.llamadasPorTipificacion), 'Llamadas', PALETTE);
      });
  }

  document.getElementById('btn-actualizar').addEventListener('click', cargarMetricas);
  cargarMetricas();
})();
</script>
</body>
</html>