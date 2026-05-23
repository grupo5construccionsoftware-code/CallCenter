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
      <p>Registro y gestión de los tipos de llamada del sistema</p>
    </div>
    <article class="card">
      <form:form action="/tipificacion/crear" method="post" modelAttribute="tipificacion">
        <div class="form-grid">
          <div>
            <label for="motivo_tipo">Tipificación</label>
            <form:input path="motivo_tipo" id="motivo_tipo" placeholder="Ej: Consulta" required="required"/>
          </div>
          <div>
            <label for="descripcion_tipo">Descripción</label>
            <form:input path="descripcion_tipo" id="descripcion_tipo" placeholder="Ej: El cliente solicita información" required="required"/>
          </div>
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Guardar</button>
          <a class="button secondary" href="/tipificacion/list">
            <i class="fas fa-eye"></i> Ver tipificaciones
          </a>
        </div>
      </form:form>
      <c:if test="${tipificacionCreada != null}">
        <div class="notice-box" style="margin-top: 16px;">
          <h3><i class="fas fa-check-circle" style="color: green;"></i> Tipificación registrada exitosamente</h3>
          <p><strong>Código:</strong> ${tipificacionCreada.id_tipo}</p>
          <p><strong>Tipificación:</strong> ${tipificacionCreada.motivo_tipo}</p>
          <p><strong>Descripción:</strong> ${tipificacionCreada.descripcion_tipo}</p>
          <div class="actions" style="margin-top: 12px;">
            <a class="button" href="/tipificaciones">
              <i class="fas fa-check"></i> Aceptar
            </a>
          </div>
        </div>
      </c:if>
      <c:if test="${mostrarTabla}">
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Tipificación</th>
                <th>Descripción</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${tipificaciones}" var="tipificacion">
                <tr>
                  <td>${tipificacion.id_tipo}</td>
                  <td>${tipificacion.motivo_tipo}</td>
                  <td>${tipificacion.descripcion_tipo}</td>
                  <td>
                    <a class="button" href="/tipificacion/editar?id=${tipificacion.id_tipo}">
                      <i class="fas fa-edit"></i> Editar
                    </a>
                    <a class="button secondary" href="/tipificacion/eliminar?id=${tipificacion.id_tipo}">
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
