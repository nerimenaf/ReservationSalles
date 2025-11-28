<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Dashboard admin" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="row">
    <div class="col-12 mb-4">
        <h1 class="page-title h3">Dashboard administrateur</h1>
        <p class="text-muted">Vue d’ensemble de l’application.</p>
    </div>

    <div class="col-md-3 mb-3">
        <a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none">
            <div class="card border-0">
                <div class="card-body">
                    <h5 class="card-title">Utilisateurs</h5>
                    <p class="card-text text-muted">Gérer les comptes et les rôles.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-md-3 mb-3">
        <a href="${pageContext.request.contextPath}/admin/salles" class="text-decoration-none">
            <div class="card border-0">
                <div class="card-body">
                    <h5 class="card-title">Salles</h5>
                    <p class="card-text text-muted">Ajouter et modifier les salles.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-md-3 mb-3">
        <a href="${pageContext.request.contextPath}/admin/reservations" class="text-decoration-none">
            <div class="card border-0">
                <div class="card-body">
                    <h5 class="card-title">Réservations</h5>
                    <p class="card-text text-muted">Valider, refuser, annuler.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-md-3 mb-3">
        <a href="${pageContext.request.contextPath}/admin/stats" class="text-decoration-none">
            <div class="card border-0">
                <div class="card-body">
                    <h5 class="card-title">Statistiques</h5>
                    <p class="card-text text-muted">Taux d’utilisation, top salles.</p>
                </div>
            </div>
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />