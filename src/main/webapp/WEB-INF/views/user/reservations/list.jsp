<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Mes réservations" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Mes réservations</h1>
    <a href="${pageContext.request.contextPath}/user/reservations?action=new"
       class="btn btn-primary btn-sm">
        + Nouvelle réservation
    </a>
</div>

<div class="card border-0">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>Salle</th>
                    <th>Début</th>
                    <th>Fin</th>
                    <th>Statut</th>
                    <th>Commentaire</th>
                    <th style="width: 130px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${reservations}">
                <tr>
                    <td>${r.salleNom}</td>
                    <td>${r.dateHeureDebut}</td>
                    <td>${r.dateHeureFin}</td>
                    <td>
                        <span class="badge badge-status badge-status-${r.statut}">
                            ${r.statut}
                        </span>
                    </td>
                    <td><c:out value="${r.commentaire}"/></td>
                    <td>
                        <c:if test="${r.statut != 'ANNULEE' && r.statut != 'REFUSEE'}">
                            <a href="${pageContext.request.contextPath}/user/reservations?action=cancel&id=${r.id}"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('Annuler cette réservation ?');">
                                Annuler
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reservations}">
                <tr>
                    <td colspan="6" class="text-center text-muted py-3">
                        Aucune réservation.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />