package com.codegym.model;

/**
 * Model scaffold representing a row in the {@code users} table.
 *
 * <p>The model contains the fields specified by the assignment.
 * Complete constructors and accessor methods as part of the exercise.</p>
 */
public class User {
    private int id;
    private String name;
    private String email;
    private String country;

    /** Creates an empty user model. */
    public User() {
        // TODO: Complete model initialization as an exercise.
    }

    /** Creates a user model without an assigned database ID. */
    public User(String name, String email, String country) {
        // TODO: Assign the supplied values to the model fields.
    }

    /** Creates a user model with all database fields. */
    public User(int id, String name, String email, String country) {
        // TODO: Assign the supplied values to the model fields.
    }

    /** TODO: Add getters and setters for the model fields. */
}
