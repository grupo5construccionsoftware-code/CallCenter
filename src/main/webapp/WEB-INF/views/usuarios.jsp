<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Usuarios | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Agentes del Call Center</h1>
      <p>Registro de los agentes que operan el call center y su número telefónico</p>
    </div>

    <%-- Formulario de edición inline (se muestra cuando agenteEditar != null) --%>
    <c:if test="${agenteEditar != null}">
      <article class="card">
        <div class="section-title">
          <h2><i class="fas fa-edit"></i> Editando agente: ${agenteEditar.nombre_agente}</h2>
        </div>
        <form action="/agente/actualizar" method="post">
          <input type="hidden" name="id_agente"          value="${agenteEditar.id_agente}">
          <input type="hidden" name="id_empresa"         value="${agenteEditar.id_empresa}">
          <input type="hidden" name="usuario_agente"     value="${agenteEditar.usuario_agente}">
          <input type="hidden" name="contrasenia_agente" value="${agenteEditar.contrasenia_agente}">
          <div class="form-grid">
            <div>
              <label for="edit-nombre">Nombre del agente</label>
              <input type="text" id="edit-nombre" name="nombre_agente"
                     value="${agenteEditar.nombre_agente}" required>
            </div>
            <div>
              <label for="edit-telefono">Teléfono del agente</label>
              <input type="text" id="edit-telefono" name="telefono_agente"
                     value="${agenteEditar.telefono_agente}" required
                     pattern="[0-9]{9}" maxlength="9"
                     oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,9);">
            </div>
            <div>
              <label for="edit-estado">Estado</label>
              <select id="edit-estado" name="estado_agente">
                <option value="ACTIVO"     ${agenteEditar.estado_agente == 'ACTIVO'     ? 'selected' : ''}>Activo</option>
                <option value="INACTIVO" ${agenteEditar.estado_agente == 'INACTIVO' ? 'selected' : ''}>Inactivo</option>
                <option value="ELIMINADO"    ${agenteEditar.estado_agente == 'ELIMINADO'    ? 'selected' : ''}>Eliminado</option>
              </select>
            </div>
          </div>
          <div class="actions">
            <button type="submit"><i class="fas fa-save"></i> Guardar cambios</button>
            <a class="button secondary" href="/agente/list">
              <i class="fas fa-times"></i> Cancelar
            </a>
          </div>
        </form>
      </article>
    </c:if>

    <%-- Formulario de crear (se oculta mientras se edita) --%>
    <c:if test="${agenteEditar == null}">
      <article class="card">
        <form:form action="/agente/crear" method="post" modelAttribute="agente">
          <div class="form-grid">
            <div>
              <label for="nombre_agente">Nombre del agente</label>
              <form:input path="nombre_agente" id="nombre_agente"
                          placeholder="Ej: Pérez García, Juan" required="required"/>
            </div>
            <div>
              <label for="telefono_agente">Teléfono del agente</label>
              <form:input path="telefono_agente" id="telefono_agente"
                          placeholder="Ej: 123456789" required="required"
                          pattern="[0-9]{9}" maxlength="9"
                          title="Ingrese exactamente 9 dígitos"
                          oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 9);"/>
            </div>
          </div>
          <div class="actions single align-center">
            <button type="submit"><i class="fas fa-save"></i> Guardar agente</button>
            <a class="button secondary" href="/agente/list">
              <i class="fas fa-eye"></i> Ver agentes
            </a>
          </div>
        </form:form>

        <c:if test="${error != null}">
          <div class="notice-box">
            <h3><i class="fas fa-exclamation-circle"></i> No se pudo guardar el agente</h3>
            <p>${error}</p>
          </div>
        </c:if>

        <c:if test="${agenteCreado != null}">
          <div class="notice-box">
            <h3><i class="fas fa-check-circle"></i> Agente registrado exitosamente</h3>
            <p><strong>Código:</strong> ${agenteCreado.codigo_agente}</p>
            <p><strong>Nombre:</strong> ${agenteCreado.nombre_agente}</p>
            <p><strong>Teléfono:</strong> ${agenteCreado.telefono_agente}</p>
            <p><strong>Usuario:</strong> ${agenteCreado.usuario_agente}</p>
            <p><strong>Contraseña:</strong> ${agenteCreado.contrasenia_agente}</p>
            <p>Guarda estos datos, no se volverán a mostrar.</p>
            <div class="actions">
              <a class="button" href="/usuarios"><i class="fas fa-check"></i> Aceptar</a>
            </div>
          </div>
        </c:if>
      </article>
    </c:if>

    <%-- Tabla de agentes --%>
    <c:if test="${mostrarTabla}">
      <article class="card">
        <div class="table-wrap">
          <table>
            <thead>
            <tr>
              <th>Código</th>
              <th>Nombre</th>
              <th>Teléfono</th>
              <th>Usuario</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${agentes}" var="ag">
              <tr>
                <td>${ag.codigo_agente}</td>
                <td>${ag.nombre_agente}</td>
                <td>${ag.telefono_agente}</td>
                <td>${ag.usuario_agente}</td>
                <td>${ag.estado_agente}</td>
                <td>
                  <a class="button" href="/agente/editar?id=${ag.id_agente}">
                    <i class="fas fa-edit"></i> Editar
                  </a>
                  <a class="button secondary" href="/agente/eliminar?id=${ag.id_agente}"
                     onclick="return confirm('¿Eliminar agente ${ag.nombre_agente}?')">
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
<div class="footer">Sistema de Call Center - Usuarios (Agentes)</div>
</body>
</html>

