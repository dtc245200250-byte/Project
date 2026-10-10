package com.codegym.service;

import com.codegym.model.Customer;
import java.util.List;

/**
 * Service contract for customer management operations.
 *
 * <p>Method signatures only. Implementations are intentionally omitted
 * as required by the assignment.</p>
 */
public interface CustomerService {

    /** Declares the operation that will return all customers. */
    List<Customer> findAll();

    /** Declares the operation that will save a customer. */
    void save(Customer customer);

    /** Declares the operation that will find a customer by ID. */
    Customer findById(int id);

    /** Declares the operation that will update a customer's details. */
    void update(int id, Customer customer);

    /** Declares the operation that will remove a customer by ID. */
    void remove(int id);
}
