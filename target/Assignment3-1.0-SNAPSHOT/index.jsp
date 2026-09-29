<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="murach.business.User"%>
<%@page import="murach.util.CookieUtil"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<%
    User currentUser = (User) session.getAttribute("user");
    Cookie[] cookies = request.getCookies();
    String emailCookie = CookieUtil.getCookieValue(cookies, "emailCookie");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Murach Music Store - Sound Choice Music Downloads</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>
    <header class="app-header">
        <div class="header-container">
            <a href="download?action=viewAlbums" class="brand-logo">
                <div class="logo-icon">🎵</div>
                <div class="brand-text">
                    <h1>Murach Music Store</h1>
                    <span>Sound Choice Digital Audio</span>
                </div>
            </a>
            <ul class="nav-links">
                <li><a href="download?action=viewAlbums" class="nav-link active">Albums</a></li>
                <li><a href="download?action=viewCookies" class="nav-link">Account &amp; Cookies</a></li>
                <% if (currentUser != null) { %>
                    <li>
                        <span class="user-badge">
                            <span class="indicator"></span>
                            <%= currentUser.getFirstName() %> <%= currentUser.getLastName() %>
                        </span>
                    </li>
                    <li><a href="download?action=logout" class="nav-link" style="color: #f87171;">Logout</a></li>
                <% } else if (emailCookie != null && !emailCookie.isEmpty()) { %>
                    <li>
                        <span class="user-badge" title="Recognized User">
                            👤 <%= emailCookie %>
                        </span>
                    </li>
                <% } %>
            </ul>
        </div>
    </header>

    <main class="container">
        <section class="hero-card">
            <h2>Sound Choice Music Downloads</h2>
            <p>Explore our exclusive collection of featured albums. Listen to audio previews and download original MP3 tracks in high fidelity.</p>
        </section>

        <div class="section-header">
            <h3>Featured Albums</h3>
            <span>Select an album to access music tracks</span>
        </div>

        <div class="albums-grid">
            <!-- Album 1: 8601 -->
            <div class="album-card">
                <div class="album-art bg-8601">
                    <span class="vinyl-icon">💿</span>
                    <span class="album-badge">CODE: 8601</span>
                </div>
                <div class="album-info">
                    <div>
                        <div class="album-artist">86 (the band)</div>
                        <h4 class="album-title">True Life Songs and Pictures</h4>
                        <div class="album-tracks-count">2 Available Tracks</div>
                    </div>
                    <a href="download?action=checkUser&amp;productCode=8601" class="album-btn">
                        Download Tracks &rarr;
                    </a>
                </div>
            </div>

            <!-- Album 2: pf01 -->
            <div class="album-card">
                <div class="album-art bg-pf01">
                    <span class="vinyl-icon">🎸</span>
                    <span class="album-badge">CODE: pf01</span>
                </div>
                <div class="album-info">
                    <div>
                        <div class="album-artist">Paddlefoot</div>
                        <h4 class="album-title">The First CD</h4>
                        <div class="album-tracks-count">3 Available Tracks</div>
                    </div>
                    <a href="download?action=checkUser&amp;productCode=pf01" class="album-btn">
                        Download Tracks &rarr;
                    </a>
                </div>
            </div>

            <!-- Album 3: pf02 -->
            <div class="album-card">
                <div class="album-art bg-pf02">
                    <span class="vinyl-icon">🎹</span>
                    <span class="album-badge">CODE: pf02</span>
                </div>
                <div class="album-info">
                    <div>
                        <div class="album-artist">Paddlefoot</div>
                        <h4 class="album-title">The Second CD</h4>
                        <div class="album-tracks-count">3 Available Tracks</div>
                    </div>
                    <a href="download?action=checkUser&amp;productCode=pf02" class="album-btn">
                        Download Tracks &rarr;
                    </a>
                </div>
            </div>

            <!-- Album 4: jr01 -->
            <div class="album-card">
                <div class="album-art bg-jr01">
                    <span class="vinyl-icon">📻</span>
                    <span class="album-badge">CODE: jr01</span>
                </div>
                <div class="album-info">
                    <div>
                        <div class="album-artist">Joe Rut</div>
                        <h4 class="album-title">Genuine Wood Grained Finish</h4>
                        <div class="album-tracks-count">2 Available Tracks</div>
                    </div>
                    <a href="download?action=checkUser&amp;productCode=jr01" class="album-btn">
                        Download Tracks &rarr;
                    </a>
                </div>
            </div>
        </div>
    </main>

    <footer class="app-footer">
        <p>&copy; 2026 Murach Music Store. All rights reserved.</p>
    </footer>
</body>
</html>
