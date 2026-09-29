package murach.download;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import murach.business.User;
import murach.data.UserIO;
import murach.util.CookieUtil;

@WebServlet(name = "DownloadServlet", urlPatterns = {"/download"})
public class DownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // get current action
        String action = request.getParameter("action");
        if (action == null) {
            action = "viewAlbums"; // default action
        }

        // perform action and set URL to appropriate page
        String url = "/index.jsp";
        if (action.equals("viewAlbums")) {
            url = "/index.jsp";
        } else if (action.equals("checkUser")) {
            url = checkUser(request, response);
        } else if (action.equals("viewCookies")) {
            url = "/cookies.jsp";
        } else if (action.equals("deleteCookies")) {
            url = deleteCookies(request, response);
        } else if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            url = "/index.jsp";
        }

        // forward to the view
        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "viewAlbums";
        }

        // perform action and set URL to appropriate page
        String url = "/index.jsp";
        if (action.equals("registerUser")) {
            url = registerUser(request, response);
        } else if (action.equals("checkUser")) {
            url = checkUser(request, response);
        }

        // forward to the view
        getServletContext()
                .getRequestDispatcher(url)
                .forward(request, response);
    }

    private String checkUser(HttpServletRequest request, HttpServletResponse response) {
        String productCode = request.getParameter("productCode");
        HttpSession session = request.getSession();
        
        if (productCode != null && !productCode.trim().isEmpty()) {
            session.setAttribute("productCode", productCode);
        } else {
            productCode = (String) session.getAttribute("productCode");
        }

        if (productCode == null || productCode.trim().isEmpty()) {
            productCode = "8601";
            session.setAttribute("productCode", productCode);
        }

        User user = (User) session.getAttribute("user");
        String url;

        // if User object doesn't exist in session, check email cookie
        if (user == null) {
            Cookie[] cookies = request.getCookies();
            String emailAddress = CookieUtil.getCookieValue(cookies, "emailCookie");

            // if cookie doesn't exist, go to Registration page
            if (emailAddress == null || emailAddress.trim().isEmpty()) {
                url = "/register.jsp";
            } 
            // if cookie exists, create User object and go to Downloads page
            else {
                ServletContext sc = getServletContext();
                String path = sc.getRealPath("/WEB-INF/EmailList.txt");
                user = UserIO.getUser(emailAddress, path);
                
                if (user != null) {
                    session.setAttribute("user", user);
                    url = "/" + productCode + "_download.jsp";
                } else {
                    // Cookie existed but email was not found in file, redirect to register
                    User defaultUser = new User("Music", "Fan", emailAddress);
                    UserIO.add(defaultUser, path);
                    session.setAttribute("user", defaultUser);
                    url = "/" + productCode + "_download.jsp";
                }
            }
        } 
        // if User object exists in session, go to Downloads page
        else {
            url = "/" + productCode + "_download.jsp";
        }

        return url;
    }

    private String registerUser(HttpServletRequest request, HttpServletResponse response) {
        // get the user data
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        // Validate
        if (email == null || email.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty()) {
            
            request.setAttribute("message", "Please provide all required fields (Email, First Name, Last Name).");
            request.setAttribute("user", new User(firstName != null ? firstName : "", 
                                                 lastName != null ? lastName : "", 
                                                 email != null ? email : ""));
            return "/register.jsp";
        }

        // store the data in a User object
        User user = new User(firstName.trim(), lastName.trim(), email.trim());

        // write the User object to a file
        ServletContext sc = getServletContext();
        String path = sc.getRealPath("/WEB-INF/EmailList.txt");
        UserIO.add(user, path);

        // store the User object as a session attribute
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // add a cookie that stores the user's email to browser
        Cookie c = new Cookie("emailCookie", email.trim());
        c.setMaxAge(60 * 60 * 24 * 365 * 2); // set age to 2 years
        c.setPath("/");                      // allow entire app to access it
        response.addCookie(c);

        // create and return a URL for the appropriate Download page
        String productCode = (String) session.getAttribute("productCode");
        if (productCode == null || productCode.trim().isEmpty()) {
            productCode = "8601";
            session.setAttribute("productCode", productCode);
        }
        
        String url = "/" + productCode + "_download.jsp";
        return url;
    }

    private String deleteCookies(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0); // delete the cookie
                cookie.setPath("/"); // allow the download application to access it
                response.addCookie(cookie);
            }
        }
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        request.setAttribute("cookieMessage", "All persistent cookies have been cleared from the browser.");
        return "/cookies.jsp";
    }
}
