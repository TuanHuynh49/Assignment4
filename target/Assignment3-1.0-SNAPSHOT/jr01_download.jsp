<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="murach.business.User"%>
<%
    User currentUser = (User) session.getAttribute("user");
    String productCode = (String) session.getAttribute("productCode");
    if (productCode == null || productCode.isEmpty()) {
        productCode = "jr01";
    }
    String userDisplay = (currentUser != null) ? (currentUser.getFirstName() + " " + currentUser.getLastName()) : "Music Fan";
    String emailDisplay = (currentUser != null) ? currentUser.getEmail() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Joe Rut - Downloads | Murach Music Store</title>
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
                <li><a href="download?action=viewAlbums" class="nav-link">Albums</a></li>
                <li><a href="download?action=viewCookies" class="nav-link">Account &amp; Cookies</a></li>
                <% if (currentUser != null) { %>
                    <li>
                        <span class="user-badge">
                            <span class="indicator"></span>
                            <%= userDisplay %>
                        </span>
                    </li>
                    <li><a href="download?action=logout" class="nav-link" style="color: #f87171;">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </header>

    <main class="container">
        <div class="download-hero">
            <div class="album-cover-lg bg-jr01">
                📻
            </div>
            <div class="download-details">
                <span class="badge">ALBUM: <%= productCode %></span>
                <h2>Joe Rut - Genuine Wood Grained Finish</h2>
                <p>Welcome, <strong><%= userDisplay %></strong> (<code style="color: #38bdf8;"><%= emailDisplay %></code>). Listen to the preview player or download your songs below.</p>
            </div>
        </div>

        <div class="section-header">
            <h3>Downloadable Tracks</h3>
            <span>Full MP3 Audio Quality</span>
        </div>

        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width: 35%;">Song Title</th>
                    <th style="width: 20%;">Audio Format</th>
                    <th style="width: 45%;">Listen &amp; Download</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Filter</strong></td>
                    <td><span class="badge" style="background: rgba(249, 115, 22, 0.2); color: #fdba74;">MP3 Audio</span></td>
                    <td>
                        <div class="audio-player-wrapper">
                            <audio controls src="sound/<%= productCode %>/filter.mp3"></audio>
                            <a href="sound/<%= productCode %>/filter.mp3" download class="download-link">
                                ⬇️ Download MP3
                            </a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><strong>Hitchhiker</strong></td>
                    <td><span class="badge" style="background: rgba(249, 115, 22, 0.2); color: #fdba74;">MP3 Audio</span></td>
                    <td>
                        <div class="audio-player-wrapper">
                            <audio controls src="sound/<%= productCode %>/hitchhiker.mp3"></audio>
                            <a href="sound/<%= productCode %>/hitchhiker.mp3" download class="download-link">
                                ⬇️ Download MP3
                            </a>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="flex-actions">
            <a href="download?action=viewAlbums" class="btn-secondary">&larr; Return to All Albums</a>
            <a href="download?action=viewCookies" class="btn-secondary">Manage Account &amp; Cookies</a>
        </div>
    </main>

    <footer class="app-footer">
        <p>&copy; 2026 Murach Music Store. All rights reserved.</p>
    </footer>
</body>
</html>
