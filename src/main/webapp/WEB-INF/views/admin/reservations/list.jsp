<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Gestion Réservations - Roomify Center" scope="request"/>
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
        background: linear-gradient(135deg, var(--warning) 0%, #D97706 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 24px;
        box-shadow: 0 8px 20px rgba(245, 158, 11, 0.3);
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

    /* ===== FILTER TABS ===== */
    .filter-tabs {
        display: flex;
        gap: 8px;
        margin-bottom: 24px;
        flex-wrap: wrap;
    }

    .filter-tab {
        padding: 10px 20px;
        background: var(--white);
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 500;
        color: var(--gray-600);
        cursor: pointer;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .filter-tab:hover {
        border-color: var(--primary);
        color: var(--primary);
    }

    .filter-tab.active {
        background: var(--primary);
        border-color: var(--primary);
        color: var(--white);
    }

    .filter-tab .count {
        background: rgba(255,255,255,0.2);
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 12px;
    }

    .filter-tab.active .count {
        background: rgba(255,255,255,0.3);
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
        flex-wrap: wrap;
        gap: 16px;
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

    .search-box {
        display: flex;
        align-items: center;
        gap: 8px;
        background: var(--gray-50);
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        padding: 8px 16px;
        transition: var(--transition);
    }

    .search-box:focus-within {
        border-color: var(--primary);
        background: var(--white);
    }

    .search-box i {
        color: var(--gray-400);
    }

    .search-box input {
        border: none;
        background: transparent;
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        outline: none;
        width: 200px;
    }

    /* Table */
    .admin-table {
        width: 100%;
        border-collapse: collapse;
    }

    .admin-table thead {
        background: var(--gray-50);
    }

    .admin-table th {
        padding: 14px 20px;
        text-align: left;
        font-size: 12px;
        font-weight: 600;
        color: var(--gray-600);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid var(--gray-200);
    }

    .admin-table td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--gray-100);
        font-size: 14px;
        color: var(--gray-700);
        vertical-align: middle;
    }

    .admin-table tbody tr {
        transition: var(--transition);
    }

    .admin-table tbody tr:hover {
        background: var(--gray-50);
    }

    .admin-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* ID Cell */
    .id-cell {
        font-weight: 600;
        color: var(--gray-400);
        font-size: 12px;
    }

    /* Room/User Cell */
    .info-cell {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .info-icon {
        width: 40px;
        height: 40px;
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
    }

    .info-icon.room {
        background: var(--primary-lighter);
        color: var(--primary);
    }

    .info-icon.user {
        background: var(--success-light);
        color: var(--success);
    }

    .info-name {
        font-weight: 600;
        color: var(--dark);
    }

    /* Status Badge */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
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

    /* Comment */
    .comment-cell {
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        color: var(--gray-500);
        font-style: italic;
        font-size: 13px;
    }

    /* Actions */
    .actions-cell {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .btn-action {
        display: inline-flex;
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

    .btn-validate {
        background: var(--success-light);
        color: var(--success);
    }

    .btn-validate:hover {
        background: var(--success);
        color: var(--white);
    }

    .btn-refuse {
        background: var(--warning-light);
        color: #B45309;
    }

    .btn-refuse:hover {
        background: var(--warning);
        color: var(--white);
    }

    .btn-cancel {
        background: var(--danger-light);
        color: var(--danger);
    }

    .btn-cancel:hover {
        background: var(--danger);
        color: var(--white);
    }

    .no-action {
        color: var(--gray-400);
        font-size: 13px;
        font-style: italic;
    }

    /* Empty State */
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
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 1200px) {
        .admin-table {
            display: block;
            overflow-x: auto;
        }
    }

    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .filter-tabs {
            width: 100%;
            overflow-x: auto;
        }

        .table-header {
            flex-direction: column;
            align-items: stretch;
        }

        .search-box {
            width: 100%;
        }

        .search-box input {
            width: 100%;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-calendar-check"></i>
        </div>
        <div class="page-title">
            <h1>Gestion des Réservations</h1>
            <p>Validez, refusez ou annulez les demandes de réservation</p>
        </div>
    </div>
</div>

<!-- ===== FILTER TABS ===== -->
<div class="filter-tabs">
    <!-- Toutes -->
    <a class="filter-tab ${statusFilter == 'ALL' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/reservations?status=ALL">
        <i class="fas fa-list"></i>
        Toutes
        <span class="count">${allCount}</span>
    </a>

    <!-- En attente -->
    <a class="filter-tab ${statusFilter == 'EN_ATTENTE' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/reservations?status=EN_ATTENTE">
        <i class="fas fa-hourglass-half"></i>
        En attente
        <span class="count">${pendingCount}</span>
    </a>

    <!-- Confirmées (VALIDEE en base) -->
    <a class="filter-tab ${statusFilter == 'VALIDEE' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/reservations?status=VALIDEE">
        <i class="fas fa-check-circle"></i>
        Confirmées
        <span class="count">${confirmedCount}</span>
    </a>

    <!-- Refusées -->
    <a class="filter-tab ${statusFilter == 'REFUSEE' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/reservations?status=REFUSEE">
        <i class="fas fa-times-circle"></i>
        Refusées
        <span class="count">${refusedCount}</span>
    </a>

    <!-- Annulées -->
    <a class="filter-tab ${statusFilter == 'ANNULEE' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/reservations?status=ANNULEE">
        <i class="fas fa-ban"></i>
        Annulées
        <span class="count">${cancelledCount}</span>
    </a>
</div>

<!-- ===== TABLE ===== -->
<div class="table-card">
    <div class="table-header">
    <h2>
        <i class="fas fa-table"></i>
        Liste des réservations
    </h2>
    <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text"
                   id="searchSalleInput"
                   placeholder="Rechercher par salle..."
                   onkeyup="filterBySalle()" />
        </div>
</div>
 <div class="table-responsive">
        <table id="adminReservationsTable" class="table table-hover mb-0 reservations-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Salle</th>
                        <th>Utilisateur</th>
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
                            <td class="id-cell">#${r.id}</td>
                            <td>
                                <div class="info-cell">
                                    <div class="info-icon room">
                                        <i class="fas fa-door-open"></i>
                                    </div>
                                    <span class="info-name">${r.salleNom}</span>
                                </div>
                            </td>
                            <td>
                                <div class="info-cell">
                                    <div class="info-icon user">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <span class="info-name">${r.utilisateurLogin}</span>
                                </div>
                            </td>
                            <td>${r.dateHeureDebut}</td>
                            <td>${r.dateHeureFin}</td>
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
                                    <c:choose>
                                        <c:when test="${r.statut == 'EN_ATTENTE'}">
                                            <a href="${pageContext.request.contextPath}/admin/reservations?action=validate&id=${r.id}"
                                               class="btn-action btn-validate">
                                                <i class="fas fa-check"></i>
                                                Valider
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/reservations?action=refuse&id=${r.id}"
                                               class="btn-action btn-refuse"
                                               onclick="return confirm('Refuser cette réservation ?');">
                                                <i class="fas fa-times"></i>
                                                Refuser
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/reservations?action=cancel&id=${r.id}"
                                               class="btn-action btn-cancel"
                                               onclick="return confirm('Annuler cette réservation ?');">
                                                <i class="fas fa-ban"></i>
                                                Annuler
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="no-action">Aucune action</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
       
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const input = document.getElementById('searchSalleInput');
    if (!input) return;

    input.addEventListener('input', function() {
        const filter = input.value.toLowerCase().trim();
        // Toutes les lignes du tableau des réservations
        const rows = document.querySelectorAll('.reservations-table tbody tr');

        rows.forEach(function(row) {
            // On suppose que la 2ème colonne est la colonne "Salle"
            const salleCell = row.querySelector('td:nth-child(2)');
            if (!salleCell) return;

            const text = salleCell.textContent.toLowerCase();

            if (filter === '' || text.includes(filter)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});
</script>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />