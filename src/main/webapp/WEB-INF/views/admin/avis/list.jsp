<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Gestion des Avis - Roomify Center" scope="request"/>
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
        background: linear-gradient(135deg, var(--accent) 0%, #D97706 100%);
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

    /* ===== STATS SUMMARY ===== */
    .stats-summary {
        display: flex;
        gap: 20px;
        margin-bottom: 24px;
        flex-wrap: wrap;
    }

    .summary-card {
        flex: 1;
        min-width: 200px;
        background: var(--white);
        border-radius: var(--radius);
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 16px;
        box-shadow: var(--shadow-sm);
        border: 1px solid var(--gray-100);
    }

    .summary-icon {
        width: 50px;
        height: 50px;
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }

    .summary-icon.total {
        background: var(--warning-light);
        color: var(--warning);
    }

    .summary-icon.average {
        background: var(--success-light);
        color: var(--success);
    }

    .summary-content h3 {
        font-size: 24px;
        font-weight: 700;
        color: var(--dark);
        margin: 0;
    }

    .summary-content p {
        font-size: 13px;
        color: var(--gray-500);
        margin: 0;
    }

    /* ===== REVIEWS TABLE ===== */
    .table-card {
        background: var(--white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        overflow: hidden;
        border: 1px solid var(--gray-100);
    }

    .table-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--gray-100);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .table-header h2 {
        font-size: 16px;
        font-weight: 600;
        color: var(--dark);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .table-header h2 i {
        color: var(--accent);
    }

    .reviews-table {
        width: 100%;
        border-collapse: collapse;
    }

    .reviews-table thead {
        background: var(--gray-50);
    }

    .reviews-table th {
        padding: 14px 20px;
        text-align: left;
        font-size: 12px;
        font-weight: 600;
        color: var(--gray-600);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid var(--gray-200);
    }

    .reviews-table td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--gray-100);
        font-size: 14px;
        color: var(--gray-700);
        vertical-align: middle;
    }

    .reviews-table tbody tr {
        transition: var(--transition);
    }

    .reviews-table tbody tr:hover {
        background: var(--gray-50);
    }

    .reviews-table tbody tr:last-child td {
        border-bottom: none;
    }

    /* ID Badge */
    .id-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        background: var(--gray-100);
        border-radius: var(--radius-sm);
        font-size: 12px;
        font-weight: 600;
        color: var(--gray-600);
    }

    /* Room & User cells */
    .cell-with-icon {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .cell-icon {
        width: 36px;
        height: 36px;
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        flex-shrink: 0;
    }

    .cell-icon.room {
        background: var(--primary-lighter);
        color: var(--primary);
    }

    .cell-icon.user {
        background: var(--success-light);
        color: var(--success);
    }

    .cell-text {
        font-weight: 500;
        color: var(--dark);
    }

    /* Star Rating */
    .star-rating {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .star-rating i {
        color: var(--accent);
        font-size: 14px;
    }

    .star-rating i.empty {
        color: var(--gray-300);
    }

    .star-rating .rating-value {
        margin-left: 8px;
        font-weight: 600;
        color: var(--dark);
    }

    /* Comment */
    .comment-cell {
        max-width: 250px;
        color: var(--gray-600);
        font-size: 13px;
        line-height: 1.5;
    }

    /* Date */
    .date-cell {
        font-size: 13px;
        color: var(--gray-500);
    }

    /* Delete Button */
    .btn-delete {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 14px;
        background: var(--danger-light);
        color: var(--danger);
        border: none;
        border-radius: var(--radius-sm);
        font-size: 12px;
        font-weight: 500;
        transition: var(--transition);
        text-decoration: none;
        cursor: pointer;
        font-family: 'Poppins', sans-serif;
    }

    .btn-delete:hover {
        background: var(--danger);
        color: var(--white);
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
    @media (max-width: 1024px) {
        .reviews-table {
            display: block;
            overflow-x: auto;
        }
    }

    @media (max-width: 768px) {
        .stats-summary {
            flex-direction: column;
        }

        .summary-card {
            width: 100%;
        }
    }
</style>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
    <div class="page-title-section">
        <div class="page-icon">
            <i class="fas fa-star"></i>
        </div>
        <div class="page-title">
            <h1>Gestion des Avis</h1>
            <p>Consultez et modérez les avis sur les salles</p>
        </div>
    </div>
</div>

<!-- ===== STATS SUMMARY ===== -->
<div class="stats-summary">
    <div class="summary-card">
        <div class="summary-icon total">
            <i class="fas fa-comments"></i>
        </div>
        <div class="summary-content">
            <h3>${avis.size()}</h3>
            <p>Avis au total</p>
        </div>
    </div>
    <div class="summary-card">
        <div class="summary-icon average">
            <i class="fas fa-star"></i>
        </div>
        <div class="summary-content">
            <h3>
                <c:set var="totalNotes" value="0"/>
                <c:forEach var="a" items="${avis}">
                    <c:set var="totalNotes" value="${totalNotes + a.note}"/>
                </c:forEach>
                <c:choose>
                    <c:when test="${not empty avis}">
                        ${String.format("%.1f", totalNotes / avis.size())}
                    </c:when>
                    <c:otherwise>0</c:otherwise>
                </c:choose>
            </h3>
            <p>Note moyenne</p>
        </div>
    </div>
</div>

<!-- ===== REVIEWS TABLE ===== -->
<div class="table-card">
    <div class="table-header">
        <h2>
            <i class="fas fa-list"></i>
            Tous les avis
        </h2>
    </div>

    <c:choose>
        <c:when test="${empty avis}">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-comment-slash"></i>
                </div>
                <h3>Aucun avis enregistré</h3>
                <p>Les utilisateurs n'ont pas encore laissé d'avis sur les salles.</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="reviews-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Salle</th>
                        <th>Utilisateur</th>
                        <th>Note</th>
                        <th>Commentaire</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${avis}">
                        <tr>
                            <td>
                                <span class="id-badge">${a.id}</span>
                            </td>
                            <td>
                                <div class="cell-with-icon">
                                    <div class="cell-icon room">
                                        <i class="fas fa-door-open"></i>
                                    </div>
                                    <span class="cell-text">${a.salleNom}</span>
                                </div>
                            </td>
                            <td>
                                <div class="cell-with-icon">
                                    <div class="cell-icon user">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <span class="cell-text">${a.utilisateurLogin}</span>
                                </div>
                            </td>
                            <td>
                                <div class="star-rating">
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
                                    <span class="rating-value">${a.note}/5</span>
                                </div>
                            </td>
                            <td>
                                <span class="comment-cell">
                                    <c:out value="${a.commentaire}" default="—"/>
                                </span>
                            </td>
                            <td>
                                <span class="date-cell">${a.dateCreation}</span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/avis?action=delete&id=${a.id}"
                                   class="btn-delete"
                                   onclick="return confirm('Supprimer cet avis ?');">
                                    <i class="fas fa-trash"></i>
                                    Supprimer
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />