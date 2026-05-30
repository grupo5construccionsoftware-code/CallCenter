<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Llamadas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Registro de llamadas</h1>
      <p>Registre las llamadas con los datos solicitados</p>
    </div>
    <article class="card">
      <div class="actions single align-center" id="acciones-inicio-llamada">
        <button type="button" id="btn-iniciar-llamada"><i class="fas fa-phone"></i> Registrar llamada</button>
        <a class="button secondary" href="/llamada/list"><i class="fas fa-eye"></i> Ver llamadas</a>
      </div>
      <form:form action="/llamada/crear" method="post" modelAttribute="llamada" id="form-llamada" style="display:none;">
        <div class="form-grid">
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
              <option value="" disabled selected>Selecciona una tipificación</option>
              <c:forEach items="${tiposLlamada}" var="tipo">
                <option value="${tipo.id_tipo}">${tipo.motivo_tipo}</option>
              </c:forEach>
            </form:select>
          </div>
          <div style="display:none;">
            <form:hidden path="hora_inicio" id="hora_inicio"/>
            <form:hidden path="hora_fin" id="hora_fin"/>
            <form:hidden path="duracion" id="duracion"/>
            <form:hidden path="estado_llamada" id="estado_llamada"/>
          </div>
          <div>
            <label for="descripcion_tipo">Descripción tipo</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo" placeholder="Ej: Detalle de la llamada"/>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Registrar</button>
          <button type="button" class="secondary" id="btn-cancelar-llamada"><i class="fas fa-times"></i> Cancelar</button>
          <a class="button secondary" href="/llamada/list"><i class="fas fa-eye"></i> Ver llamadas</a>
        </div>
      </form:form>
      <c:if test="${llamadaCreada != null}">
        <div class="notice-box">
          <h3><i class="fas fa-check-circle" style="color: green;"></i> Llamada registrada exitosamente</h3>
          <p><strong>Código de llamada:</strong> ${llamadaCreada.id_llamada}</p>
          <p><strong>Cliente:</strong> ${llamadaCreada.nombre_cliente}</p>
          <p><strong>Fecha:</strong> ${llamadaCreada.fecha_llamada}</p>
          <p>Recuerda tipificar esta llamada con el código mostrado.</p>
          <div class="actions" style="margin-top:12px;">
            <a class="button" href="/llamadas"><i class="fas fa-check"></i> Aceptar</a>
          </div>
        </div>
      </c:if>
      <c:if test="${mostrarTabla}">
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>ID llamada</th>
                <th>Cliente</th>
                <th>Teléfono cliente</th>
                <th>Tipificacion</th>
                <th>Fecha</th>
                <th>Duración</th>
                <th>Descripción tipo</th>
                <th>Agente</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${llamadas}" var="llamada">
                <tr>
                  <td>${llamada.id_llamada}</td>
                  <td>${llamada.nombre_cliente}</td>
                  <td>${llamada.telefono_cliente}</td>
                  <td>${llamada.motivo_tipo}</td>
                  <td>${llamada.fecha_llamada}</td>
                  <td>${llamada.duracion}</td>
                  <td>${llamada.descripcion_tipo}</td>
                  <td>${llamada.id_agente}</td>
                  <td>${llamada.estado_llamada}</td>
                  <td>
                    <a class="button" href="/llamada/editar?id=${llamada.id_llamada}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/llamada/eliminar?id=${llamada.id_llamada}">
                      <i class="fas fa-trash"></i> Eliminar
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>
    </article>
  </section>
</div>
<div class="footer">Sistema de Call Center - Registro de llamadas</div>
<script>
  const formLlamada = document.querySelector('form[action="/llamada/crear"]');
  const accionesInicioLlamada = document.getElementById('acciones-inicio-llamada');
  const btnIniciarLlamada = document.getElementById('btn-iniciar-llamada');
  const btnCancelarLlamada = document.getElementById('btn-cancelar-llamada');
  const nombreCliente = document.getElementById('nombre_cliente');
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

  btnIniciarLlamada.addEventListener('click', function () {
    horaInicio.value = horaActual();
    horaFin.value = '';
    duracion.value = '';
    estadoLlamada.value = 'Activo';
    accionesInicioLlamada.style.display = 'none';
    formLlamada.style.display = '';
    nombreCliente.focus();
  });

  btnCancelarLlamada.addEventListener('click', function () {
    formLlamada.reset();
    horaInicio.value = '';
    horaFin.value = '';
    duracion.value = '';
    estadoLlamada.value = '';
    formLlamada.style.display = 'none';
    accionesInicioLlamada.style.display = '';
  });

  formLlamada.addEventListener('submit', function () {
    if (!horaInicio.value) {
      horaInicio.value = horaActual();
    }
    estadoLlamada.value = 'Activo';
    horaFin.value = horaActual();
    calcularDuracion();
  });
</script>
</body>
</html>

