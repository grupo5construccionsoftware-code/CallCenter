<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
//hola
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historial de llamadas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Historial de llamadas</h1>
      <p>Consulta de registros con actualización manual</p>
    </div>
    <article class="card">
      <div class="form-grid">
        <div>
          <label for="buscar-cliente">Buscar por cliente</label>
          <input type="text" id="buscar-cliente" placeholder="Nombre del cliente...">
        </div>
        <div>
          <label for="fecha-inicio">Rango de fechas</label>
          <div class="date-range">
            <input type="date" id="fecha-inicio" aria-label="Fecha inicio">
            <span>a</span>
            <input type="date" id="fecha-fin" aria-label="Fecha fin">
          </div>
        </div>
        <div>
          <label for="buscar-motivo">Buscar por motivo</label>
          <select id="buscar-motivo">
            <option value="">Todos los motivos</option>
            <c:forEach var="motivo" items="${motivosDisponibles}">
              <option value="${motivo}">${motivo}</option>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="actions">
        <button type="button" id="btn-buscar"><i class="fas fa-search"></i> Buscar</button>
        <button type="button" class="secondary" id="btn-actualizar"><i class="fas fa-redo"></i> Actualizar historial</button>
      </div>
      <div class="table-wrap" id="tabla-historial-wrap" style="display:none;">
        <table>
          <thead>
          <tr>
            <th>Código llamada</th>
            <th>Cliente</th>
            <th>Teléfono</th>
            <th>Fecha</th>
            <th>Hora</th>
            <th>Motivo</th>
            <th>Agente</th>
          </tr>
          </thead>
          <tbody id="tabla-historial-body">
          <c:forEach var="llamada" items="${historialLlamadas}">
            <tr>
              <td>LL${llamada.id_llamada}</td>
              <td>${llamada.nombre_cliente}</td>
              <td>${llamada.telefono_cliente}</td>
              <td>${llamada.fecha_llamada}</td>
              <td>${llamada.hora}</td>
              <td>${llamada.motivo_tipo}</td>
              <td>Agente ${llamada.id_agente}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Historial de llamadas</div>
<script>
  (function () {
    const inputCliente    = document.getElementById('buscar-cliente');
    const inputFechaInicio = document.getElementById('fecha-inicio');
    const inputFechaFin   = document.getElementById('fecha-fin');
    const inputMotivo     = document.getElementById('buscar-motivo');
    const btnBuscar       = document.getElementById('btn-buscar');
    const btnActualizar   = document.getElementById('btn-actualizar');
    const tablaWrap       = document.getElementById('tabla-historial-wrap');
    const filas           = document.querySelectorAll('#tabla-historial-body tr');

    function norm(v) {
      return (v || '').toString().trim().toLowerCase()
              .normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    }
    function normFecha(v) {
      const t = (v || '').toString().trim();
      if (!t) return '';
      if (/^\d{4}-\d{2}-\d{2}$/.test(t)) return t;
      const p = t.split('/');
      if (p.length === 3) return p[2] + '-' + p[1].padStart(2,'0') + '-' + p[0].padStart(2,'0');
      return t;
    }

    function aplicarFiltro() {
      let fi = normFecha(inputFechaInicio.value);
      let ff = normFecha(inputFechaFin.value);
      if (fi && ff && fi > ff) { const tmp = fi; fi = ff; ff = tmp; }
      tablaWrap.style.display = '';
      filas.forEach(function (fila) {
        const ok =
                (!norm(inputCliente.value) || norm(fila.children[1].textContent).includes(norm(inputCliente.value))) &&
                (!fi || normFecha(fila.children[3].textContent) >= fi) &&
                (!ff || normFecha(fila.children[3].textContent) <= ff) &&
                (!norm(inputMotivo.value) || norm(fila.children[5].textContent).includes(norm(inputMotivo.value)));
        fila.style.display = ok ? '' : 'none';
      });
    }

    function resetearFiltros() {
      inputCliente.value = ''; inputFechaInicio.value = '';
      inputFechaFin.value = ''; inputMotivo.value = '';
      tablaWrap.style.display = 'none';
      filas.forEach(function (f) { f.style.display = ''; });
    }

    btnBuscar.addEventListener('click', aplicarFiltro);
    btnActualizar.addEventListener('click', resetearFiltros);
  })();
</script>
</body>
</html>

