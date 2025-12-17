<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:out value="${pageTitle != null ? pageTitle : 'Roomify Center'}"/>
    </title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        /* ===== ROOT VARIABLES ===== */
        :root {
            --primary: #4F46E5;
            --primary-dark: #3730A3;
            --primary-light: #818CF8;
            --primary-lighter: #E0E7FF;
            --accent: #F59E0B;
            --accent-light: #FCD34D;
            --success: #10B981;
            --success-light: #D1FAE5;
            --danger: #EF4444;
            --danger-light: #FEE2E2;
            --warning: #F59E0B;
            --warning-light: #FEF3C7;
            --info: #3B82F6;
            --info-light: #DBEAFE;
            --dark: #1E1B4B;
            --gray-900: #111827;
            --gray-700: #374151;
            --gray-600: #4B5563;
            --gray-500: #6B7280;
            --gray-400: #9CA3AF;
            --gray-300: #D1D5DB;
            --gray-200: #E5E7EB;
            --gray-100: #F3F4F6;
            --gray-50: #F9FAFB;
            --white: #FFFFFF;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --radius-sm: 8px;
            --radius: 12px;
            --radius-lg: 16px;
            --radius-xl: 24px;
            --transition: all 0.3s ease;
        }

        /* ===== RESET & BASE ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--gray-100);
            color: var(--gray-700);
            min-height: 100vh;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* ===== NAVBAR ===== */
        .roomify-navbar {
            background: var(--white);
            box-shadow: var(--shadow);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 70px;
        }

        /* Brand */
        .navbar-brand-custom {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 20px;
            box-shadow: var(--shadow-sm);
        }

        .brand-text {
            font-size: 22px;
            font-weight: 700;
            color: var(--dark);
        }

        .brand-text span {
            color: var(--primary);
        }

        /* Nav Links */
        .navbar-nav-custom {
            display: flex;
            align-items: center;
            gap: 8px;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-link-custom {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 500;
            color: var(--gray-600);
            transition: var(--transition);
            position: relative;
        }

        .nav-link-custom i {
            font-size: 16px;
        }

        .nav-link-custom:hover {
            background: var(--primary-lighter);
            color: var(--primary);
        }

        .nav-link-custom.active {
            background: var(--primary-lighter);
            color: var(--primary);
        }

        .nav-link-custom.active::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 50%;
            transform: translateX(-50%);
            width: 20px;
            height: 3px;
            background: var(--primary);
            border-radius: 2px;
        }

        /* User Section */
        .navbar-user {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            background: var(--gray-50);
            border-radius: var(--radius);
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 14px;
        }

        .user-details {
            line-height: 1.3;
        }

        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: var(--gray-900);
        }

        .user-role {
            font-size: 12px;
            color: var(--gray-500);
        }

        .user-role.admin {
            color: var(--primary);
        }

        .btn-logout {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: transparent;
            border: 2px solid var(--danger);
            border-radius: var(--radius-sm);
            color: var(--danger);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Poppins', sans-serif;
        }

        .btn-logout:hover {
            background: var(--danger);
            color: var(--white);
        }

        /* Mobile Toggle */
        .navbar-toggle {
            display: none;
            background: none;
            border: none;
            padding: 8px;
            cursor: pointer;
        }

        .navbar-toggle span {
            display: block;
            width: 24px;
            height: 2px;
            background: var(--gray-700);
            margin: 5px 0;
            transition: var(--transition);
            border-radius: 2px;
        }

        /* Mobile Menu */
        .mobile-menu {
            display: none;
            position: fixed;
            top: 70px;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--white);
            padding: 24px;
            z-index: 999;
            overflow-y: auto;
        }

        .mobile-menu.show {
            display: block;
        }

        .mobile-nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            border-radius: var(--radius-sm);
            font-size: 15px;
            font-weight: 500;
            color: var(--gray-600);
            margin-bottom: 8px;
            transition: var(--transition);
        }

        .mobile-nav-link:hover,
        .mobile-nav-link.active {
            background: var(--primary-lighter);
            color: var(--primary);
        }

        /* ===== MAIN CONTAINER ===== */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1024px) {
            .navbar-nav-custom {
                display: none;
            }

            .navbar-toggle {
                display: block;
            }

            .user-info {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .navbar-container {
                padding: 0 16px;
            }

            .brand-text {
                font-size: 18px;
            }

            .main-container {
                padding: 20px 16px;
            }
        }

        /* ===== UTILITY CLASSES ===== */
        .badge-role {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-admin {
            background: var(--primary-lighter);
            color: var(--primary);
        }

        .badge-user {
            background: var(--success-light);
            color: var(--success);
        }
    </style>
</head>
<body>

<c:set var="user" value="${userSession}" scope="request" />

<c:if test="${empty hideNavbar}">
<!-- ===== NAVBAR ===== -->
<nav class="roomify-navbar">
    <div class="navbar-container">
        <!-- Brand -->
        <a href="${pageContext.request.contextPath}/" class="navbar-brand-custom">
            <div class="brand-icon">
                <i class="fas fa-building"></i>
            </div>
            <span class="brand-text">Roomify <span>Center</span></span>
        </a>

        <!-- Navigation Links -->
        <ul class="navbar-nav-custom">
            <c:if test="${not empty user}">
                <c:choose>
                    <%-- ADMIN NAVIGATION --%>
                    <c:when test="${user.role == 'ADMIN'}">
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-chart-pie"></i>
                                Dashboard
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/salles">
                                <i class="fas fa-door-open"></i>
                                Salles
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i>
                                Utilisateurs
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/reservations">
                                <i class="fas fa-calendar-check"></i>
                                Réservations
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/calendar">
                                <i class="fas fa-calendar-alt"></i>
                                Calendrier
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/stats">
                                <i class="fas fa-chart-bar"></i>
                                Stats
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/avis">
                                <i class="fas fa-star"></i>
                                Avis
                            </a>
                        </li>
                    </c:when>
                    
                    <%-- USER NAVIGATION --%>
                    <c:otherwise>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/user/home">
                                <i class="fas fa-home"></i>
                                Accueil
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/user/reservations">
                                <i class="fas fa-bookmark"></i>
                                Mes réservations
                            </a>
                        </li>
                        <li>
                            <a class="nav-link-custom" href="${pageContext.request.contextPath}/user/calendar">
                                <i class="fas fa-calendar-alt"></i>
                                Calendrier
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </ul>

        <!-- User Section -->
        <div class="navbar-user">
            <c:if test="${not empty user}">
                <div class="user-info">
                    <div class="user-avatar">
                        ${user.nomComplet.substring(0,1).toUpperCase()}
                    </div>
                    <div class="user-details">
                        <div class="user-name">${user.nomComplet}</div>
                        <div class="user-role ${user.role == 'ADMIN' ? 'admin' : ''}">${user.role}</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </c:if>
            
            <!-- Mobile Toggle -->
            <button class="navbar-toggle" onclick="toggleMobileMenu()">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </div>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu" id="mobileMenu">
    <c:if test="${not empty user}">
        <!-- User Info Mobile -->
        <div class="user-info" style="display: flex; margin-bottom: 24px;">
            <div class="user-avatar">
                ${user.nomComplet.substring(0,1).toUpperCase()}
            </div>
            <div class="user-details">
                <div class="user-name">${user.nomComplet}</div>
                <div class="user-role ${user.role == 'ADMIN' ? 'admin' : ''}">${user.role}</div>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-chart-pie"></i> Dashboard
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/salles">
                    <i class="fas fa-door-open"></i> Salles
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i> Utilisateurs
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/reservations">
                    <i class="fas fa-calendar-check"></i> Réservations
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/calendar">
                    <i class="fas fa-calendar-alt"></i> Calendrier
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/stats">
                    <i class="fas fa-chart-bar"></i> Stats
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/admin/avis">
                    <i class="fas fa-star"></i> Avis
                </a>
            </c:when>
            <c:otherwise>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/user/home">
                    <i class="fas fa-home"></i> Accueil
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/user/reservations">
                    <i class="fas fa-bookmark"></i> Mes réservations
                </a>
                <a class="mobile-nav-link" href="${pageContext.request.contextPath}/user/calendar">
                    <i class="fas fa-calendar-alt"></i> Calendrier
                </a>
            </c:otherwise>
        </c:choose>
        
        <hr style="margin: 24px 0; border-color: var(--gray-200);">
        
        <a class="mobile-nav-link" href="${pageContext.request.contextPath}/logout" style="color: var(--danger);">
            <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
    </c:if>
</div>

<script>
    function toggleMobileMenu() {
        document.getElementById('mobileMenu').classList.toggle('show');
    }
</script>
</c:if>

<!-- ===== MAIN CONTAINER ===== -->
<main class="main-container">