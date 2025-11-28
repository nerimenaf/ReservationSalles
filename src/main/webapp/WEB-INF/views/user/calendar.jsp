<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Calendrier de mes réservations" scope="request"/>
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
        background-color: #cce5ff;
    }
    td.empty {
        background-color: #f8f9fa;
    }
</style>

<h1 class="h4 mb-3">Calendrier de mes réservations</h1>

<p class="text-muted">
    Semaine du ${startDate} au ${endDate}
</p>

<div class="mb-3">
    <a class="btn btn-sm btn-outline-secondary"
       href="${pageContext.request.contextPath}/user/calendar?startDate=${prevWeek}">
        &laquo; Semaine précédente
    </a>
    <a class="btn btn-sm btn-outline-secondary ms-1"
       href="${pageContext.request.contextPath}/user/calendar?startDate=${nextWeek}">
        Semaine suivante &raquo;
    </a>
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
                                    <div class="fw-semibold small">${grid[key].salleNom}</div>
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

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />