package com.codegym.service;

import com.codegym.model.Product;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

/**
 * In-memory implementation of ProductService using a static Map as a
 * lightweight stand-in for a database.
 */
public class ProductServiceImpl implements ProductService {

    private static final Map<Long, Product> PRODUCTS = new LinkedHashMap<>();
    private static final AtomicLong NEXT_ID = new AtomicLong(1);

    static {
        seed(new Product(0, "Wireless Mouse", new BigDecimal("19.99"),
                "Ergonomic wireless mouse with adjustable DPI.", "Logitech"));
        seed(new Product(0, "Mechanical Keyboard", new BigDecimal("79.50"),
                "Mechanical keyboard with tactile switches.", "Keychron"));
        seed(new Product(0, "USB-C Hub", new BigDecimal("34.90"),
                "Multiport hub with HDMI and USB ports.", "Anker"));
        seed(new Product(0, "27-inch Monitor", new BigDecimal("229.00"),
                "QHD monitor for home and office.", "Dell"));
        seed(new Product(0, "Laptop Stand", new BigDecimal("42.00"),
                "Aluminum adjustable laptop stand.", "UGREEN"));
    }

    private static void seed(Product product) {
        long id = NEXT_ID.getAndIncrement();
        product.setId(id);
        PRODUCTS.put(id, product);
    }

    @Override
    public List<Product> findAll() {
        synchronized (PRODUCTS) {
            return new ArrayList<>(PRODUCTS.values());
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        String normalizedKeyword = keyword == null
                ? ""
                : keyword.trim().toLowerCase(Locale.ROOT);

        synchronized (PRODUCTS) {
            if (normalizedKeyword.isEmpty()) {
                return new ArrayList<>(PRODUCTS.values());
            }

            List<Product> matches = new ArrayList<>();
            for (Product product : PRODUCTS.values()) {
                if (product.getName() != null
                        && product.getName().toLowerCase(Locale.ROOT).contains(normalizedKeyword)) {
                    matches.add(product);
                }
            }
            return matches;
        }
    }

    @Override
    public Product findById(long id) {
        synchronized (PRODUCTS) {
            return PRODUCTS.get(id);
        }
    }

    @Override
    public Product save(Product product) {
        synchronized (PRODUCTS) {
            long id = NEXT_ID.getAndIncrement();
            product.setId(id);
            PRODUCTS.put(id, product);
            return product;
        }
    }

    @Override
    public void update(long id, Product product) {
        synchronized (PRODUCTS) {
            if (PRODUCTS.containsKey(id)) {
                product.setId(id);
                PRODUCTS.put(id, product);
            }
        }
    }

    @Override
    public boolean remove(long id) {
        synchronized (PRODUCTS) {
            return PRODUCTS.remove(id) != null;
        }
    }
}
