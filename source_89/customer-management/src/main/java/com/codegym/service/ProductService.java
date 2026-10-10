package com.codegym.service;

import com.codegym.model.Product;
import java.util.List;

/**
 * Defines product management operations used by the MVC controller.
 */
public interface ProductService {

    /** Returns all products in the catalog. */
    List<Product> findAll();

    /** Finds products whose names contain the supplied keyword. */
    List<Product> searchByName(String keyword);

    /** Returns the product with the given ID, or null when absent. */
    Product findById(long id);

    /** Adds a product and returns it with its assigned ID. */
    Product save(Product product);

    /** Replaces an existing product with the supplied details. */
    void update(long id, Product product);

    /** Removes a product and reports whether it existed. */
    boolean remove(long id);
}
