package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/** MySQL/JDBC storage implementation for iNotes. */
public class NoteDBStrategy implements NoteStrategy {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/inotes_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private final String jdbcUrl = setting("INOTES_DB_URL", DEFAULT_URL);
    private final String jdbcUsername = setting("INOTES_DB_USERNAME", "root");
    private final String jdbcPassword = setting("INOTES_DB_PASSWORD", "password");

    private static String setting(String key, String fallback) {
        String value = System.getenv(key);
        return value == null || value.isBlank() ? fallback : value;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
    }

    @Override
    public void save(Note note) throws SQLException {
        if (note.getId() > 0) {
            String updateSql = "UPDATE notes SET title = ?, content = ?, type_id = ? WHERE id = ?";
            try (Connection connection = getConnection();
                 PreparedStatement statement = connection.prepareStatement(updateSql)) {
                statement.setString(1, note.getTitle());
                statement.setString(2, note.getContent());
                statement.setInt(3, note.getTypeId());
                statement.setInt(4, note.getId());
                int updated = statement.executeUpdate();
                if (updated == 0) {
                    throw new SQLException("Không tìm thấy ghi chú cần cập nhật (ID=" + note.getId() + ").");
                }
            }
            return;
        }

        String insertSql = "INSERT INTO notes (title, content, type_id) VALUES (?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, note.getTitle());
            statement.setString(2, note.getContent());
            statement.setInt(3, note.getTypeId());
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    note.setId(keys.getInt(1));
                }
            }
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM notes WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    @Override
    public List<Note> findAll() throws SQLException {
        String sql = "SELECT id, title, content, type_id FROM notes ORDER BY id DESC";
        List<Note> notes = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            while (result.next()) {
                notes.add(mapNote(result));
            }
        }
        return notes;
    }

    @Override
    public List<Note> search(String keyword) throws SQLException {
        String sql = "SELECT id, title, content, type_id FROM notes " +
                     "WHERE title LIKE ? OR content LIKE ? ORDER BY id DESC";
        String term = "%" + (keyword == null ? "" : keyword.trim()) + "%";
        List<Note> notes = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, term);
            statement.setString(2, term);
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    notes.add(mapNote(result));
                }
            }
        }
        return notes;
    }

    private Note mapNote(ResultSet result) throws SQLException {
        return new Note(result.getInt("id"), result.getString("title"),
                result.getString("content"), result.getInt("type_id"));
    }
}
