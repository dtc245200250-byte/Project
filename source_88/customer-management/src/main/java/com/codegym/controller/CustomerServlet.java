package com.codegym.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * MVC controller scaffold for the customer management application.
 *
 * <p>This servlet is mapped to {@code /customers}. Request handling and
 * GET/POST flow are intentionally not implemented.</p>
 */
@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {
}
