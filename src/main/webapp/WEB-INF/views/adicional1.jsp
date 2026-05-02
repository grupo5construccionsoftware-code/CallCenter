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
          <label for="filtrar-motivo">Filtrar por motivo</label>
          <select id="filtrar-motivo" name="filtrar_motivo">
            <option value="">Todos</option>
            <option value="reclamo">Reclamo</option>
            <option value="consulta">Consulta</option>
            <option value="venta">Venta</option>
            <option value="soporte">Soporte</option>
          </select>
        </div>
        <div>
          <label for="fecha-llamada">Fecha de llamada</label>
          <input type="date" id="fecha-llamada" name="fecha_llamada">
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
              <th>Motivo</th>
              <th>Fecha llamada</th>
              <th>Hora</th>
              <th>Agente</th>
            </tr>
          </thead>
          <tbody id="tabla-historial-body">
          <c:forEach var="llamada" items="${historialLlamadas}">
            <tr>
              <td>LL${llamada.idLlamada}</td>
              <td>${llamada.nombreCliente}</td>
              <td>${llamada.telefonoCliente}</td>
              <td>${llamada.motivoTipo}</td>
              <td>${llamada.fechaLlamada}</td>
              <td>${llamada.hora}</td>
              <td>${llamada.nombreAgente}</td>
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
    const selectMotivo = document.getElementById('filtrar-motivo');
    const inputFecha = document.getElementById('fecha-llamada');
    const btnBuscar = document.getElementById('btn-buscar');
    const btnActualizar = document.getElementById('btn-actualizar');
    const filas = document.querySelectorAll('#tabla-historial-body tr');

    function aplicarFiltro() {
      const clienteFiltro = inputCliente.value.trim().toLowerCase();
      const motivoFiltro = selectMotivo.value.trim().toLowerCase();
      const fechaFiltro = inputFecha.value;
      const tablaWrap = document.getElementById('tabla-historial-wrap');
      tablaWrap.style.display = '';

      filas.forEach(function (fila) {
        const cliente = fila.children[1].textContent.trim().toLowerCase();
        const motivo = fila.children[3].textContent.trim().toLowerCase();
        const fecha = fila.children[4].textContent.trim();

        const coincideCliente = !clienteFiltro || cliente.includes(clienteFiltro);
        const coincideMotivo = !motivoFiltro || motivo === motivoFiltro;
        const coincideFecha = !fechaFiltro || fecha === fechaFiltro;

        fila.style.display = (coincideCliente && coincideMotivo && coincideFecha) ? '' : 'none';
      });
    }

    function resetearFiltros() {
      inputCliente.value = '';
      selectMotivo.value = '';
      inputFecha.value = '';
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
