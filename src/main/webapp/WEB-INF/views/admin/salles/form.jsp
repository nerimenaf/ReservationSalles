<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="${empty salle.id ? 'Ajouter une salle' : 'Modifier une salle'} - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== PAGE LAYOUT ===== */
    .form-page-container {
        max-width: 700px;
        margin: 0 auto;
    }

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
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
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

    /* Alert */
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

    /* Form Styles */
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
        color: var(--success);
        font-size: 16px;
    }

    .form-group label .required {
        color: var(--danger);
    }

    .form-input,
    .form-textarea {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
        transition: var(--transition);
        background: var(--gray-50);
    }

    .form-input:focus,
    .form-textarea:focus {
        outline: none;
        border-color: var(--success);
        background: var(--white);
        box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
    }

    .form-textarea {
        min-height: 120px;
        resize: vertical;
    }

    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    .help-text {
        font-size: 12px;
        color: var(--gray-500);
        margin-top: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* Form Actions */
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
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
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
        box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
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
        text-align: center;
    }

    .btn-cancel:hover {
        background: var(--gray-200);
        color: var(--gray-800);
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .form-row {
            grid-template-columns: 1fr;
        }

        .form-actions {
            flex-direction: column;
        }
    }
</style>

<div class="form-page-container">
    <!-- Back Link -->
    <a href="${pageContext.request.contextPath}/admin/salles" class="post">
        <i class="fas fa-arrow-left"></i>
        Retour à la liste des salles
    </a>

    <!-- Form Card -->
    <div class="form-card">
        <div class="form-card-header">
            <div class="form-header-icon">
                <i class="fas fa-door-open"></i>
            </div>
            <h1>
                <c:choose>
                    <c:when test="${empty salle.id}">Ajouter une salle</c:when>
                    <c:otherwise>Modifier la salle</c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${empty salle.id}">Créez une nouvelle salle de réunion</c:when>
                    <c:otherwise>Modifiez les informations de la salle</c:otherwise>
                </c:choose>
            </p>
        </div>

        <div class="form-card-body">
            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert-custom alert-danger-custom">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/admin/salles" method="post">
                <c:if test="${not empty salle.id}">
                    <input type="hidden" name="id" value="${salle.id}" />
                </c:if>

                <div class="form-group">
                    <label for="nom">
                        <i class="fas fa-tag"></i>
                        Nom de la salle <span class="required">*</span>
                    </label>
                    <input type="text" 
                           id="nom" 
                           name="nom" 
                           class="form-input"
                           value="${salle.nom}"
                           placeholder="Ex: Salle Einstein"
                           required />
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="capacite">
                            <i class="fas fa-users"></i>
                            Capacité <span class="required">*</span>
                        </label>
                        <input type="number" 
                               id="capacite" 
                               name="capacite"
                               class="form-input"
                               value="${salle.capacite}"
                               min="1"
                               placeholder="Ex: 20"
                               required />
                        <p class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Nombre maximum de personnes
                        </p>
                    </div>

                    <div class="form-group">
                        <label for="localisation">
                            <i class="fas fa-map-marker-alt"></i>
                            Localisation <span class="required">*</span>
                        </label>
                        <input type="text" 
                               id="localisation" 
                               name="localisation"
                               class="form-input"
                               value="${salle.localisation}"
                               placeholder="Ex: Bâtiment A, 2ème étage"
                               required />
                    </div>
                </div>
                                <div class="form-group">
                    <label for="equipements">
                        <i class="fas fa-tv"></i>
                        Équipements
                    </label>
                    <textarea id="equipements" 
                              name="equipements"
                              class="form-textarea"
                              placeholder="Ex: Projecteur, Tableau blanc, Wifi, Climatisation, Vidéoconférence...">${salle.equipements}</textarea>
                    <p class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Séparez les équipements par des virgules
                    </p>
                </div>
                <div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" id="active" name="active"
           <c:if test="${salle.active}">checked</c:if> />
    <label class="form-check-label" for="active">
        Salle active (visible pour les utilisateurs)
    </label>
</div>
                

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/salles" class="btn-cancel">
                        Annuler
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i>
                        <c:choose>
                            <c:when test="${empty salle.id}">Créer la salle</c:when>
                            <c:otherwise>Enregistrer les modifications</c:otherwise>
                        </c:choose>
                    </button>
                </div>
                
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />