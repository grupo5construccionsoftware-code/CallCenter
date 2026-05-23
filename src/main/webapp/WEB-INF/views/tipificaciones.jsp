<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tipificaciones | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Tipificaciones</h1>
      <p>Agregar detalles de la llamada</p>
    </div>
    <article class="card">
      <c:if test="${guardado == true}">
        <div class="mensaje-exito">
          <i class="fas fa-check-circle"></i>
          <strong> Tipificacion guardada correctamente.</strong>
        </div>
      </c:if>
      <form:form id="formTipificacion" action="/tipificacion/crear" method="post" modelAttribute="tipificacion">
        <div class="form-grid">
          <div>
            <label for="id_llamada">Código de llamada</label>
            <form:input path="id_llamada" id="id_llamada" placeholder="Ej: 1" required="required"/>
          </div>
          <div>
            <label for="id_tipo">Motivo</label>
            <form:select path="id_tipo" id="id_tipo" required="required">
              <option value="" disabled selected>Selecciona un motivo</option>
              <option value="1">Consulta</option>
              <option value="2">Reclamo</option>
              <option value="3">Venta</option>
              <option value="4">Soporte</option>
              <c:forEach items="${tiposLlamada}" var="tipo" varStatus="estado">
                <option value="${estado.index + 6}">${tipo}</option>
              </c:forEach>
              <option value="5">Otros</option>
            </form:select>
          </div>
          <div>
            <label for="descripcion_tipo">Descripción</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo" placeholder="Ej: Cliente consulta sobre su factura" required="required"/>
          </div>
        </div>
      </form:form>
      <div class="tipos-panel tipos-panel-oculto" id="tiposPanel">
        <div>
          <h2>Tipos de llamada</h2>
          <p>Agrega nuevos motivos para usarlos en las tipificaciones.</p>
        </div>
        <div class="tipo-acciones">
          <form action="/tipificacion/tipo/crear" method="post" class="tipo-form">
            <label for="nuevoTipo">Nuevo tipo</label>
            <div class="tipo-form-row">
              <input type="text" name="nuevoTipo" id="nuevoTipo" placeholder="Ej: Renovacion de servicio" required>
              <button type="submit"><i class="fas fa-plus"></i> Agregar tipo</button>
            </div>
          </form>
          <form action="/tipificacion/tipo/eliminar" method="post" class="tipo-form">
            <label for="idTipoEliminar">Tipo a eliminar</label>
            <div class="tipo-form-row">
              <select name="idTipo" id="idTipoEliminar" required>
                <option value="" disabled selected>Selecciona un tipo</option>
                <c:choose>
                  <c:when test="${empty tiposLlamada}">
                    <option value="" disabled>No hay tipos para eliminar</option>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${tiposLlamada}" var="tipo" varStatus="estado">
                      <option value="${estado.index + 1}">${tipo}</option>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </select>
              <button type="submit" class="secondary"><i class="fas fa-trash"></i> Eliminar tipo</button>
            </div>
          </form>
        </div>
      </div>
      <div class="actions">
        <button type="submit" form="formTipificacion"><i class="fas fa-save"></i> Guardar</button>
        <a class="button secondary" href="/tipificacion/list"><i class="fas fa-eye"></i> Ver tipificaciones</a>
      </div>
      <c:if test="${mostrarTabla}">
        <div class="table-wrap">
          <table>
            <thead>
            <tr>
              <th>ID llamada</th><th>Cliente</th><th>Motivo</th><th>Descripción</th><th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tipificaciones}" var="tipificacion">
              <tr>
                <td>${tipificacion.id_llamada}</td>
                <td>${tipificacion.nombre_cliente}</td>
                <td>${tipificacion.motivo_tipo}</td>
                <td>${tipificacion.descripcion_tipo}</td>
                <td>
                  <a class="button" href="/tipificacion/editar?id=${tipificacion.id_llamada}"><i class="fas fa-edit"></i> Editar</a>
                  <a class="button secondary" href="/tipificacion/eliminar?id=${tipificacion.id_llamada}"><i class="fas fa-trash"></i> Eliminar</a>
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
<div class="footer">Sistema de Call Center - Tipificación de llamadas</div>
<script>
  const motivoSelect = document.getElementById('id_tipo');
  const tiposPanel = document.getElementById('tiposPanel');
  function actualizarTiposAdicionales() {
    tiposPanel.classList.toggle('tipos-panel-oculto', motivoSelect.value !== '5');
  }
  motivoSelect.addEventListener('change', actualizarTiposAdicionales);
  actualizarTiposAdicionales();
</script>
</body>
</html>
