<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Toutes les réservations" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Toutes les réservations</h1>
</div>

<div class="card border-0">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Salle</th>
                    <th>Utilisateur</th>
                    <th>Début</th>
                    <th>Fin</th>
                    <th>Statut</th>
                    <th>Commentaire</th>
                    <th style="width: 220px;">Actions admin</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${reservations}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.salleNom}</td>
                    <td>${r.utilisateurLogin}</td>
                    <td>${r.dateHeureDebut}</td>
                    <td>${r.dateHeureFin}</td>
                    <td>
                        <span class="badge badge-status badge-status-${r.statut}">
                            ${r.statut}
                        </span>
                    </td>
                    <td><c:out value="${r.commentaire}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${r.statut == 'EN_ATTENTE'}">
                                <a href="${pageContext.request.contextPath}/admin/reservations?action=validate&id=${r.id}"
                                   class="btn btn-sm btn-success me-1">
                                    Valider
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/reservations?action=refuse&id=${r.id}"
                                   class="btn btn-sm btn-warning me-1"
                                   onclick="return confirm('Refuser cette réservation ?');">
                                    Refuser
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/reservations?action=cancel&id=${r.id}"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Annuler cette réservation ?');">
                                    Annuler
                                </a>
                            </c:when>
                            <c:when test="${r.statut == 'VALIDEE'}">
                                <a href="${pageContext.request.contextPath}/admin/reservations?action=cancel&id=${r.id}"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Annuler cette réservation ?');">
                                    Annuler
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Aucune action</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reservations}">
                <tr>
                    <td colspan="8" class="text-center text-muted py-3">
                        Aucune réservation.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />