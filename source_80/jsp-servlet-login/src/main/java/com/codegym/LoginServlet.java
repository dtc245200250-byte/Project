package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean authenticated = "admin".equals(username) && "admin".equals(password);

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>Login Result</title>");
            out.println("<style>");
            out.println("body{font-family:Arial,sans-serif;min-height:100vh;display:grid;place-items:center;margin:0;background:#f8fafc;color:#172554}");
            out.println(".result{padding:36px 42px;background:#fff;border-radius:14px;box-shadow:0 12px 35px rgba(30,41,59,.12);text-align:center}");
            out.println(".success{color:#15803d}.error{color:#dc2626}");
            out.println("a{display:inline-block;margin-top:16px;color:#3730a3}");
            out.println("</style></head><body><main class=\"result\">");

            if (authenticated) {
                out.println("<h1 class=\"success\">Welcome admin to website</h1>");
            } else {
                out.println("<h1 class=\"error\">Login Error</h1>");
            }

            out.println("<a href=\"" + request.getContextPath() + "/index.jsp\">Go back</a>");
            out.println("</main></body></html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
