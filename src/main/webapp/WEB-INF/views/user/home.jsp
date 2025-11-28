<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Accueil utilisateur" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">Bienvenue, ${userSession.nomComplet}</h1>
<p class="text-muted">Consultez les salles et vos réservations.</p>

<div class="mb-4">
    <a href="${pageContext.request.contextPath}/user/reservations" class="btn btn-primary btn-sm">
        Mes réservations
    </a>
    <a href="${pageContext.request.contextPath}/user/calendar" class="btn btn-outline-primary btn-sm">
        Calendrier de mes réservations
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
                    <th style="width: 150px;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${salles}">
                <tr>
                    <td>${s.nom}</td>
                    <td>${s.capacite}</td>
                    <td>${s.localisation}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/user/salle?id=${s.id}"
                           class="btn btn-sm btn-outline-primary">
                            Détails / Avis
                        </a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty salles}">
                <tr>
                    <td colspan="4" class="text-center text-muted py-3">
                        Aucune salle disponible.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />