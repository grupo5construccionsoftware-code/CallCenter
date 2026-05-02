<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Historial de llamadas del sistema call center.">
  <title>Historial de llamadas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<header class="topbar">
  <div class="topbar-inner">
    <div class="brand">
      <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
    </div>
    <nav class="menu" aria-label="Navegación privada">
      <a href="/dashboard">Inicio</a>
      <a href="/gestion">Gestión</a>
      <a href="/llamadas">Llamadas</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/usuarios">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1" class="active">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
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
          <input type="text" id="buscar-cliente" name="buscar_cliente" placeholder="Nombre del cliente...">
        </div>
        <div>
          <label for="fecha-llamada">Fecha de llamada</label>
          <input type="date" id="fecha-llamada" name="fecha_llamada">
        </div>
        <div>
          <label for="buscar-motivo">Buscar por motivo</label>
          <select id="buscar-motivo" name="buscar_motivo">
            <option value="">Todos los motivos</option>
            <c:forEach var="motivo" items="${motivosDisponibles}">
              <option value="${motivo}">${motivo}</option>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="actions">
        <button type="button" id="btn-buscar">
          <i class="fas fa-search"></i> Buscar
        </button>
        <button type="button" class="secondary" id="btn-actualizar">
          <i class="fas fa-redo"></i> Actualizar historial
        </button>
      </div>
      <div class="table-wrap" id="tabla-historial-wrap" style="display:none;">
        <table>
          <thead>
          <tr>
            <th>Código llamada</th>
            <th>Cliente</th>
            <th>Teléfono cliente</th>
            <th>Fecha llamada</th>
            <th>Hora</th>
            <th>Motivo</th>
            <th>Descripción motivo</th>
            <th>Agente</th>
          </tr>
          </thead>
          <tbody id="tabla-historial-body">
          <c:forEach var="llamada" items="${historialLlamadas}">
            <c:set var="tipificacion" value="${tipificacionesPorLlamada[llamada.id_llamada]}" />
            <tr>
              <td>LL${llamada.id_llamada}</td>
              <td>${llamada.nombre_cliente}</td>
              <td>${llamada.telefono_cliente}</td>
              <td>${llamada.fecha_llamada}</td>
              <td>${llamada.hora}</td>
              <td>${tipificacion != null ? tipificacion.motivo_tipo : ""}</td>
              <td>${tipificacion != null ? tipificacion.descripcion_tipo : ""}</td>
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
    const inputCliente = document.getElementById('buscar-cliente');
    const inputFecha = document.getElementById('fecha-llamada');
    const inputMotivo = document.getElementById('buscar-motivo');
    const btnBuscar = document.getElementById('btn-buscar');
    const btnActualizar = document.getElementById('btn-actualizar');
    const filas = document.querySelectorAll('#tabla-historial-body tr');

    function normalizarTexto(valor) {
      return (valor || '')
              .toString()
              .trim()
              .toLowerCase()
              .normalize('NFD')
              .replace(/[\u0300-\u036f]/g, '');
    }

    function normalizarFecha(valor) {
      const texto = (valor || '').toString().trim();
      if (!texto) {
        return '';
      }

      if (/^\d{4}-\d{2}-\d{2}$/.test(texto)) {
        return texto;
      }

      const partes = texto.split('/');
      if (partes.length === 3) {
        const dd = partes[0].padStart(2, '0');
        const mm = partes[1].padStart(2, '0');
        const yyyy = partes[2];
        return `${yyyy}-${mm}-${dd}`;
      }

      return texto;
    }

    function aplicarFiltro() {
      const clienteFiltro = normalizarTexto(inputCliente.value);
      const fechaFiltro = normalizarFecha(inputFecha.value);
      const motivoFiltro = normalizarTexto(inputMotivo.value);
      const tablaWrap = document.getElementById('tabla-historial-wrap');
      tablaWrap.style.display = '';

      filas.forEach(function (fila) {
        const cliente = normalizarTexto(fila.children[1].textContent);
        const fecha = normalizarFecha(fila.children[3].textContent);
        const motivo = normalizarTexto(fila.children[5].textContent);

        const coincideCliente = !clienteFiltro || cliente.includes(clienteFiltro);
        const coincideFecha = !fechaFiltro || fecha === fechaFiltro;
        const coincideMotivo = !motivoFiltro || motivo.includes(motivoFiltro);

        fila.style.display = (coincideCliente && coincideFecha && coincideMotivo) ? '' : 'none';
      });
    }

    function resetearFiltros() {
      inputCliente.value = '';
      inputFecha.value = '';
      inputMotivo.value = '';
      const tablaWrap = document.getElementById('tabla-historial-wrap');
      tablaWrap.style.display = 'none';
      filas.forEach(function (fila) {
        fila.style.display = '';
      });
    }

    btnBuscar.addEventListener('click', aplicarFiltro);
    btnActualizar.addEventListener('click', resetearFiltros);
  })();
</script>
</body>
</html>
