package com.codegym.dao;

import com.codegym.model.User;
import java.util.List;

/**
 * Declares the JDBC data-access operations for users.
 *
 * <p>Only method signatures are supplied; implement the CRUD statements
 * using JDBC as part of the assignment.</p>
 */
public interface IUserDAO {

    /** Declares inserting one user. */
    void insertUser(User user) throws Exception;

    /** Declares finding one user by ID. */
    User selectUser(int id);

    /** Declares retrieving all users. */
    List<User> selectAllUsers();

    /** Declares deleting a user by ID. */
    boolean deleteUser(int id) throws Exception;

    /** Declares updating a user's data. */
    boolean updateUser(User user) throws Exception;
}
