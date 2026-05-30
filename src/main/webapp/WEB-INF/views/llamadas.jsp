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

    <%-- Formulario de edición inline --%>
    <c:if test="${llamadaEditar != null}">
      <article class="card">
        <div class="section-title">
          <h2><i class="fas fa-edit"></i> Editando llamada: LL${llamadaEditar.id_llamada}</h2>
        </div>
        <form action="/llamada/actualizar" method="post">
          <input type="hidden" name="id_llamada"    value="${llamadaEditar.id_llamada}">
          <input type="hidden" name="fecha_llamada" value="${llamadaEditar.fecha_llamada}">
          <input type="hidden" name="hora"          value="${llamadaEditar.hora}">
          <input type="hidden" name="duracion"      value="${llamadaEditar.duracion}">
          <input type="hidden" name="id_agente"     value="${llamadaEditar.id_agente}">
          <div class="form-grid">
            <div>
              <label for="edit-nombre">Nombre del cliente</label>
              <input type="text" id="edit-nombre" name="nombre_cliente"
                     value="${llamadaEditar.nombre_cliente}" required>
            </div>
            <div>
              <label for="edit-telefono">Teléfono del cliente</label>
              <input type="text" id="edit-telefono" name="telefono_cliente"
                     value="${llamadaEditar.telefono_cliente}" required
                     pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
            </div>
            <div>
              <label for="edit-tipo">Tipificación</label>
              <select id="edit-tipo" name="id_tipo">
                <c:forEach items="${tiposLlamada}" var="tipo">
                  <option value="${tipo.id_tipo}"
                    ${llamadaEditar.id_tipo == tipo.id_tipo ? 'selected' : ''}>
                      ${tipo.motivo_tipo}
                  </option>
                </c:forEach>
              </select>
            </div>
            <div>
              <label for="edit-descripcion">Descripción</label>
              <input type="text" id="edit-descripcion" name="descripcion_llamada"
                     value="${llamadaEditar.descripcion_llamada}"
                     placeholder="Ej: El cliente consulta sobre su factura">
            </div>
            <div>
              <label for="edit-estado">Estado</label>
              <select id="edit-estado" name="estado">
                <option value="activo"     ${llamadaEditar.estado == 'activo'     ? 'selected' : ''}>Activo</option>
                <option value="suspendido" ${llamadaEditar.estado == 'suspendido' ? 'selected' : ''}>Suspendido</option>
                <option value="borrado"    ${llamadaEditar.estado == 'borrado'    ? 'selected' : ''}>Borrado</option>
              </select>
            </div>
          </div>
          <div class="actions">
            <button type="submit"><i class="fas fa-save"></i> Guardar cambios</button>
            <a class="button secondary" href="/llamada/list">
              <i class="fas fa-times"></i> Cancelar
            </a>
          </div>
        </form>
      </article>
    </c:if>

    <article class="card">

      <%-- Botones principales --%>
      <c:if test="${not mostrarFormulario and llamadaEditar == null}">
        <div class="actions">
          <a class="button" href="/llamada/comenzar">
            <i class="fas fa-phone"></i> Comenzar registro
          </a>
          <a class="button secondary" href="/llamada/list">
            <i class="fas fa-eye"></i> Ver llamadas
          </a>
        </div>
      </c:if>

      <%-- Formulario nuevo registro --%>
      <c:if test="${mostrarFormulario}">
        <div class="notice-box" style="background:#e8f4fd; border-left:4px solid var(--color-primario); margin-bottom:14px;">
          <p><i class="fas fa-clock"></i> <strong>Registro iniciado a las ${horaInicio}</strong> — Complete los datos y presione "Finalizar registro".</p>
        </div>
        <form:form action="/llamada/crear" method="post" modelAttribute="llamada">
          <div class="form-grid">
            <div>
              <label for="nombre_cliente">Nombre del cliente</label>
              <form:input path="nombre_cliente" id="nombre_cliente"
                          placeholder="Ej: Alex Pérez" required="required"/>
            </div>
            <div>
              <label for="telefono_cliente">Teléfono del cliente</label>
              <form:input path="telefono_cliente" id="telefono_cliente"
                          placeholder="Ej: 123456789" required="required"
                          pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
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
            <div>
              <label for="descripcion_llamada">Descripción</label>
              <form:input path="descripcion_llamada" id="descripcion_llamada"
                          placeholder="Ej: El cliente consulta sobre su factura"/>
            </div>
          </div>
          <div class="actions">
            <button type="submit"><i class="fas fa-stop-circle"></i> Finalizar registro</button>
            <a class="button secondary" href="/llamada/list">
              <i class="fas fa-eye"></i> Ver llamadas
            </a>
          </div>
        </form:form>
      </c:if>

      <%-- Confirmación tras registrar --%>
      <c:if test="${llamadaCreada != null}">
        <div class="notice-box">
          <h3><i class="fas fa-check-circle"></i> Llamada registrada exitosamente</h3>
          <p><strong>Código:</strong> LL${llamadaCreada.id_llamada}</p>
          <p><strong>Cliente:</strong> ${llamadaCreada.nombre_cliente}</p>
          <p><strong>Fecha:</strong> ${llamadaCreada.fecha_llamada}</p>
          <p><strong>Hora:</strong> ${llamadaCreada.hora}</p>
          <p><strong>Duración:</strong> ${llamadaCreada.duracion} min</p>
          <p><strong>Tipificación:</strong> ${llamadaCreada.motivo_tipo}</p>
          <div class="actions">
            <a class="button" href="/llamada/comenzar">
              <i class="fas fa-phone"></i> Nueva llamada
            </a>
            <a class="button secondary" href="/llamada/list">
              <i class="fas fa-eye"></i> Ver llamadas
            </a>
          </div>
        </div>
      </c:if>

      <%-- Tabla de llamadas --%>
      <c:if test="${mostrarTabla}">
        <div class="table-wrap">
          <table>
            <thead>
            <tr>
              <th>ID</th>
              <th>Cliente</th>
              <th>Teléfono</th>
              <th>Tipificación</th>
              <th>Fecha</th>
              <th>Hora</th>
              <th>Duración</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${llamadas}" var="ll">
              <tr>
                <td>LL${ll.id_llamada}</td>
                <td>${ll.nombre_cliente}</td>
                <td>${ll.telefono_cliente}</td>
                <td>${ll.motivo_tipo}</td>
                <td>${ll.fecha_llamada}</td>
                <td>${ll.hora}</td>
                <td>${ll.duracion}</td>
                <td>${ll.estado}</td>
                <td>
                  <a class="button" href="/llamada/editar?id=${ll.id_llamada}">
                    <i class="fas fa-edit"></i> Editar
                  </a>
                  <a class="button secondary" href="/llamada/eliminar?id=${ll.id_llamada}"
                     onclick="return confirm('¿Eliminar llamada LL${ll.id_llamada}?')">
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


