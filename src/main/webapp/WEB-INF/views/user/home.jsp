<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Accueil - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== PAGE HEADER ===== */
    .page-header {
        margin-bottom: 32px;
    }

    .welcome-section {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 20px;
    }

    .welcome-content h1 {
        font-size: 28px;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 8px;
    }

    .welcome-content h1 span {
        color: var(--primary);
    }

    .welcome-content p {
        color: var(--gray-500);
        font-size: 15px;
        margin: 0;
    }

    .quick-actions {
        display: flex;
        gap: 12px;
    }

    .btn-action {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 500;
        transition: var(--transition);
        border: none;
        cursor: pointer;
        font-family: 'Poppins', sans-serif;
    }

    .btn-primary-custom {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        box-shadow: 0 4px 14px rgba(79, 70, 229, 0.4);
    }

    .btn-primary-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 70, 229, 0.5);
    }

    .btn-outline-custom {
        background: var(--white);
        color: var(--gray-700);
        border: 2px solid var(--gray-200);
    }

    .btn-outline-custom:hover {
        border-color: var(--primary);
        color: var(--primary);
        background: var(--primary-lighter);
    }

    /* ===== SEARCH CARD ===== */
    .search-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        padding: 32px;
        box-shadow: var(--shadow);
        margin-bottom: 32px;
        border: 1px solid var(--gray-100);
    }

    .search-card-header {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 24px;
    }

    .search-icon {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--primary-light) 100%);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 20px;
    }

    .search-card-header h2 {
        font-size: 20px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
    }

    .search-card-header p {
        font-size: 14px;
        color: var(--gray-500);
        margin: 0;
    }

    .search-form {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 20px;
    }

    .form-group-custom {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-group-custom label {
        font-size: 13px;
        font-weight: 600;
        color: var(--gray-700);
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .form-group-custom label i {
        color: var(--primary);
        font-size: 14px;
    }

    .form-input {
        padding: 12px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: var(--transition);
        background: var(--gray-50);
    }

    .form-input:focus {
        outline: none;
        border-color: var(--primary);
        background: var(--white);
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    }

    .form-input::placeholder {
        color: var(--gray-400);
    }

    .search-actions {
        grid-column: 1 / -1;
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 8px;
        padding-top: 20px;
        border-top: 1px solid var(--gray-100);
    }

    .btn-search {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 28px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
    }

    .btn-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
    }

    .btn-search i {
        font-size: 16px;
    }

    .btn-reset {
        padding: 14px 24px;
        background: var(--gray-100);
        color: var(--gray-600);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 15px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
    }

    .btn-reset:hover {
        background: var(--gray-200);
    }

    /* ===== ALERT STYLES ===== */
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

    .alert-info-custom {
        background: linear-gradient(135deg, #DBEAFE 0%, #BFDBFE 100%);
        border-left: 4px solid var(--info);
        color: #1E40AF;
    }

    .alert-custom i {
        font-size: 20px;
    }

    /* ===== RESULTS SECTION ===== */
    .results-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 24px;
        flex-wrap: wrap;
        gap: 16px;
    }

    .results-title {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .results-title h2 {
        font-size: 20px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
    }

    .results-count {
        background: var(--primary-lighter);
        color: var(--primary);
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
    }

    .results-actions {
        display: flex;
        gap: 10px;
    }

    /* ===== ROOM CARDS ===== */
    .rooms-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 24px;
    }

    .room-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        overflow: hidden;
        box-shadow: var(--shadow);
        transition: var(--transition);
        border: 1px solid var(--gray-100);
    }

    .room-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
    }

    .room-card-image {
        height: 160px;
        background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--gray-100) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }

    .room-card-image i {
        font-size: 48px;
        color: var(--primary-light);
        opacity: 0.5;
    }

    .room-badge {
        position: absolute;
        top: 12px;
        right: 12px;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .badge-available {
        background: var(--success);
        color: var(--white);
    }

    .room-card-content {
        padding: 24px;
    }

    .room-name {
        font-size: 18px;
        font-weight: 600;
        color: var(--dark);
        margin-bottom: 16px;
    }

    .room-details {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-bottom: 20px;
    }

    .room-detail {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 14px;
        color: var(--gray-600);
    }

    .room-detail i {
        width: 20px;
        color: var(--primary);
        font-size: 15px;
    }

    .room-equipments {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 16px;
        padding-top: 16px;
        border-top: 1px solid var(--gray-100);
    }

    .equipment-tag {
        padding: 4px 10px;
        background: var(--gray-100);
        border-radius: 6px;
        font-size: 12px;
        color: var(--gray-600);
    }

    .room-card-footer {
        padding: 16px 24px;
        background: var(--gray-50);
        border-top: 1px solid var(--gray-100);
    }

    .btn-reserve {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 12px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
    }

    .btn-reserve:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
    }

    /* ===== EMPTY STATE ===== */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
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
        max-width: 400px;
        margin: 0 auto;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .welcome-section {
            flex-direction: column;
            align-items: flex-start;
        }

        .quick-actions {
            width: 100%;
        }

        .quick-actions .btn-action {
            flex: 1;
            justify-content: center;
        }

        .search-form {
            grid-template-columns: 1fr;
        }

        .search-actions {
            flex-direction: column;
        }

        .search-actions button {
            width: 100%;
            justify-content: center;
        }

        .results-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .results-actions {
            width: 100%;
        }

        .results-actions .btn-action {
            flex: 1;
            justify-content: center;
        }

        .rooms-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="welcome-section">
        <div class="welcome-content">
            <h1>Bienvenue, <span>${userSession.nomComplet}</span> 👋</h1>
            <p>Recherchez un créneau disponible et réservez votre salle en quelques clics</p>
        </div>
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/user/reservations" class="btn-action btn-outline-custom">
                <i class="fas fa-list"></i>
                Mes réservations
            </a>
            <a href="${pageContext.request.contextPath}/user/calendar" class="btn-action btn-outline-custom">
                <i class="fas fa-calendar-alt"></i>
                Calendrier
            </a>
        </div>
    </div>
