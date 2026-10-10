package com.codegym.controller;

import com.codegym.model.Product;
import com.codegym.service.ProductService;
import com.codegym.service.ProductServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * MVC controller for listing, searching, viewing, creating, updating and
 * deleting products. Presentation is delegated to JSP views.
 */
@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        switch (action) {
            case "create" -> showCreateForm(request, response);
            case "edit" -> showEditForm(request, response);
            case "delete" -> showDeleteForm(request, response);
            case "view" -> viewProduct(request, response);
            case "search" -> searchProducts(request, response);
            default -> listProducts(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        switch (action) {
            case "create" -> createProduct(request, response);
            case "update" -> updateProduct(request, response);
            case "delete" -> deleteProduct(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("products", productService.findAll());
        request.setAttribute("keyword", "");
        request.getRequestDispatcher("/product/list.jsp").forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> products = productService.searchByName(keyword);
        request.setAttribute("products", products);
        request.setAttribute("keyword", keyword == null ? "" : keyword.trim());
        request.getRequestDispatcher("/product/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/product/create.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = findRequestedProduct(request);
        if (product == null) {
            forwardNotFound(request, response);
            return;
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product/edit.jsp").forward(request, response);
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = findRequestedProduct(request);
        if (product == null) {
            forwardNotFound(request, response);
            return;
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product/delete.jsp").forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = findRequestedProduct(request);
        if (product == null) {
            forwardNotFound(request, response);
            return;
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product/view.jsp").forward(request, response);
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Product product = readProduct(request);
            productService.save(product);
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (IllegalArgumentException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            request.getRequestDispatcher("/product/create.jsp").forward(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product existing = findRequestedProduct(request);
        if (existing == null) {
            forwardNotFound(request, response);
            return;
        }

        try {
            Product updated = readProduct(request);
            productService.update(existing.getId(), updated);
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (IllegalArgumentException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            request.setAttribute("product", existing);
            request.getRequestDispatcher("/product/edit.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = findRequestedProduct(request);
        if (product == null) {
            forwardNotFound(request, response);
            return;
        }
        productService.remove(product.getId());
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private Product readProduct(HttpServletRequest request) {
        String name = trim(request.getParameter("name"));
        String priceInput = trim(request.getParameter("price"));
        String description = trim(request.getParameter("description"));
        String manufacturer = trim(request.getParameter("manufacturer"));

        if (name.isEmpty()) {
            throw new IllegalArgumentException("Product name is required.");
        }
        if (manufacturer.isEmpty()) {
            throw new IllegalArgumentException("Manufacturer is required.");
        }
        if (priceInput.isEmpty()) {
            throw new IllegalArgumentException("Price is required.");
        }

        BigDecimal price;
        try {
            price = new BigDecimal(priceInput);
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException("Enter a valid product price.");
        }
        if (price.signum() < 0) {
            throw new IllegalArgumentException("Price cannot be negative.");
        }

        return new Product(0, name, price, description, manufacturer);
    }

    private Product findRequestedProduct(HttpServletRequest request) {
        String rawId = request.getParameter("id");
        if (rawId == null) {
            return null;
        }
        try {
            long id = Long.parseLong(rawId);
            return id > 0 ? productService.findById(id) : null;
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private void forwardNotFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        request.setAttribute("errorMessage", "The requested product does not exist or may have been removed.");
        request.getRequestDispatcher("/error-404.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
