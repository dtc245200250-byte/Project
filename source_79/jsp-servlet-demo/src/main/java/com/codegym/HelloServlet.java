package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * A small servlet endpoint for checking that the application is deployed correctly.
 */
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {
    private static final DateTimeFormatter DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss z");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String serverTime = ZonedDateTime.now().format(DATE_FORMAT);
        String contextPath = request.getContextPath();

        try (PrintWriter out = response.getWriter()) {
            out.println("<!doctype html>");
            out.println("<html lang=\"vi\">");
            out.println("<head>");
            out.println("  <meta charset=\"UTF-8\">");
            out.println("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            out.println("  <title>Hello Servlet</title>");
            out.println("  <style>");
            out.println("    body { font-family: Arial, sans-serif; margin: 0; min-height: 100vh;");
            out.println("      display: grid; place-items: center; background: #f3f6fb; color: #172554; }");
            out.println("    main { width: min(90%, 640px); padding: 36px; box-sizing: border-box;");
            out.println("      background: white; border-radius: 16px; box-shadow: 0 12px 36px #17255418; }");
            out.println("    h1 { margin-top: 0; } .time { color: #ea580c; font-size: 1.15rem; font-weight: bold; }");
            out.println("    a { display: inline-block; margin-top: 16px; color: #4338ca; }");
            out.println("  </style>");
            out.println("</head>");
            out.println("<body>");
            out.println("  <main>");
            out.println("    <h1>Chào mừng bạn đến với Servlet đầu tiên!</h1>");
            out.println("    <p>Servlet đang chạy trên Jakarta Servlet API.</p>");
            out.println("    <p>Thời gian máy chủ hiện tại:</p>");
            out.println("    <p class=\"time\">" + serverTime + "</p>");
            out.println("    <a href=\"" + contextPath + "/index.jsp\">Quay lại trang chủ JSP</a>");
            out.println("  </main>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
