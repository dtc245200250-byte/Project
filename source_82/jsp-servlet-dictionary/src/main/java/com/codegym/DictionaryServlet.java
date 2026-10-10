package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DictionaryServlet", urlPatterns = "/translate")
public class DictionaryServlet extends HttpServlet {

    private static final Map<String, String> DICTIONARY = Map.of(
            "hello", "Xin chào",
            "how", "Thế nào",
            "book", "Quyển sách",
            "computer", "Máy tính",
            "student", "Sinh viên",
            "apple", "Quả táo",
            "thank you", "Cảm ơn",
            "school", "Trường học"
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String submittedWord = request.getParameter("word");
        String normalizedWord = submittedWord == null
                ? ""
                : submittedWord.trim().toLowerCase(Locale.ROOT);

        String meaning = DICTIONARY.get(normalizedWord);

        response.setStatus(HttpServletResponse.SC_OK);
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"vi\"><head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>Kết quả tra cứu</title>");
            out.println("<style>");
            out.println("*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f1f5f9;color:#172554}");
            out.println(".card{width:100%;max-width:520px;padding:36px;border-radius:18px;background:#fff;box-shadow:0 18px 48px rgba(15,23,42,.12);text-align:center}");
            out.println(".eyebrow{font-size:12px;letter-spacing:1.5px;text-transform:uppercase;color:#4f46e5;font-weight:700}");
            out.println("h1{font-size:26px;overflow-wrap:anywhere}.meaning{font-size:24px;font-weight:800;color:#15803d;overflow-wrap:anywhere}.not-found{color:#dc2626;font-size:20px;overflow-wrap:anywhere}");
            out.println(".back{display:inline-block;margin-top:20px;padding:12px 18px;border-radius:9px;background:#3730a3;color:#fff;text-decoration:none;font-weight:700}");
            out.println("</style></head><body><main class=\"card\">");
            out.println("<p class=\"eyebrow\">Dictionary result</p>");

            if (normalizedWord.isEmpty()) {
                out.println("<h1 class=\"not-found\">Vui lòng nhập từ cần tra cứu.</h1>");
            } else if (meaning != null) {
                out.println("<h1>Từ khóa: " + escapeHtml(submittedWord.trim()) + "</h1>");
                out.println("<p class=\"meaning\">Nghĩa tiếng Việt: " + escapeHtml(meaning) + "</p>");
            } else {
                out.println("<h1 class=\"not-found\">Không tìm thấy từ: "
                        + escapeHtml(submittedWord.trim()) + "</h1>");
            }

            out.println("<a class=\"back\" href=\"" + request.getContextPath()
                    + "/index.jsp\">Quay lại tra cứu</a>");
            out.println("</main></body></html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private static String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
