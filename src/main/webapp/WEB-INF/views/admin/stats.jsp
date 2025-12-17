<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Statistiques - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== PAGE HEADER ===== */
    .page-header {
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
        background: linear-gradient(135deg, var(--info) 0%, #1D4ED8 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 24px;
        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
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

    /* ===== STATS GRID ===== */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px;
        margin-bottom: 32px;
    }

    .stat-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        padding: 28px;
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-100);
        position: relative;
        overflow: hidden;
    }

    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 100px;
        height: 100px;
        border-radius: 50%;
        opacity: 0.1;
        transform: translate(30%, -30%);
    }

    .stat-card.primary::before { background: var(--primary); }
    .stat-card.success::before { background: var(--success); }
    .stat-card.warning::before { background: var(--warning); }
    .stat-card.danger::before { background: var(--danger); }

    .stat-icon {
        width: 52px;
        height: 52px;
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        margin-bottom: 16px;
    }

    .stat-card.primary .stat-icon {
        background: var(--primary-lighter);
        color: var(--primary);
    }

    .stat-card.success .stat-icon {
        background: var(--success-light);
        color: var(--success);
    }

    .stat-card.warning .stat-icon {
        background: var(--warning-light);
        color: var(--warning);
    }

    .stat-card.danger .stat-icon {
        background: var(--danger-light);
        color: var(--danger);
    }

    .stat-value {
        font-size: 36px;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 4px;
        line-height: 1;
    }

    .stat-label {
        font-size: 14px;
        color: var(--gray-500);
    }

    /* ===== CONTENT GRID ===== */
    .content-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    .content-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-100);
        overflow: hidden;
    }

    .content-card.full-width {
        grid-column: 1 / -1;
    }

    .content-card-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .content-card-header i {
        font-size: 18px;
        color: var(--primary);
    }

    .content-card-header h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
    }

    /* Status Distribution */
    .status-list {
        padding: 0;
    }

    .status-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 16px 24px;
        border-bottom: 1px solid var(--gray-100);
    }

    .status-item:last-child {
        border-bottom: none;
    }

    .status-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .status-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
    }

    .status-dot.EN_ATTENTE { background: var(--warning); }
    .status-dot.CONFIRMEE { background: var(--success); }
    .status-dot.REFUSEE { background: var(--danger); }
    .status-dot.ANNULEE { background: var(--gray-400); }

    .status-name {
        font-weight: 500;
        color: var(--dark);
    }

    .status-count {
        font-weight: 700;
        font-size: 18px;
        color: var(--primary);
    }

    /* Progress bar */
    .status-progress {
        width: 100%;
        margin-top: 8px;
    }

    .progress-bar {
        height: 6px;
        background: var(--gray-100);
        border-radius: 3px;
        overflow: hidden;
    }

    .progress-fill {
        height: 100%;
        border-radius: 3px;
        transition: width 0.5s ease;
    }

    .progress-fill.EN_ATTENTE { background: var(--warning); }
    .progress-fill.CONFIRMEE { background: var(--success); }
    .progress-fill.REFUSEE { background: var(--danger); }
    .progress-fill.ANNULEE { background: var(--gray-400); }

    /* Top Rooms */
    .top-room-item {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 16px 24px;
        border-bottom: 1px solid var(--gray-100);
    }

    .top-room-item:last-child {
        border-bottom: none;
    }

    .room-rank {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 14px;
        flex-shrink: 0;
    }

    .room-rank.rank-1 {
        background: linear-gradient(135deg, #FCD34D 0%, #F59E0B 100%);
        color: var(--white);
    }

    .room-rank.rank-2 {
        background: linear-gradient(135deg, #E5E7EB 0%, #9CA3AF 100%);
        color: var(--white);
    }

    .room-rank.rank-3 {
        background: linear-gradient(135deg, #FED7AA 0%, #FB923C 100%);
        color: var(--white);
    }

    .room-rank.rank-other {
        background: var(--gray-100);
        color: var(--gray-600);
    }

    .room-details {
        flex: 1;
    }

    .room-name {
        font-weight: 600;
        color: var(--dark);
        font-size: 15px;
    }

    .room-bar {
        height: 8px;
        background: var(--gray-100);
        border-radius: 4px;
        margin-top: 8px;
        overflow: hidden;
    }

    .room-bar-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--primary) 0%, var(--primary-light) 100%);
        border-radius: 4px;
    }

    .room-count {
        font-weight: 700;
        font-size: 20px;
        color: var(--primary);
        text-align: right;
        min-width: 50px;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 40px 20px;
        color: var(--gray-500);
    }

    .empty-state i {
        font-size: 48px;
        color: var(--gray-300);
        margin-bottom: 16px;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 1200px) {
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .stats-grid {
            grid-template-columns: 1fr;
        }

        .content-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-chart-bar"></i>
        </div>
        <div class="page-title">
            <h1>Statistiques</h1>
            <p>Analysez l'utilisation des salles et les tendances de réservation</p>
        </div>
    </div>
</div>

<!-- ===== STATS GRID ===== -->
<div class="stats-grid">
    <div class="stat-card primary">
        <div class="stat-icon">
            <i class="fas fa-calendar-check"></i>
        </div>
        <div class="stat-value">${totalReservations}</div>
        <div class="stat-label">Total réservations</div>
    </div>

    <div class="stat-card success">
        <div class="stat-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="stat-value">
            <c:set var="confirmedCount" value="0"/>
            <c:forEach var="entry" items="${statsByStatus}">
                <c:if test="${entry.key == 'CONFIRMEE'}">
                    <c:set var="confirmedCount" value="${entry.value}"/>
                </c:if>
            </c:forEach>
            ${confirmedCount}
        </div>
        <div class="stat-label">Confirmées</div>
    </div>

    <div class="stat-card warning">
        <div class="stat-icon">
            <i class="fas fa-hourglass-half"></i>
        </div>
        <div class="stat-value">
            <c:set var="pendingCount" value="0"/>
            <c:forEach var="entry" items="${statsByStatus}">
                <c:if test="${entry.key == 'EN_ATTENTE'}">
                    <c:set var="pendingCount" value="${entry.value}"/>
                </c:if>
            </c:forEach>
            ${pendingCount}
        </div>
        <div class="stat-label">En attente</div>
    </div>

    <div class="stat-card danger">
        <div class="stat-icon">
            <i class="fas fa-times-circle"></i>
        </div>
        <div class="stat-value">
            <c:set var="refusedCount" value="0"/>
            <c:forEach var="entry" items="${statsByStatus}">
                <c:if test="${entry.key == 'REFUSEE' || entry.key == 'ANNULEE'}">
                    <c:set var="refusedCount" value="${refusedCount + entry.value}"/>
                </c:if>
            </c:forEach>
            ${refusedCount}
        </div>
        <div class="stat-label">Refusées/Annulées</div>
    </div>
</div>

<!-- ===== CONTENT GRID ===== -->
<div class="content-grid">
    <!-- Status Distribution -->
    <div class="content-card">
        <div class="content-card-header">
            <i class="fas fa-chart-pie"></i>
            <h3>Répartition par statut</h3>
        </div>
        <div class="status-list">
            <c:forEach var="entry" items="${statsByStatus}">
                <div class="status-item">
                    <div style="flex: 1;">
                        <div class="status-info">
                            <span class="status-dot ${entry.key}"></span>
                            <span class="status-name">${entry.key}</span>
                        </div>
                        <div class="status-progress">
                            <div class="progress-bar">
                                <div class="progress-fill ${entry.key}" 
                                     style="width: ${totalReservations > 0 ? (entry.value * 100 / totalReservations) : 0}%">
                                </div>
                            </div>
                        </div>
                    </div>
                    <span class="status-count">${entry.value}</span>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Top Rooms -->
    <div class="content-card">
        <div class="content-card-header">
            <i class="fas fa-trophy"></i>
            <h3>Top 5 des salles les plus réservées</h3>
        </div>
        <c:choose>
            <c:when test="${empty topSalles}">
                <div class="empty-state">
                    <i class="fas fa-chart-bar"></i>
                    <p>Pas encore de réservations</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:set var="maxCount" value="0"/>
                <c:forEach var="s" items="${topSalles}">
                    <c:if test="${s.nombreReservations > maxCount}">
                        <c:set var="maxCount" value="${s.nombreReservations}"/>
                    </c:if>
                </c:forEach>
                
                <c:forEach var="s" items="${topSalles}" varStatus="status">
                    <div class="top-room-item">
                        <div class="room-rank rank-${status.index < 3 ? (status.index + 1) : 'other'}">
                            ${status.index + 1}
                        </div>
                        <div class="room-details">
                            <div class="room-name">${s.nomSalle}</div>
                            <div class="room-bar">
                                <div class="room-bar-fill" 
                                     style="width: ${maxCount > 0 ? (s.nombreReservations * 100 / maxCount) : 0}%">
                                </div>
                            </div>
                        </div>
                        <div class="room-count">${s.nombreReservations}</div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />