<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Calendrier Salles - Roomify Center" scope="request"/>
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
        background: linear-gradient(135deg, #EC4899 0%, #BE185D 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 24px;
        box-shadow: 0 8px 20px rgba(236, 72, 153, 0.3);
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

    /* ===== FILTER CARD ===== */
    .filter-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        padding: 24px;
        box-shadow: var(--shadow);
        margin-bottom: 24px;
        border: 1px solid var(--gray-100);
    }

    .filter-form {
        display: flex;
        align-items: flex-end;
        gap: 20px;
        flex-wrap: wrap;
    }

    .filter-group {
        flex: 1;
        min-width: 200px;
    }

    .filter-group label {
        display: block;
        font-size: 13px;
        font-weight: 600;
        color: var(--gray-700);
        margin-bottom: 8px;
    }

    .filter-select {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: var(--transition);
        background: var(--gray-50);
        cursor: pointer;
    }

    .filter-select:focus {
        outline: none;
        border-color: #EC4899;
        background: var(--white);
    }

    .btn-filter {
        padding: 12px 28px;
        background: linear-gradient(135deg, #EC4899 0%, #BE185D 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-filter:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(236, 72, 153, 0.4);
    }

    /* ===== SELECTED ROOM INFO ===== */
    .room-info-bar {
        background: linear-gradient(135deg, #FCE7F3 0%, #FBCFE8 100%);
        border-radius: var(--radius);
        padding: 20px 24px;
        margin-bottom: 24px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 16px;
    }

    .room-info-content {
        display: flex;
        align-items: center;
        gap: 16px;
    }

    .room-info-icon {
        width: 48px;
        height: 48px;
        background: var(--white);
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #EC4899;
        font-size: 20px;
    }

    .room-info-details h2 {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin: 0 0 4px 0;
    }

    .room-info-details p {
        font-size: 14px;
        color: var(--gray-600);
        margin: 0;
    }

    .week-nav {
        display: flex;
        gap: 8px;
    }

    .btn-nav {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 500;
        color: var(--gray-700);
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
    }

    .btn-nav:hover {
        background: #EC4899;
        color: var(--white);
    }

    /* ===== CALENDAR ===== */
    .calendar-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .calendar-wrapper {
        overflow-x: auto;
        max-height: 600px;
    }

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

    .time-cell {
        font-weight: 600;
        color: var(--gray-600);
        background: var(--gray-50);
        font-size: 13px;
        min-width: 80px !important;
    }

    .cell-empty {
        background: var(--white);
        transition: var(--transition);
    }

    .cell-empty:hover {
        background: var(--gray-50);
    }

    .cell-reserved {
        background: linear-gradient(135deg, #D1FAE5 0%, #A7F3D0 100%);
        padding: 8px !important;
    }

    .reservation-block {
        background: var(--white);
        border-radius: var(--radius-sm);
        padding: 10px;
        box-shadow: var(--shadow-sm);
        border-left: 4px solid var(--success);
        text-align: left;
    }

    .reservation-block.status-EN_ATTENTE {
        border-left-color: var(--warning);
    }

    .reservation-user {
        font-weight: 600;
        font-size: 13px;
        color: var(--dark);
        margin-bottom: 4px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .reservation-user i {
        color: var(--success);
        font-size: 12px;
    }

    .reservation-time {
        font-size: 11px;
        color: var(--gray-500);
        margin-bottom: 6px;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 10px;
        font-weight: 600;
    }

    .status-badge.EN_ATTENTE {
        background: var(--warning-light);
        color: #B45309;
    }

    .status-badge.CONFIRMEE {
        background: var(--success-light);
        color: #047857;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .filter-form {
            flex-direction: column;
        }

        .filter-group {
            width: 100%;
        }

        .room-info-bar {
            flex-direction: column;
            align-items: flex-start;
        }

        .week-nav {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-calendar-week"></i>
        </div>
        <div class="page-title">
            <h1>Calendrier par Salle</h1>
            <p>Visualisez les réservations de chaque salle</p>
        </div>
    </div>
</div>

<!-- ===== FILTER CARD ===== -->
<div class="filter-card">
    <form method="get" action="${pageContext.request.contextPath}/admin/calendar" class="filter-form">
        <div class="filter-group">
            <label for="salleId">
                <i class="fas fa-door-open"></i>
                Sélectionner une salle
            </label>
            <select id="salleId" name="salleId" class="filter-select" required>
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

        <button type="submit" class="btn-filter">
            <i class="fas fa-calendar-alt"></i>
            Afficher le calendrier
        </button>
    </form>
</div>

<!-- ===== SELECTED ROOM INFO & CALENDAR ===== -->
<c:if test="${selectedSalle != null}">
    <!-- Room Info Bar -->
    <div class="room-info-bar">
        <div class="room-info-content">
            <div class="room-info-icon">
                <i class="fas fa-door-open"></i>
            </div>
            <div class="room-info-details">
                <h2>${selectedSalle.nom}</h2>
                <p>Semaine du ${startDate} au ${endDate}</p>
            </div>
        </div>
        <div class="week-nav">
            <a href="${pageContext.request.contextPath}/admin/calendar?salleId=${selectedSalle.id}&startDate=${prevWeek}" 
               class="btn-nav">
                <i class="fas fa-chevron-left"></i>
                Semaine précédente
            </a>
            <a href="${pageContext.request.contextPath}/admin/calendar?salleId=${selectedSalle.id}&startDate=${nextWeek}" 
               class="btn-nav">
                Semaine suivante
                <i class="fas fa-chevron-right"></i>
            </a>
        </div>
    </div>

    <!-- Calendar -->
    <div class="calendar-card">
        <div class="calendar-wrapper">
            <table class="calendar-table">
                <thead>
                    <tr>
                        <th class="time-cell">
                            <i class="fas fa-clock"></i>
                        </th>
                        <c:forEach var="d" items="${days}">
                            <th>${d}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="h" items="${hours}">
                        <tr>
                            <td class="time-cell">${h}:00</td>
                            <c:forEach var="d" items="${days}">
                                <c:set var="key" value="${d}_${h}" />
                                <c:choose>
                                    <c:when test="${not empty grid[key]}">
                                        <td class="cell-reserved">
                                            <div class="reservation-block status-${grid[key].statut}">
                                                <div class="reservation-user">
                                                    <i class="fas fa-user"></i>
                                                    ${grid[key].utilisateurLogin}
                                                </div>
                                                <div class="reservation-time">
                                                    ${grid[key].dateHeureDebut} - ${grid[key].dateHeureFin}
                                                </div>
                                                <span class="status-badge ${grid[key].statut}">
                                                    ${grid[key].statut}
                                                </span>
                                            </div>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="cell-empty"></td>
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