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
      <form:form action="/llamada/crear" method="post" modelAttribute="llamada">
        <div class="form-grid">
          <div>
            <label for="nombre_cliente">Nombre del cliente</label>
            <form:input path="nombre_cliente" id="nombre_cliente" placeholder="Ej: Alex Pérez" required="required"/>
          </div>
          <div>
            <label for="telefono_cliente">Teléfono del cliente</label>
            <form:input path="telefono_cliente" id="telefono_cliente" placeholder="Ej: 123456789" required="required" pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
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
        </div>
        <div class="actions">
          <button type="submit"><i class="fas fa-save"></i> Registrar</button>
          <a class="button secondary" href="/llamada/list"><i class="fas fa-eye"></i> Ver llamadas</a>
        </div>
      </form:form>
      <c:if test="${llamadaCreada != null}">
        <div class="notice-box">
          <h3><i class="fas fa-check-circle" style="color: green;"></i> Llamada registrada exitosamente</h3>
          <p><strong>Código de llamada:</strong> ${llamadaCreada.id_llamada}</p>
          <p><strong>Cliente:</strong> ${llamadaCreada.nombre_cliente}</p>
          <p><strong>Fecha:</strong> ${llamadaCreada.fecha_llamada}</p>
          <p><strong>Hora:</strong> ${llamadaCreada.hora}</p>
          <p>Recuerda tipificar esta llamada con el código mostrado.</p>
          <div class="actions" style="margin-top:12px;">
            <a class="button" href="/tipificaciones"><i class="fas fa-tags"></i> Ir a tipificar</a>
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
                <th>Hora</th>
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
                  <td>${llamada.hora}</td>
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
</body>
</html>