</div>

<!-- ===== SEARCH CARD ===== -->
<div class="search-card">
    <div class="search-card-header">
        <div class="search-icon">
            <i class="fas fa-search"></i>
        </div>
        <div>
            <h2>Rechercher une salle</h2>
            <p>Sélectionnez vos critères pour trouver la salle idéale</p>
        </div>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/user/home" class="search-form">
        <div class="form-group-custom">
            <label for="date">
                <i class="fas fa-calendar"></i>
                Date
            </label>
            <input type="date" id="date" name="date" class="form-input" value="${date}" required>
        </div>

        <div class="form-group-custom">
            <label for="startTime">
                <i class="fas fa-clock"></i>
                Heure de début
            </label>
            <input type="time" id="startTime" name="startTime" class="form-input" value="${startTime}" required>
        </div>

        <div class="form-group-custom">
            <label for="endTime">
                <i class="fas fa-clock"></i>
                Heure de fin
            </label>
            <input type="time" id="endTime" name="endTime" class="form-input" value="${endTime}" required>
        </div>

        <div class="form-group-custom">
            <label for="capaciteMin">
                <i class="fas fa-users"></i>
                Capacité minimum
            </label>
            <input type="number" id="capaciteMin" name="capaciteMin" class="form-input" min="1" placeholder="Ex: 10" value="${capaciteMin}">
        </div>

        <div class="form-group-custom">
            <label for="equipements">
                <i class="fas fa-tv"></i>
                Équipements
            </label>
            <input type="text" id="equipements" name="equipements" class="form-input" placeholder="Projecteur, Wifi, Climatisation..." value="${equipements}">
        </div>

        <div class="search-actions">
            <button type="reset" class="btn-reset">
                <i class="fas fa-undo"></i>
                Réinitialiser
            </button>
            <button type="submit" class="btn-search">
                <i class="fas fa-search"></i>
                Rechercher les salles
            </button>
        </div>
    </form>
</div>

<!-- ===== ERROR ALERT ===== -->
<c:if test="${not empty error}">
    <div class="alert-custom alert-danger-custom">
        <i class="fas fa-exclamation-circle"></i>
        <span>${error}</span>
    </div>
</c:if>

<!-- ===== RESULTS SECTION ===== -->
<c:choose>
    <c:when test="${empty date or empty startTime or empty endTime}">
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-search"></i>
            </div>
            <h3>Commencez votre recherche</h3>
            <p>Veuillez sélectionner une date et un créneau horaire pour voir les salles disponibles</p>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Results Header -->
        <div class="results-header">
            <div class="results-title">
                <h2>Salles disponibles</h2>
                <c:if test="${not empty salles}">
                    <span class="results-count">${salles.size()} résultat(s)</span>
                </c:if>
            </div>
            <div class="results-actions">
                <span class="btn-action btn-outline-custom" style="cursor: default;">
                    <i class="fas fa-calendar-day"></i>
                    ${date}
                </span>
                <span class="btn-action btn-outline-custom" style="cursor: default;">
                    <i class="fas fa-clock"></i>
                    ${startTime} - ${endTime}
                </span>
            </div>
        </div>

        <c:if test="${empty salles}">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-door-closed"></i>
                </div>
                <h3>Aucune salle disponible</h3>
                <p>Aucune salle ne correspond à vos critères pour ce créneau. Essayez de modifier vos filtres.</p>
            </div>
        </c:if>

        <!-- Rooms Grid -->
        <c:if test="${not empty salles}">
            <div class="rooms-grid">
                <c:forEach var="s" items="${salles}">
                    <div class="room-card">
                        <div class="room-card-image">
                            <i class="fas fa-door-open"></i>
                            <span class="room-badge badge-available">
                                <i class="fas fa-check-circle"></i>
                                Disponible
                            </span>
                        </div>
                        <div class="room-card-content">
                            <h3 class="room-name">${s.nom}</h3>
                            <div class="room-details">
                                <div class="room-detail">
                                    <i class="fas fa-users"></i>
                                    <span><strong>${s.capacite}</strong> personnes max.</span>
                                </div>
                                <div class="room-detail">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${s.localisation}</span>
                                </div>
                            </div>
                            <c:if test="${not empty s.equipements}">
                                <div class="room-equipments">
                                    <c:forTokens items="${s.equipements}" delims="," var="equip">
                                        <span class="equipment-tag">${equip.trim()}</span>
                                    </c:forTokens>
                                </div>
                            </c:if>
                        </div>
                        <div class="room-card-footer">
                            <form method="post" action="${pageContext.request.contextPath}/user/reservations">
                                <input type="hidden" name="action" value="quickCreate" />
                                <input type="hidden" name="salleId" value="${s.id}" />
                                <input type="hidden" name="date" value="${date}" />
                                <input type="hidden" name="startTime" value="${startTime}" />
                                <input type="hidden" name="endTime" value="${endTime}" />
                                <button type="submit" class="btn-reserve">
                                    <i class="fas fa-calendar-plus"></i>
                                    Réserver cette salle
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />