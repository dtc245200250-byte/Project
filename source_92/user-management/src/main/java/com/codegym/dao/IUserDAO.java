package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/** Contract for JDBC persistence and stored procedure operations. */
public interface IUserDAO {
    void insertUser(User user) throws SQLException;
    User selectUser(int id) throws SQLException;
    List<User> selectUsers(String country, String sortDirection) throws SQLException;
    boolean deleteUser(int id) throws SQLException;
    boolean updateUser(User user) throws SQLException;

    /** Looks up a user by ID using the get_user_by_id stored procedure. */
    User getUserById(int id) throws SQLException;

    /** Inserts a user using the insert_user stored procedure. */
    void insertUserStore(User user) throws SQLException;
}
