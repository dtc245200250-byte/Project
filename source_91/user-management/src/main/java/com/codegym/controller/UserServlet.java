package com.codegym.controller;

import com.codegym.dao.IUserDAO;
import com.codegym.dao.UserDAO;
import com.codegym.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/** MVC controller for user list, country search, name sort and CRUD actions. */
@WebServlet(name = "UserServlet", urlPatterns = "/users")
public class UserServlet extends HttpServlet {
    private IUserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        try {
            switch (action) {
                case "create" -> request.getRequestDispatcher("/user/create.jsp").forward(request, response);
                case "edit" -> showEditForm(request, response);
                case "delete" -> showDeleteForm(request, response);
                default -> listUsers(request, response);
            }
        } catch (SQLException | NumberFormatException ex) {
            throw new ServletException("Unable to load user data.", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            switch (action == null ? "" : action) {
                case "create" -> userDAO.insertUser(readUser(request, false));
                case "edit" -> userDAO.updateUser(readUser(request, true));
                case "delete" -> userDAO.deleteUser(parseId(request));
                default -> {
                    response.sendRedirect(request.getContextPath() + "/users");
                    return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/users");
        } catch (SQLException ex) {
            throw new ServletException("Unable to save user changes. Check the database connection.", ex);
        } catch (IllegalArgumentException ex) {
            request.setAttribute("errorMessage", "Dữ liệu nhập vào không hợp lệ. Vui lòng kiểm tra lại.");
            if ("edit".equals(action)) {
                try {
                    request.setAttribute("user", userDAO.selectUser(parseId(request)));
                } catch (SQLException sqlException) {
                    throw new ServletException("Unable to reload user data.", sqlException);
                }
                request.getRequestDispatcher("/user/edit.jsp").forward(request, response);
            } else if ("create".equals(action)) {
                request.getRequestDispatcher("/user/create.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/users");
            }
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = request.getParameter("country");
        String sort = request.getParameter("sort");
        if (sort == null || (!"ASC".equalsIgnoreCase(sort) && !"DESC".equalsIgnoreCase(sort))) {
            sort = "ASC";
        }

        List<User> users = userDAO.selectUsers(country, sort);
        request.setAttribute("listUser", users);
        request.setAttribute("country", country == null ? "" : country.trim());
        request.setAttribute("sort", sort.toUpperCase());
        request.getRequestDispatcher("/user/list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        User user = userDAO.selectUser(parseId(request));
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("/user/edit.jsp").forward(request, response);
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        User user = userDAO.selectUser(parseId(request));
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("/user/delete.jsp").forward(request, response);
    }

    private User readUser(HttpServletRequest request, boolean includeId) {
        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email"));
        String country = trim(request.getParameter("country"));

        if (name.isEmpty() || email.isEmpty()) {
            throw new IllegalArgumentException("Tên và email không được để trống.");
        }

        if (includeId) {
            return new User(parseId(request), name, email, country);
        }
        return new User(name, email, country);
    }

    private int parseId(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (id < 1) {
            throw new IllegalArgumentException("ID không hợp lệ.");
        }
        return id;
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
