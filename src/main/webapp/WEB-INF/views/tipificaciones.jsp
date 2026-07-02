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


    <c:if test="${tipificacionEditar != null}">
      <article class="card">
        <div class="section-title">
          <h2><i class="fas fa-edit"></i> Editando tipificación: ${tipificacionEditar.motivo_tipo}</h2>
        </div>
        <form action="/tipificacion/actualizar" method="post">
          <input type="hidden" name="id_tipo" value="${tipificacionEditar.id_tipo}">
          <div class="form-grid">
            <div>
              <label for="edit-motivo">Tipificación</label>
              <input type="text" id="edit-motivo" name="motivo_tipo"
                     value="${tipificacionEditar.motivo_tipo}" required>
            </div>
            <div>
              <label for="edit-estado">Estado</label>
              <select id="edit-estado" name="estado_tipo">
                <option value="ACTIVO"      ${tipificacionEditar.estado_tipo == 'ACTIVO'      ? 'selected' : ''}>Activo</option>
                <option value="INACTIVO"  ${tipificacionEditar.estado_tipo == 'INACTIVO'  ? 'selected' : ''}>Inactivo</option>
                <option value="ELIMINADO"   ${tipificacionEditar.estado_tipo == 'ELIMINADO'   ? 'selected' : ''}>Eliminado</option>
              </select>
            </div>
          </div>
          <div class="actions">
            <button type="submit"><i class="fas fa-save"></i> Guardar cambios</button>
            <a class="button secondary" href="/tipificacion/list">
              <i class="fas fa-times"></i> Cancelar
            </a>
          </div>
        </form>
      </article>
    </c:if>


    <c:if test="${tipificacionEditar == null}">
      <article class="card">
        <form:form action="/tipificacion/crear" method="post" modelAttribute="tipificacion">
          <div class="form-grid">
            <div>
              <label for="motivo_tipo">Tipificación</label>
              <form:input path="motivo_tipo" id="motivo_tipo"
                          placeholder="Ej: Consulta" required="required"/>
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
          <div class="notice-box" style="margin-top:16px;">
            <h3><i class="fas fa-check-circle" style="color:green;"></i> Tipificación registrada exitosamente</h3>
            <p><strong>Código:</strong> ${tipificacionCreada.id_tipo}</p>
            <p><strong>Tipificación:</strong> ${tipificacionCreada.motivo_tipo}</p>
            <div class="actions" style="margin-top:12px;">
              <a class="button" href="/tipificaciones"><i class="fas fa-check"></i> Aceptar</a>
            </div>
          </div>
        </c:if>
      </article>
    </c:if>


    <c:if test="${mostrarTabla}">
      <article class="card">
        <div class="table-wrap">
          <table>
            <thead>
            <tr>
              <th>ID</th>
              <th>Tipificación</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tipificaciones}" var="tip">
              <tr>
                <td>${tip.id_tipo}</td>
                <td>${tip.motivo_tipo}</td>
                <td>${tip.estado_tipo}</td>
                <td>
                  <a class="button" href="/tipificacion/editar?id=${tip.id_tipo}">
                    <i class="fas fa-edit"></i> Editar
                  </a>
                  <a class="button secondary" href="/tipificacion/eliminar?id=${tip.id_tipo}"
                     onclick="return confirm('¿Eliminar tipificación ${tip.motivo_tipo}?')">
                    <i class="fas fa-trash"></i> Eliminar
                  </a>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </article>
    </c:if>

  </section>
</div>
<div class="footer">Sistema de Call Center - Tipificación de llamadas</div>
</body>
</html>


