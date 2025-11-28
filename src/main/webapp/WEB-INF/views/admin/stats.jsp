<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Statistiques des réservations" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">Statistiques des réservations</h1>

<div class="row mb-4">
    <div class="col-md-4">
        <div class="card border-0">
            <div class="card-body">
                <h5 class="card-title">Total de réservations</h5>
                <p class="display-6 mb-0">${totalReservations}</p>
                <p class="text-muted mb-0 small">Tous statuts confondus</p>
            </div>
        </div>
    </div>
</div>

<h2 class="h5 mt-3">Répartition par statut</h2>
<div class="card border-0 mb-4">
    <div class="card-body p-0">
        <table class="table mb-0">
            <thead class="table-light">
                <tr>
                    <th>Statut</th>
                    <th>Nombre</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${statsByStatus}">
                <tr>
                    <td>
                        <span class="badge badge-status badge-status-${entry.key}">
                            ${entry.key}
                        </span>
                    </td>
                    <td>${entry.value}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<h2 class="h5 mt-3">Top 5 des salles les plus réservées (EN_ATTENTE + VALIDEE)</h2>
<div class="card border-0">
    <div class="card-body p-0">
        <table class="table mb-0">
            <thead class="table-light">
                <tr>
                    <th>Salle</th>
                    <th>Nombre de réservations</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${topSalles}">
                <tr>
                    <td>${s.nomSalle}</td>
                    <td>${s.nombreReservations}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty topSalles}">
                <tr>
                    <td colspan="2" class="text-center text-muted py-3">
                        Pas encore de réservations.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />