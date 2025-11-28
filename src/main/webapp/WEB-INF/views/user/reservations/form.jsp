<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Nouvelle réservation" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">Nouvelle réservation</h1>

<div class="mb-3">
    <a href="${pageContext.request.contextPath}/user/reservations"
       class="btn btn-sm btn-outline-secondary">
        Retour à la liste
    </a>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger" role="alert">
        ${error}
    </div>
</c:if>

<div class="card border-0">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/user/reservations" method="post">
            <input type="hidden" name="action" value="create" />

            <div class="mb-3">
                <label for="salleId" class="form-label">Salle</label>
                <select id="salleId" name="salleId" class="form-select" required>
                    <option value="">-- Choisir une salle --</option>
                    <c:forEach var="s" items="${salles}">
                        <option value="${s.id}">
                            ${s.nom} (${s.capacite} places)
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="dateHeureDebut" class="form-label">Date et heure de début</label>
                <input type="datetime-local" id="dateHeureDebut" name="dateHeureDebut"
                       class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="dateHeureFin" class="form-label">Date et heure de fin</label>
                <input type="datetime-local" id="dateHeureFin" name="dateHeureFin"
                       class="form-control" required />
            </div>

            <button type="submit" class="btn btn-primary">
                Valider la réservation
            </button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />