<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="murach.business.User"%>
<%
    String message = (String) request.getAttribute("message");
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    if (user == null) {
        user = new User();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Download Registration - Murach Music Store</title>
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
            </ul>
        </div>
    </header>

    <main class="container">
        <div class="form-card">
            <h2>Download Registration</h2>
            <p class="subtitle">To download music tracks, please enter your name and email address below. Then click on the Register button.</p>

            <% if (message != null && !message.trim().isEmpty()) { %>
                <div class="alert alert-danger">
                    <span>⚠️</span>
                    <span><%= message %></span>
                </div>
            <% } %>

            <form action="download" method="post">
                <input type="hidden" name="action" value="registerUser">

                <div class="form-group">
                    <label for="email" class="pad_top">Email:</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" class="form-control" placeholder="your.email@example.com" required>
                </div>

                <div class="form-group">
                    <label for="firstName" class="pad_top">First Name:</label>
                    <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() %>" class="form-control" placeholder="First Name" required>
                </div>

                <div class="form-group">
                    <label for="lastName" class="pad_top">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() %>" class="form-control" placeholder="Last Name" required>
                </div>

                <button type="submit" class="btn-submit">
                    Register &amp; Download Tracks
                </button>
            </form>

            <div class="flex-actions" style="margin-top: 1.5rem; justify-content: center;">
                <a href="download?action=viewAlbums" class="nav-link">&larr; Return to Album List</a>
            </div>
        </div>
    </main>

    <footer class="app-footer">
        <p>&copy; 2026 Murach Music Store. All rights reserved.</p>
    </footer>
</body>
</html>
