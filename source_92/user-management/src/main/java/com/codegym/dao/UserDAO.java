package com.codegym.dao;

import com.codegym.model.User;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** JDBC DAO. User lookup and insertion can be delegated to MySQL stored procedures. */
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

    /** Legacy direct JDBC insert retained for comparison with insertUserStore. */
    @Override
    public void insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users(name, email, country) VALUES (?, ?, ?)";
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
                    return mapUser(result);
                }
            }
        }
        return null;
    }

    /** Gets the user list with optional country substring filter and safe name sorting. */
    @Override
    public List<User> selectUsers(String country, String sortDirection) throws SQLException {
        String countryFilter = country == null ? "" : country.trim();
        String direction = "DESC".equalsIgnoreCase(sortDirection) ? "DESC" : "ASC";

        StringBuilder sql = new StringBuilder(
                "SELECT id, name, email, country FROM users");
        if (!countryFilter.isEmpty()) {
            sql.append(" WHERE country LIKE ?");
        }
        sql.append(" ORDER BY name ").append(direction).append(", id ASC");

        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            if (!countryFilter.isEmpty()) {
                statement.setString(1, "%" + countryFilter + "%");
            }
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    users.add(mapUser(result));
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

    /**
     * Calls the MySQL stored procedure get_user_by_id(IN user_id).
     * CallableStatement is used instead of embedding the SELECT in Java.
     */
    @Override
    public User getUserById(int id) throws SQLException {
        String call = "{CALL get_user_by_id(?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(call)) {
            statement.setInt(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return mapUser(result);
                }
            }
        }
        return null;
    }

    /**
     * Calls the MySQL stored procedure insert_user(IN user_name, IN user_email, IN user_country).
     */
    @Override
    public void insertUserStore(User user) throws SQLException {
        String call = "{CALL insert_user(?, ?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(call)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }


    /**
     * Inserts a user and all selected permissions atomically.
     * If any permission assignment fails, the user insert is rolled back too.
     */
    @Override
    public void addUserTransaction(User user, int[] permissionIds) throws SQLException {
        String insertUserSql = "INSERT INTO users(name, email, country) VALUES (?, ?, ?)";
        String insertPermissionSql =
                "INSERT INTO user_permission(user_id, permission_id) VALUES (?, ?)";

        try (Connection connection = getConnection()) {
            boolean originalAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);

            try {
                int userId;
                try (PreparedStatement userStatement = connection.prepareStatement(
                        insertUserSql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                    userStatement.setString(1, user.getName());
                    userStatement.setString(2, user.getEmail());
                    userStatement.setString(3, user.getCountry());
                    userStatement.executeUpdate();

                    try (ResultSet keys = userStatement.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException("Could not retrieve generated user ID.");
                        }
                        userId = keys.getInt(1);
                    }
                }

                if (permissionIds != null && permissionIds.length > 0) {
                    try (PreparedStatement permissionStatement =
                                 connection.prepareStatement(insertPermissionSql)) {
                        for (int permissionId : permissionIds) {
                            permissionStatement.setInt(1, userId);
                            permissionStatement.setInt(2, permissionId);
                            permissionStatement.executeUpdate();
                        }
                    }
                }

                connection.commit();
            } catch (SQLException | RuntimeException exception) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackException) {
                    exception.addSuppressed(rollbackException);
                }
                throw exception;
            } finally {
                try {
                    connection.setAutoCommit(originalAutoCommit);
                } catch (SQLException resetException) {
                    // Closing the connection below still releases the JDBC resource.
                }
            }
        }
    }

    private User mapUser(ResultSet result) throws SQLException {
        return new User(
                result.getInt("id"),
                result.getString("name"),
                result.getString("email"),
                result.getString("country"));
    }
}
