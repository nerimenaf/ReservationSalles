Application Web de Gestion et de Réservation de Salles

Mini-projet – Développement d’applications Web avec Jakarta EE
Classe : FIGL2 – Année universitaire : 2024-2025

1. Description générale

Cette application web permet de gérer des salles et leurs réservations au sein d’une organisation (école, université, entreprise…).
Deux types d’utilisateurs sont disponibles :

Administrateur

Gestion des utilisateurs (CRUD)

Gestion des salles (CRUD)

Validation, refus, annulation des réservations

Consultation des statistiques

Visualisation d’un calendrier par salle

Modération des avis laissés par les utilisateurs

Utilisateur simple

Consultation de la liste des salles

Création de réservations (salle + date/heure début/fin)

Consultation de ses propres réservations

Annulation des réservations futures

Vue calendrier hebdomadaire personnelle

Possibilité de laisser une note et un avis textuel sur une salle

Règles métier importantes

Une salle ne peut pas être réservée deux fois sur un même créneau.

Un utilisateur ne peut pas avoir deux réservations qui se chevauchent.

Les réservations passées ne sont plus modifiables.

L’administrateur peut annuler n’importe quelle réservation.

Workflow de validation :

EN_ATTENTE → VALIDEE / REFUSEE / ANNULEE.

2. Technologies utilisées
Back-end

Java

Jakarta Servlet & JSP (Tomcat 10)

JSTL + Expression Language (EL)

JDBC (MySQL)

Front-end

JSP + JSTL

Bootstrap 5 (CDN)

CSS personnalisé (assets/css/style.css)

Base de données

MySQL / MariaDB

Serveur

Apache Tomcat 10.x

IDE

Eclipse IDE for Enterprise Java and Web Developers

3. Fonctionnalités principales
3.1. Gestion des utilisateurs (Admin)

Liste, ajout, modification, suppression

Rôle (ADMIN / USER)

Activation / désactivation de compte

3.2. Gestion des salles (Admin)

CRUD complet

Informations : nom, capacité, localisation, équipements

3.3. Réservations
Côté utilisateur

Création d’une réservation

Règles :

Date future obligatoire

Fin > Début

Aucun chevauchement avec :

les réservations de la même salle

les réservations du même utilisateur

Liste de mes réservations

Annulation d’une réservation future

Côté administrateur

Liste complète des réservations

Actions :

Valider

Refuser

Annuler (toute réservation, tout utilisateur)

Les réservations passées sont verrouillées

3.4. Vues calendrier
Utilisateur : /user/calendar

Vue hebdomadaire personnalisée

Tableau (jours × heures)

Créneaux colorés avec salle + statut

Administrateur : /admin/calendar?salleId=...

Sélection d’une salle

Vue hebdomadaire des réservations de cette salle

3.5. Statistiques (Admin)

Nombre total de réservations

Répartition par statut

Top 5 des salles les plus demandées

3.6. Avis / commentaires
Utilisateur :

Note (1 à 5)

Commentaire

Modification / suppression

Calcul automatique de la note moyenne

Administrateur :

Liste de tous les avis

Suppression (modération)

4. Architecture du projet
4.1. Pattern MVC

Modèle : JavaBeans + DAO (JDBC)

Vue : JSP + JSTL + EL

Contrôleur : Servlets regroupées par rôle (admin / user)

4.2. Organisation des packages
src/
  com.example.reservationsalles.config
    DBConnection.java

  com.example.reservationsalles.model
    Utilisateur.java
    Salle.java
    Reservation.java
    AvisSalle.java
    SalleStats.java

  com.example.reservationsalles.dao
    UtilisateurDao.java
    SalleDao.java
    ReservationDao.java
    AvisSalleDao.java
    StatsDao.java

  com.example.reservationsalles.dao.impl
    UtilisateurDaoImpl.java
    SalleDaoImpl.java
    ReservationDaoImpl.java
    AvisSalleDaoImpl.java
    StatsDaoImpl.java

  com.example.reservationsalles.web.admin
    AdminDashboardServlet.java
    AdminUserServlet.java
    AdminSalleServlet.java
    AdminReservationServlet.java
    AdminStatsServlet.java
    AdminCalendarServlet.java
    AdminAvisServlet.java

  com.example.reservationsalles.web.user
    AuthServlet.java
    UserHomeServlet.java
    UserReservationServlet.java
    UserCalendarServlet.java
    UserSalleDetailsServlet.java

  com.example.reservationsalles.web.filter
    AuthFilter.java
    AdminFilter.java

4.3. Arborescence des vues (JSP)
WebContent/
  assets/
    css/
      style.css

  WEB-INF/
    web.xml

    views/
      includes/
        header.jsp
        footer.jsp

      auth/
        login.jsp

      admin/
        dashboard.jsp
        stats.jsp
        calendar.jsp
        users/
          list.jsp
          form.jsp
        salles/
          list.jsp
          form.jsp
        reservations/
          list.jsp
        avis/
          list.jsp

      user/
        home.jsp
        calendar.jsp
        reservations/
          list.jsp
          form.jsp
        salles/
          details.jsp

5. Base de données
5.1. Script SQL

Le fichier db.sql contient :

Création de la base reservation_salles

Tables :

utilisateur

salle

reservation

avis_salle

Contraintes :

PK, FK

CHECK : date_fin > date_debut

UNIQUE(id_salle, id_utilisateur) pour les avis

Données initiales :

admin / admin

users de test

salles de test

5.2. Configuration JDBC
private static final String URL = "jdbc:mysql://localhost:3306/reservation_salles";
private static final String USER = "root";
private static final String PASSWORD = "";


Adapter selon votre configuration.

6. Installation et lancement
6.1. Prérequis

JDK 8+

MySQL

Tomcat 10

Eclipse (ou similaire)

6.2. Étapes

Importer le projet dans Eclipse

Créer la base via db.sql

Configurer DBConnection.java

Vérifier le driver MySQL dans WEB-INF/lib

Configurer le serveur Tomcat 10

Lancer l’application :

http://localhost:8080/ReservationSalles/login

6.3. Comptes de test

Admin :

login : admin

mot de passe : admin

Utilisateurs :

user1 / user1

user2 / user2

7. Points techniques importants

Filtres de sécurité :

AuthFilter : protège /user/* et /admin/*

AdminFilter : protège /admin/*

Validation des réservations :

Vérification des chevauchements en DAO

Gestion stricte des statuts

Calendrier :

Construction d’une grille en mémoire (jours × heures)

Remplissage des créneaux en fonction des réservations

DAO :

Toutes les requêtes SQL passent par les DAO

MVC :

Les Servlets contrôlent, les JSP affichent

8. Améliorations possibles

Hachage des mots de passe (BCrypt)

Créneaux horaires plus fins (30 min)

Recherche avancée de salles

Internationalisation (FR/EN)

Export PDF / Excel

Notifications email

9. Auteurs

Arfaoui Nerimen-nerimenaf@gmail.com


Projet réalisé dans le cadre du module :
Développement d’applications Web avec Jakarta EE
Encadré par : Rafik Abbes, Nesrine Akrout
