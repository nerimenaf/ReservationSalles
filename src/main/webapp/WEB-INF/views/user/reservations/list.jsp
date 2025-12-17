<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Mes Réservations - Roomify Center" scope="request"/>
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

    .btn-new-reservation {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 24px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: var(--transition);
        box-shadow: 0 4px 14px rgba(79, 70, 229, 0.4);
    }

    .btn-new-reservation:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(79, 70, 229, 0.5);
        color: var(--white);
    }

    /* ===== ALERTS ===== */
    .alert-custom {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        border-radius: var(--radius);
        margin-bottom: 24px;
    }

    .alert-danger-custom {
        background: linear-gradient(135deg, #FEE2E2 0%, #FECACA 100%);
        border-left: 4px solid var(--danger);
        color: #991B1B;
    }

    .alert-success-custom {
        background: linear-gradient(135deg, #D1FAE5 0%, #A7F3D0 100%);
        border-left: 4px solid var(--success);
        color: #047857;
    }

    /* ===== STATS CARDS ===== */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 32px;
    }

    .stat-card {
        background: var(--white);
        border-radius: var(--radius);
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 16px;
        box-shadow: var(--shadow-sm);
        border: 1px solid var(--gray-100);
    }

    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }

    .stat-icon.total {
        background: var(--primary-lighter);
        color: var(--primary);
    }

    .stat-icon.pending {
        background: var(--warning-light);
        color: var(--warning);
    }

    .stat-icon.confirmed {
        background: var(--success-light);
        color: var(--success);
    }

    .stat-icon.cancelled {
        background: var(--gray-100);
        color: var(--gray-500);
    }

    .stat-content h3 {
        font-size: 24px;
        font-weight: 700;
        color: var(--dark);
        margin: 0;
    }

    .stat-content p {
        font-size: 13px;
        color: var(--gray-500);
        margin: 0;
    }

    /* ===== TABLE CARD ===== */
    .table-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .table-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
    }

    .table-header h2 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .reservations-table {
        width: 100%;
        border-collapse: collapse;
    }

    .reservations-table thead {
        background: var(--gray-50);
    }

    .reservations-table th {
        padding: 14px 20px;
        text-align: left;
        font-size: 12px;
        font-weight: 600;
        color: var(--gray-600);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid var(--gray-200);
    }

    .reservations-table td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--gray-100);
        font-size: 14px;
        color: var(--gray-700);
    }

    .reservations-table tbody tr {
        transition: var(--transition);
    }

    .reservations-table tbody tr:hover {
        background: var(--gray-50);
    }

    .reservations-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* Room cell */
    .room-cell {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .room-icon {
        width: 40px;
        height: 40px;
        background: var(--primary-lighter);
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 16px;
    }

    .room-name {
        font-weight: 600;
        color: var(--dark);
    }

    /* Date/Time cells */
    .datetime-cell {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .datetime-date {
        font-weight: 500;
        color: var(--dark);
    }

    .datetime-time {
        font-size: 12px;
        color: var(--gray-500);
        display: flex;
        align-items: center;
        gap: 4px;
    }

    /* Status badge */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
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

    .status-badge.REFUSEE {
        background: var(--danger-light);
        color: #B91C1C;
    }

    .status-badge.ANNULEE {
        background: var(--gray-100);
        color: var(--gray-600);
    }

    /* Comment cell */
    .comment-cell {
        max-width: 200px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        color: var(--gray-500);
        font-style: italic;
    }

    /* Actions */
    .actions-cell {
        display: flex;
        gap: 8px;
    }

    .btn-action-sm {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 8px 14px;
        border-radius: var(--radius-sm);
        font-size: 12px;
        font-weight: 500;
        transition: var(--transition);
        text-decoration: none;
        border: none;
        cursor: pointer;
        font-family: 'Poppins', sans-serif;
    }

    .btn-cancel {
        background: var(--danger-light);
        color: var(--danger);
    }

    .btn-cancel:hover {
        background: var(--danger);
        color: var(--white);
    }

    .btn-view {
        background: var(--primary-lighter);
        color: var(--primary);
    }

    .btn-view:hover {
        background: var(--primary);
        color: var(--white);
    }

    /* Empty state */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
    }

    .empty-state-icon {
        width: 80px;
        height: 80px;
        background: var(--gray-100);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 24px;
    }

    .empty-state-icon i {
        font-size: 36px;
        color: var(--gray-400);
    }

    .empty-state h3 {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 8px;
    }

    .empty-state p {
        color: var(--gray-500);
        font-size: 14px;
        margin-bottom: 24px;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 1024px) {
        .reservations-table {
            display: block;
            overflow-x: auto;
        }
    }

    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .btn-new-reservation {
            width: 100%;
            justify-content: center;
        }

        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-bookmark"></i>
        </div>
        <div class="page-title">
            <h1>Mes Réservations</h1>
            <p>Gérez toutes vos réservations de salles</p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/user/reservations?action=new" class="btn-new-reservation">
        <i class="fas fa-plus"></i>
        Nouvelle réservation
    </a>
</div>

<!-- ===== ERROR/SUCCESS ALERTS ===== -->
<c:if test="${not empty sessionScope.reservationError}">
    <div class="alert-custom alert-danger-custom">
        <i class="fas fa-exclamation-circle"></i>
        <span>${sessionScope.reservationError}</span>
    </div>
    <c:remove var="reservationError" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.reservationSuccess}">
    <div class="alert-custom alert-success-custom">
        <i class="fas fa-check-circle"></i>
        <span>${sessionScope.reservationSuccess}</span>
    </div>
    <c:remove var="reservationSuccess" scope="session"/>
</c:if>

<!-- ===== STATS CARDS ===== -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon total">
            <i class="fas fa-calendar-alt"></i>
        </div>
        <div class="stat-content">
            <h3>${reservations.size()}</h3>
            <p>Total réservations</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon pending">
            <i class="fas fa-hourglass-half"></i>
        </div>
        <div class="stat-content">
            <h3>
                <c:set var="pendingCount" value="0"/>
                <c:forEach var="r" items="${reservations}">
                    <c:if test="${r.statut == 'EN_ATTENTE'}">
                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${pendingCount}
            </h3>
            <p>En attente</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon confirmed">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="stat-content">
            <h3>
                <c:set var="confirmedCount" value="0"/>
                <c:forEach var="r" items="${reservations}">
                    <c:if test="${r.statut == 'CONFIRMEE'}">
                        <c:set var="confirmedCount" value="${confirmedCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${confirmedCount}
            </h3>
            <p>Confirmées</p>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon cancelled">
            <i class="fas fa-times-circle"></i>
        </div>
        <div class="stat-content">
            <h3>
                <c:set var="cancelledCount" value="0"/>
                <c:forEach var="r" items="${reservations}">
                    <c:if test="${r.statut == 'ANNULEE' || r.statut == 'REFUSEE'}">
                        <c:set var="cancelledCount" value="${cancelledCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${cancelledCount}
            </h3>
            <p>Annulées/Refusées</p>
        </div>
    </div>
</div>

<!-- ===== RESERVATIONS TABLE ===== -->
<div class="table-card">
    <div class="table-header">
        <h2>
            <i class="fas fa-list"></i>
            Liste des réservations
        </h2>
    </div>

    <c:choose>
        <c:when test="${empty reservations}">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h3>Aucune réservation</h3>
                <p>Vous n'avez pas encore effectué de réservation.</p>
                <a href="${pageContext.request.contextPath}/user/home" class="btn-new-reservation">
                    <i class="fas fa-search"></i>
                    Rechercher une salle
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="reservations-table">
                <thead>
                    <tr>
                        <th>Salle</th>
                        <th>Début</th>
                        <th>Fin</th>
                        <th>Statut</th>
                        <th>Commentaire</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${reservations}">
                        <tr>
                            <td>
                                <div class="room-cell">
                                    <div class="room-icon">
                                        <i class="fas fa-door-open"></i>
                                    </div>
                                    <span class="room-name">${r.salleNom}</span>
                                </div>
                            </td>
                            <td>
                                <div class="datetime-cell">
                                    <span class="datetime-date">${r.dateHeureDebut}</span>
                                </div>
                            </td>
                            <td>
                                <div class="datetime-cell">
                                    <span class="datetime-date">${r.dateHeureFin}</span>
                                </div>
                            </td>
                            <td>
                                <span class="status-badge ${r.statut}">
                                    <c:choose>
                                        <c:when test="${r.statut == 'EN_ATTENTE'}">
                                            <i class="fas fa-hourglass-half"></i>
                                        </c:when>
                                        <c:when test="${r.statut == 'CONFIRMEE'}">
                                            <i class="fas fa-check-circle"></i>
                                        </c:when>
                                        <c:when test="${r.statut == 'REFUSEE'}">
                                            <i class="fas fa-times-circle"></i>
                                        </c:when>
                                        <c:when test="${r.statut == 'ANNULEE'}">
                                            <i class="fas fa-ban"></i>
                                        </c:when>
                                    </c:choose>
                                    ${r.statut}
                                </span>
                            </td>
                            <td>
                                <span class="comment-cell">
                                    <c:out value="${r.commentaire}" default="—"/>
                                </span>
                            </td>
                            <td>
                                <div class="actions-cell">
                                    <c:if test="${r.statut != 'ANNULEE' && r.statut != 'REFUSEE'}">
                                        <a href="${pageContext.request.contextPath}/user/reservations?action=cancel&id=${r.id}"
                                           class="btn-action-sm btn-cancel"
                                           onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?');">
                                            <i class="fas fa-times"></i>
                                            Annuler
                                        </a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />