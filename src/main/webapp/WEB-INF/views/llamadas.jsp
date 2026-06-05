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
          <input type="hidden" name="hora_inicio"   value="${llamadaEditar.hora_inicio}">
          <input type="hidden" name="hora_fin"      value="${llamadaEditar.hora_fin}">
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
              <input type="text" id="edit-descripcion" name="descripcion_tipo"
                     value="${llamadaEditar.descripcion_tipo}"
                     placeholder="Ej: El cliente consulta sobre su factura">
            </div>
            <div>
              <label for="edit-estado">Estado</label>
              <select id="edit-estado" name="estado_llamada">
                <option value="Activo"    ${llamadaEditar.estado_llamada == 'Activo'    ? 'selected' : ''}>Activo</option>
                <option value="Inactivo"  ${llamadaEditar.estado_llamada == 'Inactivo'  ? 'selected' : ''}>Inactivo</option>
                <option value="Eliminado" ${llamadaEditar.estado_llamada == 'Eliminado' ? 'selected' : ''}>Eliminado</option>
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
          <button type="button" id="btn-iniciar-llamada">
            <i class="fas fa-phone"></i> Registrar llamada
          </button>
          <a class="button secondary" href="/llamada/list">
            <i class="fas fa-eye"></i> Ver llamadas
          </a>
        </div>
      </c:if>

      <%-- Formulario nuevo registro --%>
      <form:form action="/llamada/crear" method="post" modelAttribute="llamada"
                 id="form-llamada" style="display:none;">
        <div class="notice-box" style="background:#e8f4fd; border-left:4px solid var(--color-primario); margin-bottom:14px;">
          <p><i class="fas fa-clock"></i> <strong>Registro iniciado</strong> — Complete los datos y presione "Finalizar registro".</p>
        </div>
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
            <label for="descripcion_tipo">Descripción</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo"
                        placeholder="Ej: El cliente consulta sobre su factura"/>
          </div>
        </div>
        <%-- Campos ocultos --%>
        <form:hidden path="hora_inicio" id="hora_inicio"/>
        <form:hidden path="hora_fin"    id="hora_fin"/>
        <form:hidden path="duracion"    id="duracion"/>
        <form:hidden path="estado_llamada" id="estado_llamada"/>
        <div class="actions">
          <button type="submit"><i class="fas fa-stop-circle"></i> Finalizar registro</button>
          <button type="button" class="secondary" id="btn-cancelar-llamada">
            <i class="fas fa-times"></i> Cancelar
          </button>
          <a class="button secondary" href="/llamada/list">
            <i class="fas fa-eye"></i> Ver llamadas
          </a>
        </div>
      </form:form>

      <%-- Confirmación tras registrar --%>
      <c:if test="${llamadaCreada != null}">
        <div class="notice-box">
          <h3><i class="fas fa-check-circle"></i> Llamada registrada exitosamente</h3>
          <p><strong>Código:</strong> LL${llamadaCreada.id_llamada}</p>
          <p><strong>Cliente:</strong> ${llamadaCreada.nombre_cliente}</p>
          <p><strong>Fecha:</strong> ${llamadaCreada.fecha_llamada}</p>
          <p><strong>Hora inicio:</strong> ${llamadaCreada.hora_inicio}</p>
          <p><strong>Duración:</strong> ${llamadaCreada.duracion}</p>
          <p><strong>Tipificación:</strong> ${llamadaCreada.motivo_tipo}</p>
          <div class="actions">
            <a class="button" href="/llamadas">
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
              <th>Hora inicio</th>
              <th>Duración</th>
              <th>Descripción</th>
              <th>Agente</th>
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
                <td>${ll.hora_inicio}</td>
                <td>${ll.duracion}</td>
                <td>${ll.descripcion_tipo}</td>
                <td>${agenteMap[ll.id_agente]}</td>
                <td>${ll.estado_llamada}</td>
                <td>
                  <div class="actions" style="margin-top:0; flex-wrap:nowrap; width:fit-content; margin-left:auto; margin-right:auto;">
                    <a class="button" href="/llamada/editar?id=${ll.id_llamada}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/llamada/eliminar?id=${ll.id_llamada}"
                       onclick="return confirm('¿Eliminar llamada LL${ll.id_llamada}?')">
                      <i class="fas fa-trash"></i> Eliminar
                    </a>
                  </div>
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
  const formLlamada   = document.getElementById('form-llamada');
  const btnIniciar    = document.getElementById('btn-iniciar-llamada');
  const btnCancelar   = document.getElementById('btn-cancelar-llamada');
  const horaInicio    = document.getElementById('hora_inicio');
  const horaFin       = document.getElementById('hora_fin');
  const duracion      = document.getElementById('duracion');
  const estadoLlamada = document.getElementById('estado_llamada');

  function horaActual() {
    const d = new Date();
    return [d.getHours(), d.getMinutes()]
            .map(v => String(v).padStart(2,'0')).join(':');
  }

  if (btnIniciar) {
    btnIniciar.addEventListener('click', function () {
      horaInicio.value    = horaActual();
      horaFin.value       = '';
      duracion.value      = '';
      estadoLlamada.value = 'Activo';
      btnIniciar.closest('.actions').style.display = 'none';
      formLlamada.style.display = '';
      document.getElementById('nombre_cliente').focus();
    });
  }

  if (btnCancelar) {
    btnCancelar.addEventListener('click', function () {
      formLlamada.reset();
      formLlamada.style.display = 'none';
      const accionesBtn = document.querySelector('.actions');
      if (accionesBtn) accionesBtn.style.display = '';
    });
  }

  if (formLlamada) {
    formLlamada.addEventListener('submit', function () {
      if (!horaInicio.value) horaInicio.value = horaActual();
      horaFin.value       = horaActual();
      estadoLlamada.value = 'Activo';
    });
  }
</script>
</body>
</html>



