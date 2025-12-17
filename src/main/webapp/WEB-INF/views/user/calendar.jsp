<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Calendrier - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== PAGE HEADER ===== */
    .page-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 20px;
        margin-bottom: 32px;
    }

    .page-title-section {
        display: flex;
        align-items: center;
        gap: 16px;
    }

    .page-icon {
        width: 56px;
        height: 56px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 24px;
        box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
    }

    .page-title h1 {
        font-size: 24px;
        font-weight: 700;
        color: var(--dark);
        margin: 0 0 4px 0;
    }

    .page-title p {
        font-size: 14px;
        color: var(--gray-500);
        margin: 0;
    }

    /* ===== WEEK NAVIGATION ===== */
    .week-navigation {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .btn-nav {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--white);
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 500;
        color: var(--gray-700);
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        font-family: 'Poppins', sans-serif;
    }

    .btn-nav:hover {
        border-color: var(--primary);
        color: var(--primary);
        background: var(--primary-lighter);
    }

    .btn-nav.today {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        border-color: transparent;
    }

    .btn-nav.today:hover {
        box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
    }

    /* ===== LEGEND ===== */
    .calendar-legend {
        display: flex;
        align-items: center;
        gap: 24px;
        margin-bottom: 24px;
        padding: 16px 24px;
        background: var(--white);
        border-radius: var(--radius);
        box-shadow: var(--shadow-sm);
    }

    .legend-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        color: var(--gray-600);
    }

    .legend-dot {
        width: 14px;
        height: 14px;
        border-radius: 4px;
    }

    .legend-dot.reserved {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
    }

    .legend-dot.available {
        background: var(--gray-100);
        border: 2px solid var(--gray-300);
    }

    .legend-dot.today {
        background: linear-gradient(135deg, var(--accent) 0%, var(--accent-light) 100%);
    }

    .legend-dot.pending {
        background: linear-gradient(135deg, var(--warning) 0%, #FBBF24 100%);
    }

    .legend-dot.confirmed {
        background: linear-gradient(135deg, var(--success) 0%, #34D399 100%);
    }

    /* ===== CALENDAR CARD ===== */
    .calendar-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .calendar-wrapper {
        max-height: 600px;
        overflow: auto;
    }

    /* Custom scrollbar */
    .calendar-wrapper::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }

    .calendar-wrapper::-webkit-scrollbar-track {
        background: var(--gray-100);
    }

    .calendar-wrapper::-webkit-scrollbar-thumb {
        background: var(--gray-300);
        border-radius: 4px;
    }

    .calendar-wrapper::-webkit-scrollbar-thumb:hover {
        background: var(--gray-400);
    }

    /* ===== CALENDAR TABLE ===== */
    .calendar-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 800px;
    }

    .calendar-table th,
    .calendar-table td {
        border: 1px solid var(--gray-100);
        padding: 12px 8px;
        text-align: center;
        min-width: 120px;
        vertical-align: top;
    }

    .calendar-table thead th {
        position: sticky;
        top: 0;
        background: linear-gradient(135deg, var(--gray-50) 0%, var(--white) 100%);
        z-index: 10;
        font-weight: 600;
        font-size: 13px;
        color: var(--gray-700);
        padding: 16px 8px;
        border-bottom: 2px solid var(--gray-200);
    }

    .calendar-table thead th.today-header {
        background: linear-gradient(135deg, var(--accent-light) 0%, #FEF3C7 100%);
        color: var(--dark);
    }

    .calendar-table thead th .day-name {
        display: block;
        font-size: 11px;
        color: var(--gray-500);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 4px;
    }

    .calendar-table thead th .day-date {
        font-size: 14px;
        font-weight: 600;
    }

    .time-cell {
        font-weight: 600;
        color: var(--gray-600);
        background: var(--gray-50);
        font-size: 13px;
        min-width: 80px !important;
    }

    /* Cell states */
    .cell-empty {
        background: var(--white);
        transition: var(--transition);
    }

    .cell-empty:hover {
        background: var(--gray-50);
    }

    .cell-empty.today-col {
        background: linear-gradient(135deg, #FFFBEB 0%, #FEF3C7 30%);
    }

    .cell-reserved {
        background: linear-gradient(135deg, var(--primary-lighter) 0%, #C7D2FE 100%);
        padding: 8px !important;
    }

    /* ===== RESERVATION BLOCK ===== */
    .reservation-block {
        background: var(--white);
        border-radius: var(--radius-sm);
        padding: 10px;
        box-shadow: var(--shadow-sm);
        border-left: 4px solid var(--primary);
        text-align: left;
    }

    .reservation-block.status-EN_ATTENTE {
        border-left-color: var(--warning);
    }

    .reservation-block.status-CONFIRMEE {
        border-left-color: var(--success);
    }

    .reservation-block.status-REFUSEE {
        border-left-color: var(--danger);
    }

    .reservation-block.status-ANNULEE {
        border-left-color: var(--gray-400);
        opacity: 0.7;
    }

    .reservation-room {
        font-weight: 600;
        font-size: 13px;
        color: var(--dark);
        margin-bottom: 4px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .reservation-room i {
        color: var(--primary);
        font-size: 12px;
    }

    .reservation-time {
        font-size: 11px;
        color: var(--gray-500);
        margin-bottom: 6px;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .reservation-time i {
        font-size: 10px;
    }

    /* Status badges */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 10px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }

    .status-badge.EN_ATTENTE {
        background: var(--warning-light);
        color: #B45309;
    }

    .status-badge.CONFIRMEE {
        background: var(--success-light);
        color: #047857;
    }

    .status-badge.REFUSEE {
        background: var(--danger-light);
        color: #B91C1C;
    }

    .status-badge.ANNULEE {
        background: var(--gray-100);
        color: var(--gray-600);
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .week-navigation {
            width: 100%;
            flex-wrap: wrap;
        }

        .btn-nav {
            flex: 1;
            justify-content: center;
        }

        .calendar-legend {
            flex-wrap: wrap;
            gap: 16px;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-calendar-alt"></i>
        </div>
        <div class="page-title">
            <h1>Mon Calendrier</h1>
            <p>Semaine du ${startDate} au ${endDate}</p>
        </div>
    </div>

    <div class="week-navigation">
        <a href="${pageContext.request.contextPath}/user/calendar?startDate=${prevWeek}" class="btn-nav">
            <i class="fas fa-chevron-left"></i>
            Semaine précédente
        </a>
        <a href="${pageContext.request.contextPath}/user/calendar" class="btn-nav today">
            <i class="fas fa-calendar-day"></i>
            Aujourd'hui
        </a>
        <a href="${pageContext.request.contextPath}/user/calendar?startDate=${nextWeek}" class="btn-nav">
            Semaine suivante
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
</div>

<!-- ===== LEGEND ===== -->
<div class="calendar-legend">
    <div class="legend-item">
        <span class="legend-dot reserved"></span>
        <span>Réservation</span>
    </div>
    <div class="legend-item">
        <span class="legend-dot available"></span>
        <span>Disponible</span>
    </div>
    <div class="legend-item">
        <span class="legend-dot today"></span>
        <span>Jour actuel</span>
    </div>
    <div class="legend-item">
        <span class="legend-dot pending"></span>
        <span>En attente</span>
    </div>
    <div class="legend-item">
        <span class="legend-dot confirmed"></span>
        <span>Confirmée</span>
    </div>
</div>

<!-- ===== CALENDAR ===== -->
<div class="calendar-card">
    <div class="calendar-wrapper">
        <table class="calendar-table">
            <thead>
                <tr>
                    <th class="time-cell">
                        <i class="fas fa-clock"></i>
                    </th>
                    <c:forEach var="d" items="${days}">
                        <th class="${d == today ? 'today-header' : ''}">
                            <span class="day-name">
                                <%-- You can add day names here --%>
                            </span>
                            <span class="day-date">${d}</span>
                        </th>
                    </c:forEach>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="h" items="${hours}">
                    <tr>
                        <td class="time-cell">
                            <i class="fas fa-clock" style="margin-right: 4px; font-size: 10px; opacity: 0.5;"></i>
                            ${h}:00
                        </td>
                        <c:forEach var="d" items="${days}">
                            <c:set var="key" value="${d}_${h}" />
                            <c:choose>
                                <c:when test="${not empty grid[key]}">
                                    <td class="cell-reserved">
                                        <div class="reservation-block status-${grid[key].statut}">
                                            <div class="reservation-room">
                                                <i class="fas fa-door-open"></i>
                                                ${grid[key].salleNom}
                                            </div>
                                            <div class="reservation-time">
                                                <i class="fas fa-clock"></i>
                                                ${grid[key].dateHeureDebut} - ${grid[key].dateHeureFin}
                                            </div>
                                            <span class="status-badge ${grid[key].statut}">
                                                <c:choose>
                                                    <c:when test="${grid[key].statut == 'EN_ATTENTE'}">
                                                        <i class="fas fa-hourglass-half"></i>
                                                    </c:when>
                                                    <c:when test="${grid[key].statut == 'CONFIRMEE'}">
                                                        <i class="fas fa-check-circle"></i>
                                                    </c:when>
                                                    <c:when test="${grid[key].statut == 'REFUSEE'}">
                                                        <i class="fas fa-times-circle"></i>
                                                    </c:when>
                                                    <c:when test="${grid[key].statut == 'ANNULEE'}">
                                                        <i class="fas fa-ban"></i>
                                                    </c:when>
                                                </c:choose>
                                                ${grid[key].statut}
                                            </span>
                                        </div>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td class="cell-empty ${d == today ? 'today-col' : ''}"></td>
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