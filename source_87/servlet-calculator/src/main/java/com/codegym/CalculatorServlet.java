package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CalculatorServlet", urlPatterns = "/calculate")
public class CalculatorServlet extends HttpServlet {

    private final Calculator calculator = new Calculator();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String firstInput = request.getParameter("firstOperand");
        String secondInput = request.getParameter("secondOperand");
        String operator = request.getParameter("operator");

        String errorMessage = null;
        Double firstOperand = null;
        Double secondOperand = null;
        Double result = null;

        try {
            if (firstInput == null || firstInput.isBlank()
                    || secondInput == null || secondInput.isBlank()
                    || operator == null || operator.isBlank()) {
                throw new IllegalArgumentException("Vui lòng nhập đủ hai toán hạng và chọn phép tính.");
            }

            firstOperand = Double.parseDouble(firstInput.trim());
            secondOperand = Double.parseDouble(secondInput.trim());

            if (!Double.isFinite(firstOperand) || !Double.isFinite(secondOperand)) {
                throw new IllegalArgumentException("Vui lòng nhập các số hợp lệ.");
            }

            result = calculator.calculate(firstOperand, secondOperand, operator);
            if (!Double.isFinite(result)) {
                throw new ArithmeticException("Kết quả vượt quá phạm vi tính toán.");
            }
        } catch (NumberFormatException ex) {
            errorMessage = "Dữ liệu nhập vào không hợp lệ. Hãy nhập hai số.";
        } catch (ArithmeticException | IllegalArgumentException ex) {
            errorMessage = ex.getMessage();
        }

        String operatorSymbol = switch (operator == null ? "" : operator) {
            case "add" -> "+";
            case "subtract" -> "−";
            case "multiply" -> "×";
            case "divide" -> "÷";
            default -> "?";
        };

        DecimalFormat numberFormat = new DecimalFormat(
                "#,##0.########",
                DecimalFormatSymbols.getInstance(Locale.US));

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"vi\"><head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>Kết quả máy tính</title>");
            out.println("<style>");
            out.println("*{box-sizing:border-box}body{min-height:100vh;margin:0;padding:24px;display:grid;place-items:center;font-family:Arial,sans-serif;color:#172554;background:linear-gradient(135deg,#eef2ff,#f8fafc 58%,#ecfeff)}");
            out.println(".card{width:100%;max-width:520px;padding:36px;border:1px solid #e2e8f0;border-radius:18px;background:#fff;box-shadow:0 20px 55px rgba(15,23,42,.12)}");
            out.println(".eyebrow{margin:0 0 10px;color:#4f46e5;font-size:12px;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;text-align:center}");
            out.println("h1{text-align:center;font-size:27px;margin:0 0 26px}.equation{padding:20px 14px;border-radius:12px;background:#eef2ff;text-align:center;font-size:22px;font-weight:700;overflow-wrap:anywhere}");
            out.println(".result{margin:20px 0;padding:22px 14px;border-radius:12px;background:#ecfdf5;text-align:center}.result-label{color:#64748b;font-size:13px}.result-value{display:block;margin-top:8px;color:#15803d;font-size:clamp(28px,6vw,36px);font-weight:800;overflow-wrap:anywhere}");
            out.println(".error{margin:20px 0;padding:18px;border-radius:12px;background:#fef2f2;color:#b91c1c;line-height:1.6;text-align:center}");
            out.println(".back{display:block;margin-top:22px;padding:13px;border-radius:9px;background:#3730a3;color:#fff;text-align:center;text-decoration:none;font-weight:700}.back:hover{background:#312e81}");
            out.println("</style></head><body><main class=\"card\">");
            out.println("<p class=\"eyebrow\">Basic calculator</p><h1>Kết quả phép tính</h1>");

            if (errorMessage == null) {
                out.println("<div class=\"equation\">" + numberFormat.format(firstOperand) + " "
                        + operatorSymbol + " " + numberFormat.format(secondOperand) + "</div>");
                out.println("<section class=\"result\"><span class=\"result-label\">Kết quả</span><strong class=\"result-value\">"
                        + numberFormat.format(result) + "</strong></section>");
            } else {
                out.println("<div class=\"error\"><strong>Không thể thực hiện phép tính</strong><br>"
                        + escapeHtml(errorMessage) + "</div>");
            }

            out.println("<a class=\"back\" href=\"" + request.getContextPath()
                    + "/index.jsp\">Quay lại máy tính</a>");
            out.println("</main></body></html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private static String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
