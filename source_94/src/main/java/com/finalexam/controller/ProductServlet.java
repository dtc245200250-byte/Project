package com.finalexam.controller;

import com.finalexam.dao.ProductDAO;
import com.finalexam.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDAO dao;
    @Override public void init() { dao = new ProductDAO(); }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            if ("new".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            } else if ("edit".equals(action)) {
                int id;
                try { id = positiveInt(req.getParameter("id"), "ID sản phẩm"); }
                catch (IllegalArgumentException e) { resp.sendError(400, e.getMessage()); return; }
                Product p = dao.findById(id);
                if (p == null) { resp.sendError(404, "Không tìm thấy sản phẩm."); return; }
                req.setAttribute("product", p); req.setAttribute("editMode", true);
                req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
            } else {
                req.setAttribute("products", dao.findAll());
                req.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(req, resp);
            }
        } catch (SQLException e) { throw new ServletException("Không thể truy cập dữ liệu sản phẩm.", e); }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            String action = req.getParameter("action");
            if ("insert".equals(action)) {
                dao.insert(readProduct(req));
                resp.sendRedirect(req.getContextPath() + "/products?message=added");
            } else if ("update".equals(action)) {
                Product p = readProduct(req); p.setId(positiveInt(req.getParameter("id"), "ID sản phẩm"));
                if (dao.update(p)) resp.sendRedirect(req.getContextPath() + "/products?message=updated");
                else resp.sendError(404, "Không tìm thấy sản phẩm.");
            } else if ("delete".equals(action)) {
                dao.delete(positiveInt(req.getParameter("id"), "ID sản phẩm"));
                resp.sendRedirect(req.getContextPath() + "/products?message=deleted");
            } else resp.sendError(400, "Thao tác không hợp lệ.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage()); req.setAttribute("product", new Product());
            req.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(req, resp);
        } catch (SQLException e) { throw new ServletException("Không thể lưu dữ liệu sản phẩm.", e); }
    }

    private Product readProduct(HttpServletRequest req) {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) throw new IllegalArgumentException("Tên sản phẩm không được để trống.");
        if (name.trim().length() > 150) throw new IllegalArgumentException("Tên sản phẩm tối đa 150 ký tự.");
        try {
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            if (price.compareTo(BigDecimal.ZERO) < 0 || price.scale() > 2) throw new IllegalArgumentException("Giá phải không âm và có tối đa 2 chữ số thập phân.");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            if (quantity < 0) throw new IllegalArgumentException("Số lượng phải lớn hơn hoặc bằng 0.");
            return new Product(name.trim(), price, quantity);
        } catch (NumberFormatException | NullPointerException e) {
            throw new IllegalArgumentException("Giá và số lượng phải là số hợp lệ.");
        }
    }
    private int positiveInt(String value, String field) {
        try { int n = Integer.parseInt(value); if (n > 0) return n; }
        catch (NumberFormatException | NullPointerException ignored) {}
        throw new IllegalArgumentException(field + " không hợp lệ.");
    }
}