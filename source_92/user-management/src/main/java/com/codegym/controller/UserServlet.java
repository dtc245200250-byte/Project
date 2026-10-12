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

/** Routes browser requests to DAO operations and JSP views. */
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
        } catch (SQLException | IllegalArgumentException exception) {
            throw new ServletException("Unable to load user data.", exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            switch (action == null ? "" : action) {
                case "create" -> {
                    User newUser = readUser(request, false);
                    // Exercise requirement: insertion is executed by a stored procedure.
                    userDAO.insertUserStore(newUser);
                }
                case "edit" -> {
                    User editedUser = readUser(request, true);
                    userDAO.updateUser(editedUser);
                }
                case "delete" -> userDAO.deleteUser(parseId(request));
                default -> {
                    response.sendRedirect(request.getContextPath() + "/users");
                    return;
                }
            }
            // Post/Redirect/Get avoids resubmitting the form on refresh.
            response.sendRedirect(request.getContextPath() + "/users");
        } catch (SQLException exception) {
            throw new ServletException("Unable to save user changes. Check the database and stored procedures.", exception);
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = request.getParameter("country");
        String sort = request.getParameter("sort");
        if (!"DESC".equalsIgnoreCase(sort)) {
            sort = "ASC";
        }

        List<User> users = userDAO.selectUsers(country, sort);
        request.setAttribute("listUser", users);
        request.setAttribute("country", country == null ? "" : country.trim());
        request.setAttribute("sort", sort);
        request.getRequestDispatcher("/user/list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = parseId(request);
        // Exercise requirement: find the user through get_user_by_id via CallableStatement.
        User existingUser = userDAO.getUserById(id);
        if (existingUser == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }
        request.setAttribute("user", existingUser);
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
        String name = value(request.getParameter("name"));
        String email = value(request.getParameter("email"));
        String country = value(request.getParameter("country"));

        if (name.isEmpty() || email.isEmpty()) {
            throw new IllegalArgumentException("Name and email are required");
        }
        if (includeId) {
            return new User(parseId(request), name, email, country);
        }
        return new User(name, email, country);
    }

    private int parseId(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        if (id < 1) {
            throw new IllegalArgumentException("Invalid user id");
        }
        return id;
    }

    private String value(String input) {
        return input == null ? "" : input.trim();
    }
}
