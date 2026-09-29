<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<%@page import="murach.business.User"%>
<%@page import="murach.util.CookieUtil"%>
<%
    String cookieMessage = (String) request.getAttribute("cookieMessage");
    User currentUser = (User) session.getAttribute("user");
    Cookie[] cookies = request.getCookies();
    String emailCookie = CookieUtil.getCookieValue(cookies, "emailCookie");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account &amp; Cookie Preferences - Murach Music Store</title>
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
                <li><a href="download?action=viewCookies" class="nav-link active">Account &amp; Cookies</a></li>
                <% if (currentUser != null) { %>
                    <li>
                        <span class="user-badge">
                            <span class="indicator"></span>
                            <%= currentUser.getFirstName() %> <%= currentUser.getLastName() %>
                        </span>
                    </li>
                    <li><a href="download?action=logout" class="nav-link" style="color: #f87171;">Logout</a></li>
                <% } %>
            </ul>
        </div>
    </header>

    <main class="container">
        <% if (cookieMessage != null && !cookieMessage.isEmpty()) { %>
            <div class="alert alert-success">
                <span>✅</span>
                <span><%= cookieMessage %></span>
            </div>
        <% } %>

        <section class="hero-card">
            <h2>Account &amp; Cookie Preferences</h2>
            <p>Manage your active browser session and stored registration cookies for the Murach Music Store.</p>
        </section>

        <!-- Current Account Status -->
        <div class="inspector-card">
            <h4>Active User Session</h4>
            <div class="meta-list">
                <div class="meta-item">
                    <div class="meta-label">User Status</div>
                    <div class="meta-val" style="color: <%= currentUser != null ? "#34d399" : "#94a3b8" %>;">
                        <%= currentUser != null ? "Logged In / Registered" : "Not Registered in this Session" %>
                    </div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Registered Name</div>
                    <div class="meta-val"><%= currentUser != null ? (currentUser.getFirstName() + " " + currentUser.getLastName()) : "—" %></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Registered Email</div>
                    <div class="meta-val"><%= currentUser != null ? currentUser.getEmail() : "—" %></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Remembered Email (Cookie)</div>
                    <div class="meta-val"><%= (emailCookie != null && !emailCookie.isEmpty()) ? emailCookie : "None" %></div>
                </div>
            </div>
        </div>

        <!-- Cookies Table -->
        <div class="section-header">
            <h3>Stored Browser Cookies</h3>
            <span>Total cookies: <%= cookies != null ? cookies.length : 0 %></span>
        </div>

        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width: 35%;">Cookie Name</th>
                    <th style="width: 45%;">Value</th>
                    <th style="width: 20%;">Type</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (cookies != null && cookies.length > 0) {
                        for (Cookie c : cookies) {
                %>
                <tr>
                    <td>
                        <strong style="color: #a5b4fc;"><%= c.getName() %></strong>
                        <% if ("emailCookie".equals(c.getName())) { %>
                            <span class="badge" style="background: rgba(16, 185, 129, 0.2); color: #6ee7b7; margin-left: 0.5rem;">Persistent</span>
                        <% } else if ("JSESSIONID".equalsIgnoreCase(c.getName())) { %>
                            <span class="badge" style="background: rgba(59, 130, 246, 0.2); color: #93c5fd; margin-left: 0.5rem;">Session</span>
                        <% } %>
                    </td>
                    <td><code style="color: #38bdf8; word-break: break-all;"><%= c.getValue() %></code></td>
                    <td><%= "emailCookie".equals(c.getName()) ? "Persistent (2 Years)" : "Session" %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" style="text-align: center; color: #94a3b8; padding: 2rem;">
                        No cookies currently stored for this domain.
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Actions -->
        <div class="flex-actions">
            <a href="download?action=viewAlbums" class="btn-secondary">&larr; Return to Albums</a>
            <a href="download?action=deleteCookies" class="btn-danger" onclick="return confirm('Are you sure you want to clear your stored cookies and reset your session?');">
                🗑️ Clear All Stored Cookies &amp; Reset Session
            </a>
        </div>
    </main>

    <footer class="app-footer">
        <p>&copy; 2026 Murach Music Store. All rights reserved.</p>
    </footer>
</body>
</html>
