<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="Détails salle" scope="request"/>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<h1 class="h4 mb-3">Détails de la salle</h1>

<div class="mb-3">
    <a href="${pageContext.request.contextPath}/user/home"
       class="btn btn-sm btn-outline-secondary">
        Retour à la liste des salles
    </a>
</div>

<div class="row">
    <div class="col-md-5 mb-3">
        <div class="card border-0">
            <div class="card-body">
                <h2 class="h5">${salle.nom}</h2>
                <p class="mb-1"><strong>Capacité :</strong> ${salle.capacite}</p>
                <p class="mb-1"><strong>Localisation :</strong> ${salle.localisation}</p>
                <p class="mb-0"><strong>Équipements :</strong> <c:out value="${salle.equipements}"/></p>

                <hr/>

                <h3 class="h6">Note moyenne</h3>
                <c:choose>
                    <c:when test="${moyenne != null}">
                        <p class="mb-0"><strong>${moyenne}</strong> / 5</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted mb-0">Pas encore de note pour cette salle.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-7 mb-3">
        <div class="card border-0 mb-3">
            <div class="card-body">
                <h3 class="h6 mb-3">Votre avis</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/user/salle" method="post">
                    <input type="hidden" name="action" value="saveAvis" />
                    <input type="hidden" name="salleId" value="${salle.id}" />

                    <div class="mb-3">
                        <label for="note" class="form-label">Note (1 à 5)</label>
                        <select id="note" name="note" class="form-select" required>
                            <c:forEach begin="1" end="5" var="n">
                                <option value="${n}" 
                                    <c:if test="${avisUser != null && avisUser.note == n}">selected</c:if>>
                                    ${n}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="commentaire" class="form-label">Commentaire</label>
                        <textarea id="commentaire" name="commentaire"
                                  class="form-control" rows="3">
${avisUser != null ? avisUser.commentaire : ''}
                        </textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <c:if test="${avisUser == null}">Enregistrer mon avis</c:if>
                        <c:if test="${avisUser != null}">Mettre à jour mon avis</c:if>
                    </button>
                </form>

                <c:if test="${avisUser != null}">
                    <form action="${pageContext.request.contextPath}/user/salle"
                          method="post" class="mt-2">
                        <input type="hidden" name="action" value="deleteAvis" />
                        <input type="hidden" name="avisId" value="${avisUser.id}" />
                        <input type="hidden" name="salleId" value="${salle.id}" />
                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                onclick="return confirm('Supprimer votre avis ?');">
                            Supprimer mon avis
                        </button>
                    </form>
                </c:if>
            </div>
        </div>

        <div class="card border-0">
            <div class="card-body p-0">
                <h3 class="h6 px-3 pt-3">Tous les avis</h3>
                <div class="table-responsive">
                    <table class="table mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Utilisateur</th>
                                <th>Note</th>
                                <th>Commentaire</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="a" items="${avisList}">
                            <tr>
                                <td>${a.utilisateurLogin}</td>
                                <td>${a.note} / 5</td>
                                <td><c:out value="${a.commentaire}"/></td>
                                <td>${a.dateCreation}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty avisList}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-3">
                                    Aucun avis pour cette salle.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />