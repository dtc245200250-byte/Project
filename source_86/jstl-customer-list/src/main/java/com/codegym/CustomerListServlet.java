package com.codegym;

import java.io.IOException;
import java.util.List;

import com.codegym.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CustomerListServlet", urlPatterns = "/customers")
public class CustomerListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers = List.of(
                new Customer("Nguyễn Văn An", "12/03/1998", "Hà Nội, Việt Nam", "/images/customer-1.svg"),
                new Customer("Trần Thị Mai", "25/07/1996", "Đà Nẵng, Việt Nam", "/images/customer-2.svg"),
                new Customer("Lê Hoàng Nam", "09/11/2000", "TP. Hồ Chí Minh, Việt Nam", "/images/customer-3.svg"),
                new Customer("Phạm Thu Hà", "18/01/1995", "Hải Phòng, Việt Nam", "/images/customer-4.svg"),
                new Customer("Đỗ Minh Khang", "04/05/1999", "Cần Thơ, Việt Nam", "/images/customer-5.svg")
        );

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
