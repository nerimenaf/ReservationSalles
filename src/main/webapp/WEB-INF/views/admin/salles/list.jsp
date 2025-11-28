<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Gestion des salles" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Gestion des salles</h1>
    <a href="${pageContext.request.contextPath}/admin/salles?action=edit" class="btn btn-primary">
        + Ajouter une salle
    </a>
</div>

<div class="card border-0">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead>
                <tr>
                    <th>Nom</th>
                    <th>Capacité</th>
                    <th>Localisation</th>
                    <th>Équipements</th>
                    <th style="width: 150px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${salles}">
                <tr>
                    <td>${s.nom}</td>
                    <td>${s.capacite}</td>
                    <td>${s.localisation}</td>
                    <td><c:out value="${s.equipements}"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/salles?action=edit&id=${s.id}"
                           class="btn btn-sm btn-outline-secondary">Modifier</a>
                        <a href="${pageContext.request.contextPath}/admin/salles?action=delete&id=${s.id}"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Supprimer cette salle ?');">
                            Supprimer
                        </a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty salles}">
                <tr>
                    <td colspan="5" class="text-center text-muted py-3">
                        Aucune salle enregistrée.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />