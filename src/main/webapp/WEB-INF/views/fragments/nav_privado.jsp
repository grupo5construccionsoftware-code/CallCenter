<%--
  fragments/nav_privado.jsp
  Ubicar en: src/main/webapp/WEB-INF/views/fragments/nav_privado.jsp
  Incluir con: <%@ include file="fragments/nav_privado.jsp" %>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rolSesion" value="${sessionScope.rol}" />
<c:set var="uriActual" value="${pageContext.request.requestURI}" />

<c:choose>
    <c:when test="${rolSesion == 'superadmin'}">
        <c:set var="urlInicio" value="/dashboard/superadmin" />
    </c:when>
    <c:when test="${rolSesion == 'agente'}">
        <c:set var="urlInicio" value="/dashboard/agente" />
    </c:when>
    <c:otherwise>
        <c:set var="urlInicio" value="/dashboard/empresa" />
    </c:otherwise>
</c:choose>

<header class="topbar">
    <div class="topbar-inner">
        <div class="brand">
            <img src="/logo.png" alt="Logo Sistema CallCenter" class="brand-logo">
        </div>
        <nav class="menu" aria-label="Navegación privada">

            <a href="${urlInicio}">Inicio</a>
            <a href="/gestion" class="${uriActual.contains('/gestion') ? 'active' : ''}">Gestión</a>

            <c:choose>
                <c:when test="${rolSesion == 'superadmin'}">
                    <a href="/empresas"          class="${uriActual.contains('/empresas') ? 'active' : ''}">Lista de Empresas</a>
                    <a href="/metricas/superadmin" class="${uriActual.contains('/metricas') ? 'active' : ''}">Métricas</a>
                </c:when>
                <c:when test="${rolSesion == 'agente'}">
                    <a href="/llamadas"   class="${uriActual.contains('/llamadas') ? 'active' : ''}">Llamadas</a>
                    <a href="/metricas"   class="${uriActual.contains('/metricas') ? 'active' : ''}">Métricas</a>
                    <a href="/adicional1" class="${uriActual.contains('/adicional1') ? 'active' : ''}">Historial de llamadas</a>
                </c:when>
                <c:otherwise><%-- empresa --%>
                    <a href="/metricas"       class="${uriActual.contains('/metricas') ? 'active' : ''}">Métricas</a>
                    <a href="/usuarios"       class="${uriActual.contains('/usuarios') ? 'active' : ''}">Usuarios</a>
                    <a href="/tipificaciones" class="${uriActual.contains('/tipificaciones') ? 'active' : ''}">Tipificaciones</a>
                    <a href="/adicional1"     class="${uriActual.contains('/adicional1') ? 'active' : ''}">Historial de llamadas</a>
                </c:otherwise>
            </c:choose>

            <a href="/login/salir" class="session">Salir</a>
        </nav>
    </div>
</header>