package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ConverterServlet", urlPatterns = "/convert")
public class ConverterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String rateInput = request.getParameter("rate");
        String usdInput = request.getParameter("usd");

        try {
            BigDecimal rate = new BigDecimal(rateInput);
            BigDecimal usd = new BigDecimal(usdInput);

            if (rate.signum() <= 0 || usd.signum() < 0) {
                renderError(response, "Tỉ giá phải lớn hơn 0 và lượng USD không được âm.");
                return;
            }

            BigDecimal vnd = rate.multiply(usd);
            NumberFormat formatter = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN"));
            formatter.setMinimumFractionDigits(0);
            formatter.setMaximumFractionDigits(2);

            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang=\"vi\"><head>");
                out.println("<meta charset=\"UTF-8\">");
                out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
                out.println("<title>Kết quả chuyển đổi</title>");
                out.println("<style>");
                out.println("*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f1f5f9;color:#172554}");
                out.println(".card{width:100%;max-width:520px;padding:36px;border-radius:18px;background:#fff;box-shadow:0 18px 48px rgba(15,23,42,.12);text-align:center}");
                out.println(".eyebrow{font-size:12px;letter-spacing:1.5px;text-transform:uppercase;color:#4f46e5;font-weight:700}");
                out.println("h1{font-size:25px}.amount{margin:24px 0;color:#15803d;font-size:clamp(24px,5vw,34px);font-weight:800;overflow-wrap:anywhere}");
                out.println(".detail{color:#475569;line-height:1.8}.back{display:inline-block;margin-top:18px;padding:12px 18px;border-radius:9px;background:#3730a3;color:white;text-decoration:none;font-weight:700}");
                out.println("</style></head><body><main class=\"card\">");
                out.println("<p class=\"eyebrow\">Kết quả chuyển đổi</p>");
                out.println("<h1>USD → VNĐ</h1>");
                out.println("<p class=\"detail\">Tỉ giá: " + formatter.format(rate) + " VNĐ/USD</p>");
                out.println("<p class=\"detail\">Số tiền USD: $" + formatter.format(usd) + "</p>");
                out.println("<p class=\"amount\">" + formatter.format(vnd) + " VNĐ</p>");
                out.println("<a class=\"back\" href=\"" + request.getContextPath() + "/index.jsp\">Quay lại</a>");
                out.println("</main></body></html>");
            }
        } catch (NumberFormatException | NullPointerException ex) {
            renderError(response, "Vui lòng nhập tỉ giá và lượng USD dưới dạng số hợp lệ.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private void renderError(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html><html lang=\"vi\"><head><meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Lỗi nhập liệu</title>");
            out.println("<style>body{font-family:Arial,sans-serif;min-height:100vh;display:grid;place-items:center;margin:0;background:#f8fafc}.box{text-align:center;padding:32px;background:#fff;border-radius:14px;box-shadow:0 12px 35px #0f172a18}.error{color:#dc2626}a{color:#3730a3}</style>");
            out.println("</head><body><main class=\"box\"><h2 class=\"error\">Không thể chuyển đổi</h2>");
            out.println("<p>" + message + "</p><a href=\"" + getServletContext().getContextPath() + "/index.jsp\">Quay lại</a>");
            out.println("</main></body></html>");
        }
    }
}
