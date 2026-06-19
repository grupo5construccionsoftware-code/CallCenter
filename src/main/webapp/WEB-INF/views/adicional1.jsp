<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
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
          <label for="buscar-principal">${modoHistorialEmpresa ? 'Buscar por agente' : 'Buscar por cliente'}</label>
          <input type="text" id="buscar-principal" autocomplete="off" placeholder="${modoHistorialEmpresa ? 'Nombre o código del agente...' : 'Nombre del cliente...'}">
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
      <div class="notice-box" id="resumen-historial" style="display:none;"></div>
      <div class="table-wrap" id="tabla-historial-wrap" style="display:none;">
        <table>
          <thead>
          <tr>
            <th>Código llamada</th>
            <th>Cliente</th>
            <th>Teléfono</th>
            <th>Fecha</th>
            <th>Hora inicio</th>
            <th>Hora fin</th>
            <th>Duración</th>
            <th>Descripción tipo</th>
            <th>Motivo</th>
            <th>Agente</th>
            <th>Estado</th>
          </tr>
          </thead>
          <tbody id="tabla-historial-body">
          <c:forEach var="llamada" items="${historialLlamadas}">
            <c:set var="agenteFila" value="${agentesPorId[llamada.id_agente]}" />
            <tr data-cliente="${llamada.nombre_cliente}"
                data-agente="${agenteFila != null ? agenteFila.nombre_agente : ''} ${agenteFila != null ? agenteFila.usuario_agente : ''} ${llamada.id_agente} agente ${llamada.id_agente}"
                data-agente-nombre="${agenteFila != null ? agenteFila.nombre_agente : 'Agente'}"
                data-agente-codigo="${agenteFila != null ? agenteFila.usuario_agente : llamada.id_agente}">
              <td>${llamada.codigo_llamada}</td>
              <td>${llamada.nombre_cliente}</td>
              <td>${llamada.telefono_cliente}</td>
              <td>${llamada.fecha_llamada}</td>
              <td>${llamada.hora_inicio}</td>
              <td>${llamada.hora_fin}</td>
              <td>${llamada.duracion}</td>
              <td>${llamada.descripcion_tipo}</td>
              <td>${llamada.motivo_tipo}</td>
              <td>${agenteFila != null ? agenteFila.nombre_agente : 'Agente'} (${agenteFila != null ? agenteFila.usuario_agente : llamada.id_agente})</td>
              <td>${llamada.estado_llamada}</td>
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
    const modoEmpresa     = ${modoHistorialEmpresa ? 'true' : 'false'};
    const inputPrincipal  = document.getElementById('buscar-principal');
    const inputFechaInicio = document.getElementById('fecha-inicio');
    const inputFechaFin   = document.getElementById('fecha-fin');
    const inputMotivo     = document.getElementById('buscar-motivo');
    const btnBuscar       = document.getElementById('btn-buscar');
    const btnActualizar   = document.getElementById('btn-actualizar');
    const tablaWrap       = document.getElementById('tabla-historial-wrap');
    const resumen         = document.getElementById('resumen-historial');
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
      let visibles = 0;
      const conteoAgentes = {};
      const textoPrincipal = norm(inputPrincipal.value);
      filas.forEach(function (fila) {
        const campoPrincipal = modoEmpresa ? fila.dataset.agente : fila.dataset.cliente;
        const ok =
                (!textoPrincipal || norm(campoPrincipal).includes(textoPrincipal)) &&
                (!fi || normFecha(fila.children[3].textContent) >= fi) &&
                (!ff || normFecha(fila.children[3].textContent) <= ff) &&
                (!norm(inputMotivo.value) || norm(fila.children[8].textContent).includes(norm(inputMotivo.value)));
        fila.style.display = ok ? '' : 'none';
        if (ok) {
          visibles++;
          const claveAgente = fila.dataset.agenteNombre + ' (' + fila.dataset.agenteCodigo + ')';
          conteoAgentes[claveAgente] = (conteoAgentes[claveAgente] || 0) + 1;
        }
      });
      actualizarResumen(visibles, conteoAgentes);
    }

    function actualizarResumen(total, conteoAgentes) {
      resumen.style.display = '';
      if (modoEmpresa && norm(inputPrincipal.value)) {
        const detalle = Object.keys(conteoAgentes)
                .map(function (agente) { return agente + ' realizó ' + conteoAgentes[agente] + ' registro(s) de llamada'; })
                .join('<br>');
        resumen.innerHTML = '<strong>Resultado:</strong> ' + (detalle || 'No se encontraron llamadas para ese agente.') + '. Total: ' + total + ' llamada(s).';
        return;
      }
      resumen.innerHTML = '<strong>Resultado:</strong> Total: ' + total + ' llamada(s).';
    }

    function resetearFiltros() {
      inputPrincipal.value = ''; inputFechaInicio.value = '';
      inputFechaFin.value = ''; inputMotivo.value = '';
      tablaWrap.style.display = 'none';
      resumen.style.display = 'none';
      resumen.innerHTML = '';
      filas.forEach(function (f) { f.style.display = ''; });
    }

    btnBuscar.addEventListener('click', aplicarFiltro);
    btnActualizar.addEventListener('click', resetearFiltros);
  })();
</script>
</body>
</html>

