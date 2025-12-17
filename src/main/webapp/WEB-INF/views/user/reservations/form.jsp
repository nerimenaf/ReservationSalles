<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Nouvelle Réservation - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== PAGE LAYOUT ===== */
    .form-page-container {
        max-width: 700px;
        margin: 0 auto;
    }

    /* ===== BACK BUTTON ===== */
    .back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: var(--gray-600);
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 24px;
        transition: var(--transition);
    }

    .back-link:hover {
        color: var(--primary);
    }

    /* ===== FORM CARD ===== */
    .form-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .form-card-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        padding: 32px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .form-card-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
    }

    .form-header-icon {
        width: 70px;
        height: 70px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 16px;
        backdrop-filter: blur(10px);
    }

    .form-header-icon i {
        font-size: 32px;
        color: var(--white);
    }

    .form-card-header h1 {
        font-size: 24px;
        font-weight: 700;
        color: var(--white);
        margin: 0 0 8px 0;
        position: relative;
        z-index: 1;
    }

    .form-card-header p {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.8);
        margin: 0;
        position: relative;
        z-index: 1;
    }

    .form-card-body {
        padding: 32px;
    }

    /* ===== ALERT ===== */
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

    /* ===== FORM STYLES ===== */
    .form-group {
        margin-bottom: 24px;
    }

    .form-group label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        font-weight: 600;
        color: var(--gray-700);
        margin-bottom: 10px;
    }

    .form-group label i {
        color: var(--primary);
        font-size: 16px;
    }

    .form-group label .required {
        color: var(--danger);
    }

    .form-input {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 15px;
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

    /* Select styling */
    .form-select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
        transition: var(--transition);
        background: var(--gray-50);
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%236B7280' viewBox='0 0 16 16'%3E%3Cpath d='M8 11L3 6h10l-5 5z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 16px center;
    }

    .form-select:focus {
        outline: none;
        border-color: var(--primary);
        background-color: var(--white);
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    }

    /* Date/Time inputs row */
    .datetime-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    /* ===== FORM ACTIONS ===== */
    .form-actions {
        display: flex;
        gap: 12px;
        margin-top: 32px;
        padding-top: 24px;
        border-top: 1px solid var(--gray-100);
    }

    .btn-submit {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 16px 24px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        color: var(--white);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
    }

    .btn-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
    }

    .btn-cancel {
        padding: 16px 24px;
        background: var(--gray-100);
        color: var(--gray-700);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        font-family: 'Poppins', sans-serif;
    }

    .btn-cancel:hover {
        background: var(--gray-200);
        color: var(--gray-800);
    }

    /* ===== HELP TEXT ===== */
    .help-text {
        font-size: 12px;
        color: var(--gray-500);
        margin-top: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .help-text i {
        font-size: 12px;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .datetime-row {
            grid-template-columns: 1fr;
        }

        .form-actions {
            flex-direction: column;
        }

        .btn-cancel {
            text-align: center;
        }
    }
</style>

<div class="form-page-container">
    <!-- Back Link -->
    <a href="${pageContext.request.contextPath}/user/reservations" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Retour à mes réservations
    </a>

    <!-- Form Card -->
    <div class="form-card">
        <div class="form-card-header">
            <div class="form-header-icon">
                <i class="fas fa-calendar-plus"></i>
            </div>
            <h1>Nouvelle Réservation</h1>
            <p>Réservez une salle en quelques clics</p>
        </div>

        <div class="form-card-body">
            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert-custom alert-danger-custom">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Reservation Form -->
            <form action="${pageContext.request.contextPath}/user/reservations" method="post">
                <input type="hidden" name="action" value="create" />

                <!-- Room Selection -->
                <div class="form-group">
                    <label for="salleId">
                        <i class="fas fa-door-open"></i>
                        Salle <span class="required">*</span>
                    </label>
                    <select id="salleId" name="salleId" class="form-select" required>
                        <option value="">-- Choisir une salle --</option>
                        <c:forEach var="s" items="${salles}">
                            <option value="${s.id}" <c:if test="${s.id == salleIdParam}">selected</c:if>>
                                ${s.nom} (${s.capacite} places) - ${s.localisation}
                            </option>
                        </c:forEach>
                    </select>
                    <p class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Sélectionnez la salle que vous souhaitez réserver
                    </p>
                </div>

                <!-- Date/Time Fields -->
                <div class="datetime-row">
                    <div class="form-group">
                        <label for="dateHeureDebut">
                            <i class="fas fa-play-circle"></i>
                            Date et heure de début <span class="required">*</span>
                        </label>
                        <input type="datetime-local" 
                               id="dateHeureDebut" 
                               name="dateHeureDebut"
                               class="form-input"
                               value="<c:if test='${not empty dateParam and not empty startTimeParam}'>${dateParam}T${startTimeParam}</c:if>"
                               required />
                    </div>

                    <div class="form-group">
                        <label for="dateHeureFin">
                            <i class="fas fa-stop-circle"></i>
                            Date et heure de fin <span class="required">*</span>
                        </label>
                        <input type="datetime-local" 
                               id="dateHeureFin" 
                               name="dateHeureFin"
                               class="form-input"
                               value="<c:if test='${not empty dateParam and not empty endTimeParam}'>${dateParam}T${endTimeParam}</c:if>"
                               required />
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user/reservations" class="btn-cancel">
                        Annuler
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-check"></i>
                        Valider la réservation
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />