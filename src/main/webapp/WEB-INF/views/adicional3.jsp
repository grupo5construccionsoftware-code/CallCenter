<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Editar llamada del sistema call center.">
  <title>Editar Llamada | Sistema Call Center</title>
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
      <a href="/llamadas" class="active">Llamadas</a>
      <a href="/tipificaciones">Tipificaciones</a>
      <a href="/usuarios">Usuarios</a>
      <a href="/metricas">Métricas</a>
      <a href="/adicional1">Historial de llamadas</a>
      <a href="/main" class="session">Salir</a>
    </nav>
  </div>
</header>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Editar llamada</h1>
      <p>Modifica los datos de una llamada registrada</p>
    </div>
    <article class="card">
      <form:form action="/llamada/actualizar" method="post" modelAttribute="llamada">
        <form:hidden path="id_llamada"/>
        <form:hidden path="id_agente"/>
        <form:hidden path="fecha_llamada"/>
        <div class="form-grid">
          <div>
            <label>Código de llamada</label>
            <input type="text" value="${llamada.id_llamada}" readonly>
          </div>
          <div>
            <label for="nombre_cliente">Nombre del cliente</label>
            <form:input path="nombre_cliente" id="nombre_cliente" placeholder="Ej: Alex Pérez" required="required"/>
          </div>
          <div>
            <label for="telefono_cliente">Teléfono del cliente</label>
            <form:input path="telefono_cliente" id="telefono_cliente" placeholder="Ej: 123456789" required="required" pattern="[0-9]{9}" maxlength="9" title="Ingrese exactamente 9 dígitos" oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 9);"/>
          </div>
          <div>
            <label for="id_tipo">Tipificación</label>
            <form:select path="id_tipo" id="id_tipo" required="required">
              <option value="" disabled>Selecciona una tipificación</option>
              <c:forEach items="${tiposLlamada}" var="tipo">
                <option value="${tipo.id_tipo}">${tipo.motivo_tipo}</option>
              </c:forEach>
            </form:select>
          </div>
          <div style="display:none;">
            <form:hidden path="hora_inicio" id="hora_inicio"/>
            <form:hidden path="hora_fin" id="hora_fin"/>
            <form:hidden path="duracion" id="duracion"/>
          </div>
          <div>
            <label for="descripcion_tipo">Descripción tipo</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo" placeholder="Ej: Detalle de la llamada"/>
          </div>
          <div>
            <label for="estado_llamada">Estado llamada</label>
            <form:select path="estado_llamada" id="estado_llamada">
              <option value="Activo">Activo</option>
              <option value="Inactivo">Inactivo</option>
              <option value="Eliminado">Eliminado</option>
            </form:select>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Actualizar</button>
          <a class="button secondary" href="/llamadas"><i class="fas fa-times"></i> Cancelar</a>
        </div>
      </form:form>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Editar Llamada</div>
<script>
  const formLlamada = document.querySelector('form[action="/llamada/actualizar"]');
  const horaInicio = document.getElementById('hora_inicio');
  const horaFin = document.getElementById('hora_fin');
  const duracion = document.getElementById('duracion');
  const estadoLlamada = document.getElementById('estado_llamada');

  function horaActual() {
    const ahora = new Date();
    return [
      String(ahora.getHours()).padStart(2, '0'),
      String(ahora.getMinutes()).padStart(2, '0'),
      String(ahora.getSeconds()).padStart(2, '0')
    ].join(':');
  }

  function segundosDesdeMedianoche(hora) {
    const partes = hora.split(':').map(Number);
    return (partes[0] * 3600) + (partes[1] * 60) + (partes[2] || 0);
  }

  function calcularDuracion() {
    if (!horaInicio.value || !horaFin.value) return;
    let segundos = segundosDesdeMedianoche(horaFin.value) - segundosDesdeMedianoche(horaInicio.value);
    if (segundos < 0) segundos += 24 * 3600;

    const horas = Math.floor(segundos / 3600);
    const minutos = Math.floor((segundos % 3600) / 60);
    const segundosRestantes = segundos % 60;
    const partes = [];

    if (horas > 0) partes.push(horas + ' h');
    if (minutos > 0) partes.push(minutos + ' min');
    if (segundosRestantes > 0 || partes.length === 0) partes.push(segundosRestantes + ' seg');
    duracion.value = partes.join(' ');
  }

  function limpiarFinalizacion() {
    horaFin.value = '';
    duracion.value = '';
  }

  formLlamada.addEventListener('submit', function () {
    if (!horaFin.value) {
      horaFin.value = horaActual();
    }
    if (horaInicio.value && horaFin.value) {
      calcularDuracion();
    }
  });
</script>
</body>
</html>
