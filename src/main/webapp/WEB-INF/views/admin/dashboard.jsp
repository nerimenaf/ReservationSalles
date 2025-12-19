<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Dashboard - Roomify Center Admin" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== DASHBOARD HEADER ===== */
    .dashboard-header {
        margin-bottom: 32px;
    }

    .welcome-banner {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        border-radius: var(--radius-lg);
        padding: 40px;
        color: var(--white);
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 40px rgba(79, 70, 229, 0.3);
    }

    .welcome-banner::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 60%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
    }

    .welcome-banner::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: -10%;
        width: 40%;
        height: 150%;
        background: radial-gradient(circle, rgba(245, 158, 11, 0.2) 0%, transparent 60%);
    }

    .welcome-content {
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 24px;
    }

    .welcome-text h1 {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .welcome-text p {
        font-size: 16px;
        opacity: 0.9;
        margin: 0;
    }

    .welcome-stats {
        display: flex;
        gap: 32px;
    }

    .welcome-stat {
        text-align: center;
    }

    .welcome-stat-value {
        font-size: 32px;
        font-weight: 700;
        display: block;
    }

    .welcome-stat-label {
        font-size: 13px;
        opacity: 0.8;
    }

    /* ===== QUICK ACTIONS GRID ===== */
    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-title i {
        color: var(--primary);
    }

    .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        margin-bottom: 40px;
    }

    .action-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        padding: 28px;
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-100);
        transition: var(--transition);
        text-decoration: none;
        display: flex;
        align-items: flex-start;
        gap: 20px;
        position: relative;
        overflow: hidden;
    }

    .action-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 4px;
        height: 100%;
        background: var(--primary);
        transform: scaleY(0);
        transition: var(--transition);
    }

    .action-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
    }

    .action-card:hover::before {
        transform: scaleY(1);
    }

    .action-icon {
        width: 56px;
        height: 56px;
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        flex-shrink: 0;
    }

    .action-icon.users {
        background: linear-gradient(135deg, #DBEAFE 0%, #BFDBFE 100%);
        color: #2563EB;
    }

    .action-icon.rooms {
        background: linear-gradient(135deg, #D1FAE5 0%, #A7F3D0 100%);
        color: #059669;
    }

    .action-icon.reservations {
        background: linear-gradient(135deg, #FEF3C7 0%, #FDE68A 100%);
        color: #D97706;
    }

    .action-icon.stats {
        background: linear-gradient(135deg, #E0E7FF 0%, #C7D2FE 100%);
        color: #4F46E5;
    }

    .action-icon.calendar {
        background: linear-gradient(135deg, #FCE7F3 0%, #FBCFE8 100%);
        color: #DB2777;
    }

    .action-icon.reviews {
        background: linear-gradient(135deg, #FEE2E2 0%, #FECACA 100%);
        color: #DC2626;
    }

    .action-content {
        flex: 1;
    }

    .action-title {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 6px;
    }

    .action-description {
        font-size: 14px;
        color: var(--gray-500);
        margin-bottom: 12px;
        line-height: 1.5;
    }

    .action-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 13px;
        font-weight: 600;
        color: var(--primary);
    }

    .action-link i {
        transition: var(--transition);
    }

    .action-card:hover .action-link i {
        transform: translateX(4px);
    }

    /* ===== RECENT ACTIVITY ===== */
    .activity-section {
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 24px;
    }

    .activity-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-100);
        overflow: hidden;
    }

    .activity-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .activity-header h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .activity-header h3 i {
        color: var(--primary);
    }

    .view-all-link {
        font-size: 13px;
        color: var(--primary);
        font-weight: 500;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .view-all-link:hover {
        text-decoration: underline;
    }

    .activity-list {
        padding: 0;
        margin: 0;
        list-style: none;
    }

    .activity-item {
        padding: 16px 24px;
        border-bottom: 1px solid var(--gray-50);
        display: flex;
        align-items: center;
        gap: 16px;
        transition: var(--transition);
    }

    .activity-item:last-child {
        border-bottom: none;
    }

    .activity-item:hover {
        background: var(--gray-50);
    }

    .activity-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 14px;
        flex-shrink: 0;
    }

    .activity-avatar.pending {
        background: var(--warning-light);
        color: var(--warning);
    }

    .activity-avatar.confirmed {
        background: var(--success-light);
        color: var(--success);
    }

    .activity-info {
        flex: 1;
    }

    .activity-text {
        font-size: 14px;
        color: var(--dark);
        margin-bottom: 2px;
    }

    .activity-text strong {
        font-weight: 600;
    }

    .activity-meta {
        font-size: 12px;
        color: var(--gray-500);
    }

    /* Quick Stats Card */
    .quick-stats-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-100);
    }

    .quick-stats-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
    }

    .quick-stats-header h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .quick-stats-header h3 i {
        color: var(--primary);
    }

    .quick-stats-list {
        padding: 16px 24px;
    }

    .quick-stat-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: 1px solid var(--gray-50);
    }

    .quick-stat-item:last-child {
        border-bottom: none;
    }

    .quick-stat-label {
        font-size: 14px;
        color: var(--gray-600);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .quick-stat-label i {
        width: 20px;
        color: var(--gray-400);
    }

    .quick-stat-value {
        font-size: 18px;
        font-weight: 700;
        color: var(--dark);
    }

    .quick-stat-value.pending {
        color: var(--warning);
    }

    .quick-stat-value.success {
        color: var(--success);
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 1024px) {
        .activity-section {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .welcome-banner {
            padding: 24px;
        }

        .welcome-content {
            flex-direction: column;
            text-align: center;
        }

        .welcome-stats {
            justify-content: center;
        }

        .actions-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- ===== DASHBOARD HEADER ===== -->
<div class="dashboard-header">
    <div class="welcome-banner">
        <div class="welcome-content">
            <div class="welcome-text">
                <h1>Bienvenue, ${userSession.nomComplet} 👋</h1>
                <p>Voici un aperçu de votre application Roomify Center</p>
            </div>
            <div class="welcome-stats">
                <div class="welcome-stat">
                    <span class="welcome-stat-value">
                        <c:out value="${totalSalles}" default="0"/>
                    </span>
                    <span class="welcome-stat-label">Salles</span>
                </div>
                <div class="welcome-stat">
                    <span class="welcome-stat-value">
                        <c:out value="${totalUsers}" default="0"/>
                    </span>
                    <span class="welcome-stat-label">Utilisateurs</span>
                </div>
                <div class="welcome-stat">
                    <span class="welcome-stat-value">
                        <c:out value="${pendingReservations}" default="0"/>
                    </span>
                    <span class="welcome-stat-label">En attente</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ===== QUICK ACTIONS ===== -->
<h2 class="section-title">
    <i class="fas fa-th-large"></i>
    Accès rapide
</h2>

<div class="actions-grid">
    <a href="${pageContext.request.contextPath}/admin/users" class="action-card">
        <div class="action-icon users">
            <i class="fas fa-users"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Utilisateurs</h3>
            <p class="action-description">Gérer les comptes utilisateurs et leurs rôles d'accès</p>
            <span class="action-link">
                Gérer <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>

    <a href="${pageContext.request.contextPath}/admin/salles" class="action-card">
        <div class="action-icon rooms">
            <i class="fas fa-door-open"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Salles</h3>
            <p class="action-description">Ajouter, modifier et gérer les salles de réunion</p>
            <span class="action-link">
                Gérer <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>

    <a href="${pageContext.request.contextPath}/admin/reservations" class="action-card">
        <div class="action-icon reservations">
            <i class="fas fa-calendar-check"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Réservations</h3>
            <p class="action-description">Valider, refuser ou annuler les demandes de réservation</p>
            <span class="action-link">
                Gérer <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>

    <a href="${pageContext.request.contextPath}/admin/stats" class="action-card">
        <div class="action-icon stats">
            <i class="fas fa-chart-bar"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Statistiques</h3>
            <p class="action-description">Analyser le taux d'utilisation et les tendances</p>
            <span class="action-link">
                Voir <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>

    <a href="${pageContext.request.contextPath}/admin/calendar" class="action-card">
        <div class="action-icon calendar">
            <i class="fas fa-calendar-alt"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Calendrier</h3>
            <p class="action-description">Vue calendrier des réservations par salle</p>
            <span class="action-link">
                Voir <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>

    <a href="${pageContext.request.contextPath}/admin/avis" class="action-card">
        <div class="action-icon reviews">
            <i class="fas fa-star"></i>
        </div>
        <div class="action-content">
            <h3 class="action-title">Avis</h3>
            <p class="action-description">Consulter et modérer les avis sur les salles</p>
            <span class="action-link">
                Gérer <i class="fas fa-arrow-right"></i>
            </span>
        </div>
    </a>
</div>


<div class="activity-section">

    <div class="activity-card">
        <div class="activity-header">
            <h3>
                <i class="fas fa-clock"></i>
                Réservations récentes
            </h3>
            <a href="${pageContext.request.contextPath}/admin/reservations" class="view-all-link">
                Voir tout <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <ul class="activity-list">
            <c:choose>
                <c:when test="${not empty recentReservations}">
                    <c:forEach var="r" items="${recentReservations}" end="4">
                        <li class="activity-item">
                            <div class="activity-avatar ${r.statut == 'EN_ATTENTE' ? 'pending' : 'confirmed'}">
                                <i class="fas ${r.statut == 'EN_ATTENTE' ? 'fa-hourglass-half' : 'fa-check'}"></i>
                            </div>
                            <div class="activity-info">
                                <div class="activity-text">
                                    <strong>${r.utilisateurLogin}</strong> a réservé <strong>${r.salleNom}</strong>
                                </div>
                                <div class="activity-meta">
                                    ${r.dateHeureDebut} - ${r.dateHeureFin}
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="activity-item">
                        <div class="activity-info" style="text-align: center; width: 100%; color: var(--gray-500);">
                            <i class="fas fa-inbox" style="font-size: 24px; margin-bottom: 8px;"></i>
                            <p>Aucune réservation récente</p>
                        </div>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>


<div class="quick-stats-card">
    <div class="quick-stats-header">
        <h3>
            <i class="fas fa-chart-pie"></i>
            Aperçu rapide
        </h3>
    </div>
    <div class="quick-stats-list">
        <div class="quick-stat-item">
            <span class="quick-stat-label">
                <i class="fas fa-hourglass-half"></i>
                En attente
            </span>
            <span class="quick-stat-value pending">
                <c:out value="${pendingReservations}" default="0"/>
            </span>
        </div>
        <div class="quick-stat-item">
            <span class="quick-stat-label">
                <i class="fas fa-check-circle"></i>
                Confirmées
            </span>
            <span class="quick-stat-value success">
                <c:out value="${confirmedReservations}" default="0"/>
            </span>
        </div>
        <div class="quick-stat-item">
            <span class="quick-stat-label">
                <i class="fas fa-door-open"></i>
                Salles actives
            </span>
            <span class="quick-stat-value">
                <c:out value="${totalSalles}" default="0"/>
            </span>
        </div>
        <div class="quick-stat-item">
            <span class="quick-stat-label">
                <i class="fas fa-users"></i>
                Utilisateurs
            </span>
            <span class="quick-stat-value">
                <c:out value="${totalUsers}" default="0"/>
            </span>
        </div>
        <div class="quick-stat-item">
            <span class="quick-stat-label">
                <i class="fas fa-star"></i>
                Avis
            </span>
            <span class="quick-stat-value">
                <c:out value="${totalAvis}" default="0"/>
            </span>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />