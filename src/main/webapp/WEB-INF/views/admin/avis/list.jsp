<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Gestion des avis" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h4 mb-0">Gestion des avis sur les salles</h1>
</div>

<div class="card border-0">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Salle</th>
                    <th>Utilisateur</th>
                    <th>Note</th>
                    <th>Commentaire</th>
                    <th>Date</th>
                    <th style="width: 110px;">Action</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${avis}">
                <tr>
                    <td>${a.id}</td>
                    <td>${a.salleNom}</td>
                    <td>${a.utilisateurLogin}</td>
                    <td>${a.note} / 5</td>
                    <td><c:out value="${a.commentaire}"/></td>
                    <td>${a.dateCreation}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/avis?action=delete&id=${a.id}"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Supprimer cet avis ?');">
                            Supprimer
                        </a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty avis}">
                <tr>
                    <td colspan="7" class="text-center text-muted py-3">
                        Aucun avis enregistré.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />