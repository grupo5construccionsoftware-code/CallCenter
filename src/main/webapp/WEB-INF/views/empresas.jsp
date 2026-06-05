<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista de Empresas | Sistema Call Center</title>
  <link rel="stylesheet" href="/CallCenter.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="fragments/nav_privado.jsp" %>
<div class="container">
  <section class="section">
    <div class="hero-copy">
      <h1>Lista de Empresas</h1>
      <p>Empresas registradas que utilizan el sistema de call center</p>
    </div>

    <c:choose>
      <c:when test="${empresaEditar != null}">
        <article class="card">
          <div class="section-title">
            <h2><i class="fas fa-edit"></i> Editando empresa: ${empresaEditar.nombre_empresa}</h2>
          </div>
          <form action="/empresa/actualizar" method="post">
            <input type="hidden" name="id_empresa" value="${empresaEditar.id_empresa}">
            <div class="form-grid">
              <div>
                <label for="edit-nombre">Nombre</label>
                <input type="text" id="edit-nombre" name="nombre_empresa"
                       value="${empresaEditar.nombre_empresa}" required>
              </div>
              <div>
                <label for="edit-telefono">Teléfono</label>
                <input type="text" id="edit-telefono" name="telefono_empresa"
                       value="${empresaEditar.telefono_empresa}" required
                       pattern="[0-9]+" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
              </div>
              <div>
                <label for="edit-correo">Correo</label>
                <input type="email" id="edit-correo" name="correo_empresa"
                       value="${empresaEditar.correo_empresa}" required>
              </div>
              <div>
                <label for="edit-estado">Estado</label>
                <select id="edit-estado" name="estado_empresa">
                  <option value="ACTIVO"     ${empresaEditar.estado_empresa == 'activo'     ? 'selected' : ''}>Activo</option>
                  <option value="INACTIVO" ${empresaEditar.estado_empresa == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                  <option value="ELIMINADO"    ${empresaEditar.estado_empresa == 'eliminado'    ? 'selected' : ''}>Eliminado</option>
                </select>
              </div>
            </div>
            <div class="actions">
              <button type="submit"><i class="fas fa-save"></i> Guardar cambios</button>
              <a class="button secondary" href="/empresas?mostrar=true">
                <i class="fas fa-times"></i> Cancelar
              </a>
            </div>
          </form>
        </article>
      </c:when>

      <c:otherwise>
        <article class="card">
          <div class="actions">
            <a class="button" href="/empresa/nueva">
              <i class="fas fa-plus"></i> Registrar nueva empresa
            </a>
            <a class="button secondary" href="/empresas?mostrar=true">
              <i class="fas fa-eye"></i> Ver empresas
            </a>
          </div>
        </article>
      </c:otherwise>
    </c:choose>

    <%-- Tabla de empresas --%>
    <c:if test="${mostrarEmpresas}">
      <article class="card">
        <div class="table-wrap">
          <table>
            <thead>
            <tr>
              <th>Código</th>
              <th>Nombre</th>
              <th>Teléfono</th>
              <th>Correo</th>
              <th>Usuario</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty empresas}">
                <tr><td colspan="7">No hay empresas registradas.</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="empresa" items="${empresas}">
                  <tr>
                    <td>${empresa.id_empresa}</td>
                    <td>${empresa.nombre_empresa}</td>
                    <td>${empresa.telefono_empresa}</td>
                    <td>${empresa.correo_empresa}</td>
                    <td>${empresa.usuario_empresa}</td>
                    <td>${empresa.estado_empresa}</td>
                    <td>
                      <a class="button" href="/empresa/editar?id=${empresa.id_empresa}">
                        <i class="fas fa-edit"></i> Editar
                      </a>
                      <a class="button secondary" href="/empresa/eliminar?id=${empresa.id_empresa}"
                         onclick="return confirm('¿Eliminar empresa ${empresa.nombre_empresa}?')">
                        <i class="fas fa-trash"></i> Eliminar
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </article>
    </c:if>

  </section>
</div>
<div class="footer">Sistema de Call Center - Lista de Empresas</div>
</body>
</html>
