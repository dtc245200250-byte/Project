package com.codegym.dao;

import com.codegym.model.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC implementation of the User data access operations.
 * Country filtering uses a bound parameter; name sorting is restricted to ASC or DESC.
 */
public class UserDAO implements IUserDAO {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/demo?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private final String jdbcURL = setting("DB_URL", DEFAULT_URL);
    private final String jdbcUsername = setting("DB_USERNAME", "root");
    private final String jdbcPassword = setting("DB_PASSWORD", "password");

    private static String setting(String key, String fallback) {
        String value = System.getenv(key);
        return value == null || value.isBlank() ? fallback : value;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    @Override
    public void insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }

    @Override
    public User selectUser(int id) throws SQLException {
        String sql = "SELECT id, name, email, country FROM users WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return new User(
                            result.getInt("id"),
                            result.getString("name"),
                            result.getString("email"),
                            result.getString("country"));
                }
            }
        }
        return null;
    }

    /**
     * Searches country using a partial keyword and orders results by name.
     * The sort value is normalized to ASC or DESC before being inserted into SQL.
     */
    @Override
    public List<User> selectUsers(String country, String sortDirection) throws SQLException {
        String normalizedCountry = country == null ? "" : country.trim();
        String direction = "DESC".equalsIgnoreCase(sortDirection) ? "DESC" : "ASC";

        StringBuilder sql = new StringBuilder(
                "SELECT id, name, email, country FROM users");
        if (!normalizedCountry.isEmpty()) {
            sql.append(" WHERE country LIKE ?");
        }
        sql.append(" ORDER BY name ").append(direction).append(", id ASC");

        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            if (!normalizedCountry.isEmpty()) {
                statement.setString(1, "%" + normalizedCountry + "%");
            }

            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    users.add(new User(
                            result.getInt("id"),
                            result.getString("name"),
                            result.getString("email"),
                            result.getString("country")));
                }
            }
        }
        return users;
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, country = ? WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.setInt(4, user.getId());
            return statement.executeUpdate() > 0;
        }
    }
}
