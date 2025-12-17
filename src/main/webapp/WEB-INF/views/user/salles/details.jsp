<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Détails Salle - Roomify Center" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    /* ===== BACK LINK ===== */
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

    /* ===== PAGE LAYOUT ===== */
    .details-grid {
        display: grid;
        grid-template-columns: 400px 1fr;
        gap: 32px;
    }

    /* ===== ROOM INFO CARD ===== */
    .room-info-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
        position: sticky;
        top: 100px;
    }

    .room-image-section {
        height: 200px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }

    .room-image-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
    }

    .room-image-section i {
        font-size: 64px;
        color: rgba(255, 255, 255, 0.3);
    }

    .room-info-content {
        padding: 24px;
    }

    .room-name {
        font-size: 24px;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 20px;
    }

    .room-details-list {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .room-detail-item {
        display: flex;
        align-items: flex-start;
        gap: 12px;
    }

    .detail-icon {
        width: 40px;
        height: 40px;
        background: var(--primary-lighter);
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 16px;
        flex-shrink: 0;
    }

    .detail-content {
        flex: 1;
    }

    .detail-label {
        font-size: 12px;
        color: var(--gray-500);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 2px;
    }

    .detail-value {
        font-size: 15px;
        font-weight: 500;
        color: var(--dark);
    }

    /* Rating Section */
    .rating-section {
        margin-top: 24px;
        padding-top: 24px;
        border-top: 1px solid var(--gray-100);
    }

    .rating-header {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 12px;
    }

    .rating-header i {
        color: var(--accent);
    }

    .rating-header span {
        font-weight: 600;
        color: var(--dark);
    }

    .rating-display {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .rating-score {
        font-size: 36px;
        font-weight: 700;
        color: var(--dark);
    }

    .rating-stars {
        display: flex;
        gap: 4px;
    }

    .rating-stars i {
        color: var(--accent);
        font-size: 18px;
    }

    .rating-stars i.empty {
        color: var(--gray-300);
    }

    .no-rating {
        color: var(--gray-500);
        font-size: 14px;
        font-style: italic;
    }

    /* Equipment tags */
    .equipment-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-top: 8px;
    }

    .equipment-tag {
        padding: 6px 12px;
        background: var(--gray-100);
        border-radius: 20px;
        font-size: 12px;
        color: var(--gray-700);
    }

    /* ===== REVIEWS SECTION ===== */
    .reviews-section {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    /* Your Review Card */
    .your-review-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .card-header-custom {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .card-header-custom i {
        color: var(--primary);
        font-size: 18px;
    }

    .card-header-custom h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
    }

    .card-body-custom {
        padding: 24px;
    }

    /* Form Styles */
    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: var(--gray-700);
        margin-bottom: 8px;
    }

    .form-input,
    .form-select,
    .form-textarea {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid var(--gray-200);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: var(--transition);
        background: var(--gray-50);
    }

    .form-input:focus,
    .form-select:focus,
    .form-textarea:focus {
        outline: none;
        border-color: var(--primary);
        background: var(--white);
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    }

    .form-textarea {
        min-height: 100px;
        resize: vertical;
    }

    /* Star Rating Input */
    .star-rating-input {
        display: flex;
        gap: 8px;
        flex-direction: row-reverse;
        justify-content: flex-end;
    }

    .star-rating-input input {
        display: none;
    }

    .star-rating-input label {
        cursor: pointer;
        font-size: 28px;
        color: var(--gray-300);
        transition: var(--transition);
    }

    .star-rating-input label:hover,
    .star-rating-input label:hover ~ label,
    .star-rating-input input:checked ~ label {
        color: var(--accent);
    }

    .form-actions {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .btn-primary-custom {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
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

    .btn-primary-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
    }

    .btn-danger-outline {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
        background: transparent;
        color: var(--danger);
        border: 2px solid var(--danger);
        border-radius: var(--radius-sm);
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        font-family: 'Poppins', sans-serif;
    }

    .btn-danger-outline:hover {
        background: var(--danger);
        color: var(--white);
    }

    /* Alert */
    .alert-custom {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        border-radius: var(--radius);
        margin-bottom: 20px;
    }

    .alert-danger-custom {
        background: linear-gradient(135deg, #FEE2E2 0%, #FECACA 100%);
        border-left: 4px solid var(--danger);
        color: #991B1B;
    }

    /* ===== ALL REVIEWS LIST ===== */
    .reviews-list-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .reviews-list {
        padding: 0;
    }

    .review-item {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
        display: flex;
        gap: 16px;
    }

    .review-item:last-child {
        border-bottom: none;
    }

    .review-avatar {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, var(--primary-light), var(--primary));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--white);
        font-weight: 600;
        font-size: 18px;
        flex-shrink: 0;
    }

    .review-content {
        flex: 1;
    }

    .review-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
        flex-wrap: wrap;
        gap: 8px;
    }

    .review-author {
        font-weight: 600;
        color: var(--dark);
    }

    .review-rating {
        display: flex;
        gap: 2px;
    }

    .review-rating i {
        color: var(--accent);
        font-size: 14px;
    }

    .review-rating i.empty {
        color: var(--gray-300);
    }

    .review-date {
        font-size: 12px;
        color: var(--gray-500);
    }

    .review-text {
        color: var(--gray-600);
        font-size: 14px;
        line-height: 1.6;
    }

    .empty-reviews {
        text-align: center;
        padding: 40px 20px;
        color: var(--gray-500);
    }

    .empty-reviews i {
        font-size: 48px;
        color: var(--gray-300);
        margin-bottom: 16px;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 1024px) {
        .details-grid {
            grid-template-columns: 1fr;
        }

        .room-info-card {
            position: static;
        }
    }
</style>

<!-- Back Link -->
<a href="${pageContext.request.contextPath}/user/home" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Retour aux salles
</a>

<div class="details-grid">
    <!-- ===== LEFT: ROOM INFO ===== -->
    <div class="room-info-card">
        <div class="room-image-section">
            <i class="fas fa-door-open"></i>
        </div>
        <div class="room-info-content">
            <h1 class="room-name">${salle.nom}</h1>

            <div class="room-details-list">
                <div class="room-detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Capacité</div>
                        <div class="detail-value">${salle.capacite} personnes</div>
                    </div>
                </div>

                <div class="room-detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Localisation</div>
                        <div class="detail-value">${salle.localisation}</div>
                    </div>
                </div>

                <div class="room-detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-tv"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Équipements</div>
                        <div class="equipment-tags">
                            <c:forTokens items="${salle.equipements}" delims="," var="equip">
                                <span class="equipment-tag">${equip.trim()}</span>
                            </c:forTokens>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Rating Section -->
            <div class="rating-section">
                <div class="rating-header">
                    <i class="fas fa-star"></i>
                    <span>Note moyenne</span>
                </div>
                <c:choose>
                    <c:when test="${moyenne != null}">
                        <div class="rating-display">
                            <span class="rating-score">${moyenne}</span>
                            <div>
                                <div class="rating-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= moyenne}">
                                                <i class="fas fa-star"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-star empty"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div style="font-size: 12px; color: var(--gray-500); margin-top: 4px;">
                                    sur 5
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="no-rating">Pas encore de note pour cette salle</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- ===== RIGHT: REVIEWS ===== -->
    <div class="reviews-section">
        <!-- Your Review -->
        <div class="your-review-card">
            <div class="card-header-custom">
                <i class="fas fa-edit"></i>
                <h3>Votre avis</h3>
            </div>
            <div class="card-body-custom">
                <c:if test="${not empty error}">
                    <div class="alert-custom alert-danger-custom">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/salle" method="post">
                    <input type="hidden" name="action" value="saveAvis" />
                    <input type="hidden" name="salleId" value="${salle.id}" />

                    <div class="form-group">
                        <label>Votre note</label>
                        <div class="star-rating-input">
                            <c:forEach begin="1" end="5" var="n">
                                <input type="radio" 
                                       id="star${n}" 
                                       name="note" 
                                       value="${6 - n}" 
                                       <c:if test="${avisUser != null && avisUser.note == (6 - n)}">checked</c:if>
                                       required>
                                <label for="star${n}">
                                    <i class="fas fa-star"></i>
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="commentaire">Commentaire (optionnel)</label>
                        <textarea id="commentaire" 
                                  name="commentaire" 
                                  class="form-textarea"
                                  placeholder="Partagez votre expérience avec cette salle...">${avisUser != null ? avisUser.commentaire : ''}</textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-primary-custom">
                            <i class="fas fa-save"></i>
                            <c:choose>
                                <c:when test="${avisUser == null}">Enregistrer mon avis</c:when>
                                <c:otherwise>Mettre à jour</c:otherwise>
                            </c:choose>
                        </button>

                        <c:if test="${avisUser != null}">
                            </form>
                            <form action="${pageContext.request.contextPath}/user/salle" 
                                  method="post" 
                                  style="display: inline;">
                                <input type="hidden" name="action" value="deleteAvis" />
                                <input type="hidden" name="avisId" value="${avisUser.id}" />
                                <input type="hidden" name="salleId" value="${salle.id}" />
                                <button type="submit" 
                                        class="btn-danger-outline"
                                        onclick="return confirm('Supprimer votre avis ?');">
                                    <i class="fas fa-trash"></i>
                                    Supprimer
                                </button>
                            </form>
                        </c:if>
                    </div>
                    <c:if test="${avisUser == null}">
                </form>
                    </c:if>
            </div>
        </div>

        <!-- All Reviews -->
        <div class="reviews-list-card">
            <div class="card-header-custom">
                <i class="fas fa-comments"></i>
                <h3>Tous les avis (${avisList.size()})</h3>
            </div>
            <div class="reviews-list">
                <c:choose>
                    <c:when test="${empty avisList}">
                        <div class="empty-reviews">
                            <i class="fas fa-comment-slash"></i>
                            <p>Aucun avis pour cette salle</p>
                            <p style="font-size: 13px;">Soyez le premier à donner votre avis !</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="a" items="${avisList}">
                            <div class="review-item">
                                <div class="review-avatar">
                                    ${a.utilisateurLogin.substring(0,1).toUpperCase()}
                                </div>
                                <div class="review-content">
                                    <div class="review-header">
                                        <div>
                                            <span class="review-author">${a.utilisateurLogin}</span>
                                            <span class="review-date">${a.dateCreation}</span>
                                        </div>
                                        <div class="review-rating">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= a.note}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-star empty"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <c:if test="${not empty a.commentaire}">
                                        <p class="review-text"><c:out value="${a.commentaire}"/></p>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />