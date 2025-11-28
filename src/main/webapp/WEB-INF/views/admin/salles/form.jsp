<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="${empty salle.id ? 'Ajouter une salle' : 'Modifier une salle'}" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">
    <c:if test="${empty salle.id}">Ajouter</c:if>
    <c:if test="${not empty salle.id}">Modifier</c:if>
    une salle
</h1>

<div class="mb-3">
    <a href="${pageContext.request.contextPath}/admin/salles" class="btn btn-sm btn-outline-secondary">
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
        <form action="${pageContext.request.contextPath}/admin/salles" method="post">
            <c:if test="${not empty salle.id}">
                <input type="hidden" name="id" value="${salle.id}" />
            </c:if>

            <div class="mb-3">
                <label for="nom" class="form-label">Nom</label>
                <input type="text" id="nom" name="nom" class="form-control"
                       value="${salle.nom}" required />
            </div>

            <div class="mb-3">
                <label for="capacite" class="form-label">Capacité</label>
                <input type="number" id="capacite" name="capacite"
                       class="form-control"
                       value="${salle.capacite}" required />
            </div>

            <div class="mb-3">
                <label for="localisation" class="form-label">Localisation</label>
                <input type="text" id="localisation" name="localisation"
                       class="form-control"
                       value="${salle.localisation}" required />
            </div>

            <div class="mb-3">
                <label for="equipements" class="form-label">Équipements</label>
                <textarea id="equipements" name="equipements"
                          class="form-control" rows="3">${salle.equipements}</textarea>
            </div>

            <button type="submit" class="btn btn-primary">
                Enregistrer
            </button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />