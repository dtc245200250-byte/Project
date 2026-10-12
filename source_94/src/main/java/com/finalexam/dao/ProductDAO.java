package com.finalexam.dao;

import com.finalexam.model.Product;
import com.finalexam.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> findAll() throws SQLException {
        String sql = "SELECT id, name, price, quantity FROM products ORDER BY id DESC";
        List<Product> products = new ArrayList<>();
        try (Connection c = DBConnection.getConnection(); PreparedStatement s = c.prepareStatement(sql); ResultSet r = s.executeQuery()) {
            while (r.next()) products.add(new Product(r.getInt("id"), r.getString("name"), r.getBigDecimal("price"), r.getInt("quantity")));
        }
        return products;
    }
    public Product findById(int id) throws SQLException {
        String sql = "SELECT id, name, price, quantity FROM products WHERE id = ?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement s = c.prepareStatement(sql)) {
            s.setInt(1, id);
            try (ResultSet r = s.executeQuery()) {
                if (r.next()) return new Product(r.getInt("id"), r.getString("name"), r.getBigDecimal("price"), r.getInt("quantity"));
            }
        }
        return null;
    }
    public void insert(Product p) throws SQLException {
        String sql = "INSERT INTO products (name, price, quantity) VALUES (?, ?, ?)";
        try (Connection c = DBConnection.getConnection(); PreparedStatement s = c.prepareStatement(sql)) {
            s.setString(1, p.getName()); s.setBigDecimal(2, p.getPrice()); s.setInt(3, p.getQuantity()); s.executeUpdate();
        }
    }
    public boolean update(Product p) throws SQLException {
        String sql = "UPDATE products SET name = ?, price = ?, quantity = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement s = c.prepareStatement(sql)) {
            s.setString(1, p.getName()); s.setBigDecimal(2, p.getPrice()); s.setInt(3, p.getQuantity()); s.setInt(4, p.getId());
            return s.executeUpdate() > 0;
        }
    }
    public boolean delete(int id) throws SQLException {
        try (Connection c = DBConnection.getConnection(); PreparedStatement s = c.prepareStatement("DELETE FROM products WHERE id = ?")) {
            s.setInt(1, id); return s.executeUpdate() > 0;
        }
    }
}