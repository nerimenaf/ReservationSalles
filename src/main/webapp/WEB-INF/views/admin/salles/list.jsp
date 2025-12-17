<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Gestion Salles - Roomify Center" scope="request"/>
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
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-size: 24px;
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
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

    .btn-add {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 28px;
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: var(--transition);
        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(16, 185, 129, 0.5);
        color: var(--white);
    }

    /* ===== ROOMS GRID ===== */
    .rooms-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        gap: 24px;
    }

    .room-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
        transition: var(--transition);
    }

    .room-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
    }

    .room-card-header {
        height: 140px;
        background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--gray-100) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    .room-card-header i {
        font-size: 48px;
        color: var(--primary-light);
        opacity: 0.5;
    }

    .room-capacity-badge {
        position: absolute;
        top: 16px;
        right: 16px;
        background: var(--white);
        padding: 6px 14px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 13px;
        font-weight: 600;
        color: var(--dark);
        box-shadow: var(--shadow-sm);
    }

    .room-capacity-badge i {
        font-size: 14px;
        color: var(--primary);
        opacity: 1;
    }

    .room-card-body {
        padding: 24px;
    }

    .room-name {
        font-size: 20px;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 16px;
    }

    .room-info-list {
        display: flex;
        flex-direction: column;
        gap: 12px;
        margin-bottom: 20px;
    }

    .room-info-item {
        display: flex;
        align-items: center;
        gap: 12px;
        font-size: 14px;
        color: var(--gray-600);
    }

    .room-info-item i {
        width: 20px;
        color: var(--primary);
        font-size: 15px;
    }

    .equipment-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        padding-top: 16px;
        border-top: 1px solid var(--gray-100);
    }

    .equipment-tag {
        padding: 5px 12px;
        background: var(--gray-100);
        border-radius: 20px;
        font-size: 12px;
        color: var(--gray-600);
    }

    .room-card-footer {
        padding: 16px 24px;
        background: var(--gray-50);
        display: flex;
        gap: 12px;
        border-top: 1px solid var(--gray-100);
    }

    .btn-edit {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 10px;
        background: var(--primary-lighter);
        color: var(--primary);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 13px;
        font-weight: 500;
        text-decoration: none;
        transition: var(--transition);
    }

    .btn-edit:hover {
        background: var(--primary);
        color: var(--white);
    }

    .btn-delete {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 16px;
        background: var(--danger-light);
        color: var(--danger);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 13px;
        font-weight: 500;
        text-decoration: none;
        transition: var(--transition);
        cursor: pointer;
    }

    .btn-delete:hover {
        background: var(--danger);
        color: var(--white);
    }

    /* Empty State */
    .empty-state {
        grid-column: 1 / -1;
        text-align: center;
        padding: 80px 20px;
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
    }

    .empty-state-icon {
        width: 100px;
        height: 100px;
        background: var(--gray-100);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 24px;
    }

    .empty-state-icon i {
        font-size: 48px;
        color: var(--gray-400);
    }

    .empty-state h3 {
        font-size: 20px;
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
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .btn-add {
            width: 100%;
            justify-content: center;
        }

        .rooms-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-door-open"></i>
        </div>
        <div class="page-title">
            <h1>Gestion des Salles</h1>
            <p>Ajoutez, modifiez et gérez les salles de réunion</p>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/salles?action=edit" class="btn-add">
        <i class="fas fa-plus"></i>
        Ajouter une salle
    </a>
</div>

<!-- ===== ROOMS GRID ===== -->
<div class="rooms-grid">
    <c:choose>
        <c:when test="${empty salles}">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-door-closed"></i>
                </div>
                <h3>Aucune salle enregistrée</h3>
                <p>Commencez par ajouter votre première salle de réunion.</p>
                <a href="${pageContext.request.contextPath}/admin/salles?action=edit" class="btn-add">
                    <i class="fas fa-plus"></i>
                    Ajouter une salle
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="s" items="${salles}">
                <div class="room-card">
                    <div class="room-card-header">
                        <i class="fas fa-door-open"></i>
                        <div class="room-capacity-badge">
                            <i class="fas fa-users"></i>
                            ${s.capacite} places
                        </div>
                    </div>
                    <div class="room-card-body">
                        <h3 class="room-name">${s.nom}</h3>
                        <div class="room-info-list">
                            <div class="room-info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${s.localisation}</span>
                            </div>
                            <div class="room-info-item">
                                <i class="fas fa-users"></i>
                                <span>Capacité: ${s.capacite} personnes</span>
                            </div>
                        </div>
                        <c:if test="${not empty s.equipements}">
                            <div class="equipment-tags">
                                <c:forTokens items="${s.equipements}" delims="," var="equip">
                                    <span class="equipment-tag">${equip.trim()}</span>
                                </c:forTokens>
                            </div>
                        </c:if>
                    </div>
                    <div class="room-card-footer">
                        <a href="${pageContext.request.contextPath}/admin/salles?action=edit&id=${s.id}" 
                           class="btn-edit">
                            <i class="fas fa-edit"></i>
                            Modifier
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/salles?action=delete&id=${s.id}"
                           class="btn-delete"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?');">
                            <i class="fas fa-trash"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />