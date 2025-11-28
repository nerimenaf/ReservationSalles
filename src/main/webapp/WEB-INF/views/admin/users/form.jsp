<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle"
       value="${empty utilisateur.id ? 'Ajouter un utilisateur' : 'Modifier un utilisateur'}"
       scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">
    <c:if test="${empty utilisateur.id}">Ajouter</c:if>
    <c:if test="${not empty utilisateur.id}">Modifier</c:if>
    un utilisateur
</h1>

<div class="mb-3">
    <a href="${pageContext.request.contextPath}/admin/users"
       class="btn btn-sm btn-outline-secondary">
        Retour à la liste
    </a>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger" role="alert">
        ${error}
    </div>
</c:if>

<div class="card border-0">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/users" method="post">
            <c:if test="${not empty utilisateur.id}">
                <input type="hidden" name="id" value="${utilisateur.id}" />
            </c:if>

            <div class="mb-3">
                <label for="login" class="form-label">Login</label>
                <input type="text" id="login" name="login" class="form-control"
                       value="${utilisateur.login}" required />
            </div>

            <div class="mb-3">
                <label for="motDePasse" class="form-label">Mot de passe</label>
                <input type="password" id="motDePasse" name="motDePasse"
                       class="form-control" />
                <c:if test="${not empty utilisateur.id}">
                    <div class="form-text">
                        Laisser vide pour conserver le mot de passe actuel.
                    </div>
                </c:if>
            </div>

            <div class="mb-3">
                <label for="nomComplet" class="form-label">Nom complet</label>
                <input type="text" id="nomComplet" name="nomComplet"
                       class="form-control"
                       value="${utilisateur.nomComplet}" required />
            </div>

            <div class="mb-3">
                <label for="role" class="form-label">Rôle</label>
                <select id="role" name="role" class="form-select" required>
                    <option value="">-- Choisir --</option>
                    <option value="USER"
                        <c:if test="${utilisateur.role == 'USER'}">selected</c:if>>
                        Utilisateur
                    </option>
                    <option value="ADMIN"
                        <c:if test="${utilisateur.role == 'ADMIN'}">selected</c:if>>
                        Administrateur
                    </option>
                </select>
            </div>

            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input"
                       id="actif" name="actif"
                       <c:if test="${utilisateur.actif}">checked</c:if> />
                <label class="form-check-label" for="actif">Actif</label>
            </div>

            <button type="submit" class="btn btn-primary">
                Enregistrer
            </button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />