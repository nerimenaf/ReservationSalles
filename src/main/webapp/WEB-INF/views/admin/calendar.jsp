<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Calendrier par salle" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    table.calendar { border-collapse: collapse; width: 100%; }
    table.calendar th, table.calendar td {
        border: 1px solid #dee2e6;
        padding: 4px;
        text-align: center;
        min-width: 90px;
        font-size: 0.85rem;
    }
    td.reserved {
        background-color: #d4edda;
    }
    td.empty {
        background-color: #f8f9fa;
    }
</style>

<h1 class="h4 mb-3">Calendrier des réservations par salle</h1>

<div class="card mb-3 border-0">
    <div class="card-body">
        <form method="get" action="${pageContext.request.contextPath}/admin/calendar" class="row g-3">
            <div class="col-md-6">
                <label for="salleId" class="form-label">Salle</label>
                <select id="salleId" name="salleId" class="form-select" required>
                    <option value="">-- Choisir une salle --</option>
                    <c:forEach var="s" items="${salles}">
                        <option value="${s.id}"
                            <c:if test="${selectedSalle != null && selectedSalle.id == s.id}">selected</c:if>>
                            ${s.nom} (${s.capacite} places)
                        </option>
                    </c:forEach>
                </select>
            </div>

            <c:if test="${not empty startDate}">
                <input type="hidden" name="startDate" value="${startDate}" />
            </c:if>

            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary">
                    Afficher
                </button>
            </div>
        </form>
    </div>
</div>

<c:if test="${selectedSalle != null}">
    <div class="mb-3">
        <h2 class="h5 mb-1">Salle : ${selectedSalle.nom}</h2>
        <p class="text-muted mb-1">Semaine du ${startDate} au ${endDate}</p>

        <div class="mb-2">
            <a class="btn btn-sm btn-outline-secondary"
               href="${pageContext.request.contextPath}/admin/calendar?salleId=${selectedSalle.id}&startDate=${prevWeek}">
                &laquo; Semaine précédente
            </a>
            <a class="btn btn-sm btn-outline-secondary ms-1"
               href="${pageContext.request.contextPath}/admin/calendar?salleId=${selectedSalle.id}&startDate=${nextWeek}">
                Semaine suivante &raquo;
            </a>
        </div>
    </div>

    <div class="card border-0">
        <div class="card-body p-0">
            <table class="calendar">
                <thead class="table-light">
                    <tr>
                        <th>Heure</th>
                        <c:forEach var="d" items="${days}">
                            <th>${d}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="h" items="${hours}">
                    <tr>
                        <td><strong>${h}:00</strong></td>
                        <c:forEach var="d" items="${days}">
                            <c:set var="key" value="${d}_${h}" />
                            <c:choose>
                                <c:when test="${not empty grid[key]}">
                                    <td class="reserved">
                                        <div class="fw-semibold small">
                                            Utilisateur : ${grid[key].utilisateurLogin}
                                        </div>
                                        <div class="small">
                                            ${grid[key].dateHeureDebut} - ${grid[key].dateHeureFin}
                                        </div>
                                        <div class="small">
                                            <span class="badge badge-status badge-status-${grid[key].statut}">
                                                ${grid[key].statut}
                                            </span>
                                        </div>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td class="empty"></td>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</c:if>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />