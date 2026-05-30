<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Editar Empresa</title>
  <link rel="stylesheet" href="/CallCenter.css">
</head>
<body>
<div class="container">
  <section class="section">
    <article class="card">
      <h2>Editar empresa</h2>
      <form action="/empresa/actualizar" method="post">
        <input type="hidden" name="id" value="${empresa.id}">
        <label>Nombre</label>
        <input type="text" name="nombre" value="${empresa.nombre}" required>
        <label>Teléfono</label>
        <input type="text" name="telefono" value="${empresa.telefono}" required pattern="[0-9]{9}" maxlength="9" title="Ingrese exactamente 9 dígitos" oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 9);">
        <label>Correo</label>
        <input type="email" name="correo" value="${empresa.correo}" required>
        <label>Estado</label>
        <select name="estado" required>
          <option value="activo" ${empresa.estado == 'activo' ? 'selected' : ''}>Activo</option>
          <option value="suspendido" ${empresa.estado == 'suspendido' ? 'selected' : ''}>Suspendido</option>
        </select>
        <div class="actions" style="margin-top:16px;">
          <button type="submit">Guardar cambios</button>
          <a class="button secondary" href="/empresas">Cancelar</a>
        </div>
      </form>
    </article>
  </section>
</div>
</body>
</html>
