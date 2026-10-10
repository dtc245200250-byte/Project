package com.codegym.dao;

import com.codegym.model.User;
import java.util.List;

/**
 * JDBC DAO scaffold for the {@code demo.users} table.
 *
 * <p>Add the JDBC URL, database username/password, connection management,
 * PreparedStatement queries, and ResultSet mapping as part of the exercise.
 * No SQL execution or CRUD logic is included yet.</p>
 */
public class UserDAO implements IUserDAO {

    /** TODO: Implement the INSERT statement with a PreparedStatement. */
    @Override
    public void insertUser(User user) throws Exception {
        // TODO: Implement JDBC insert.
    }

    /** TODO: Implement SELECT by primary key. */
    @Override
    public User selectUser(int id) {
        // TODO: Implement JDBC lookup.
        return null;
    }

    /** TODO: Implement SELECT for all rows. */
    @Override
    public List<User> selectAllUsers() {
        // TODO: Implement JDBC list query.
        return null;
    }

    /** TODO: Implement DELETE by primary key. */
    @Override
    public boolean deleteUser(int id) throws Exception {
        // TODO: Implement JDBC delete.
        return false;
    }

    /** TODO: Implement UPDATE by primary key. */
    @Override
    public boolean updateUser(User user) throws Exception {
        // TODO: Implement JDBC update.
        return false;
    }
}
