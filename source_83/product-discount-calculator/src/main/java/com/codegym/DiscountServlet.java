package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiscountServlet", urlPatterns = "/display-discount")
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String description = request.getParameter("productDescription");
        String listPriceInput = request.getParameter("listPrice");
        String discountPercentInput = request.getParameter("discountPercent");

        try {
            if (description == null || description.trim().isEmpty()) {
                renderError(response, "Please enter a product description.");
                return;
            }

            BigDecimal listPrice = new BigDecimal(listPriceInput);
            BigDecimal discountPercent = new BigDecimal(discountPercentInput);

            if (listPrice.signum() <= 0) {
                renderError(response, "List Price must be greater than zero.");
                return;
            }
            if (discountPercent.compareTo(BigDecimal.ZERO) < 0
                    || discountPercent.compareTo(new BigDecimal("100")) > 0) {
                renderError(response, "Discount Percent must be between 0 and 100.");
                return;
            }

            BigDecimal discountAmount = listPrice
                    .multiply(discountPercent)
                    .multiply(new BigDecimal("0.01"))
                    .setScale(2, RoundingMode.HALF_UP);

            BigDecimal discountPrice = listPrice
                    .subtract(discountAmount)
                    .setScale(2, RoundingMode.HALF_UP);

            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.US);
            currencyFormat.setMinimumFractionDigits(2);
            currencyFormat.setMaximumFractionDigits(2);

            NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
            numberFormat.setMinimumFractionDigits(0);
            numberFormat.setMaximumFractionDigits(2);

            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang=\"en\"><head>");
                out.println("<meta charset=\"UTF-8\">");
                out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
                out.println("<title>Discount Result</title>");
                out.println("<style>");
                out.println("*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f1f5f9;color:#172554}");
                out.println(".result{width:100%;max-width:560px;padding:36px;border-radius:18px;background:#fff;box-shadow:0 18px 48px rgba(15,23,42,.12)}");
                out.println(".eyebrow{font-size:12px;letter-spacing:1.5px;text-transform:uppercase;color:#4f46e5;font-weight:700;text-align:center}");
                out.println("h1{text-align:center;font-size:27px;margin:10px 0 28px;overflow-wrap:anywhere}");
                out.println(".row{display:flex;justify-content:space-between;gap:20px;padding:14px 0;border-bottom:1px solid #e2e8f0;line-height:1.5}");
                out.println(".label{color:#64748b}.value{text-align:right;font-weight:700;overflow-wrap:anywhere}");
                out.println(".discount{color:#15803d}.final{margin-top:20px;padding:20px;border-radius:12px;background:#eef2ff;text-align:center}");
                out.println(".final .label{display:block;margin-bottom:8px}.price{font-size:30px;font-weight:800;color:#3730a3;overflow-wrap:anywhere}");
                out.println(".back{display:block;margin-top:22px;padding:13px;border-radius:9px;background:#3730a3;color:#fff;text-align:center;text-decoration:none;font-weight:700}");
                out.println("</style></head><body><main class=\"result\">");
                out.println("<p class=\"eyebrow\">Calculation complete</p>");
                out.println("<h1>Discount Summary</h1>");
                out.println("<div class=\"row\"><span class=\"label\">Product Description</span><span class=\"value\">"
                        + escapeHtml(description.trim()) + "</span></div>");
                out.println("<div class=\"row\"><span class=\"label\">List Price</span><span class=\"value\">"
                        + currencyFormat.format(listPrice) + "</span></div>");
                out.println("<div class=\"row\"><span class=\"label\">Discount Percent</span><span class=\"value\">"
                        + numberFormat.format(discountPercent) + "%</span></div>");
                out.println("<div class=\"row\"><span class=\"label\">Discount Amount</span><span class=\"value discount\">−"
                        + currencyFormat.format(discountAmount) + "</span></div>");
                out.println("<section class=\"final\"><span class=\"label\">Discount Price</span><div class=\"price\">"
                        + currencyFormat.format(discountPrice) + "</div></section>");
                out.println("<a class=\"back\" href=\"" + request.getContextPath()
                        + "/index.jsp\">Calculate another product</a>");
                out.println("</main></body></html>");
            }
        } catch (NumberFormatException | NullPointerException ex) {
            renderError(response, "Please enter valid numeric values for List Price and Discount Percent.");
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
            out.println("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Input Error</title>");
            out.println("<style>body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;background:#f8fafc}.box{max-width:460px;padding:32px;border-radius:14px;background:white;box-shadow:0 12px 35px #0f172a18;text-align:center}.error{color:#dc2626}a{color:#3730a3}</style>");
            out.println("</head><body><main class=\"box\"><h2 class=\"error\">Unable to calculate discount</h2>");
            out.println("<p>" + escapeHtml(message) + "</p><a href=\"" + request.getContextPath() + "/index.jsp\">Go back</a>");
            out.println("</main></body></html>");
        }
    }

    private static String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
