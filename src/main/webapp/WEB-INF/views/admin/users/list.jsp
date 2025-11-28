<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Gestion des utilisateurs" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Gestion des utilisateurs</h1>
    <a href="${pageContext.request.contextPath}/admin/users?action=edit"
       class="btn btn-primary btn-sm">
        + Ajouter un utilisateur
    </a>
</div>

<div class="card border-0">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Login</th>
                    <th>Nom complet</th>
                    <th>Rôle</th>
                    <th>Actif</th>
                    <th style="width: 150px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="u" items="${utilisateurs}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.login}</td>
                    <td>${u.nomComplet}</td>
                    <td>${u.role}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.actif}">
                                <span class="badge bg-success">Oui</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Non</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}"
                           class="btn btn-sm btn-outline-secondary">
                            Modifier
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}"
                           class="btn btn-sm btn-outline-danger ms-1"
                           onclick="return confirm('Supprimer cet utilisateur ?');">
                            Supprimer
                        </a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty utilisateurs}">
                <tr>
                    <td colspan="6" class="text-center text-muted py-3">
                        Aucun utilisateur.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />