# Customer Management — MVC Skeleton

This folder contains the requested **configuration-complete, code-skeleton-only** project. Java and JSP files intentionally do not contain business logic or complete HTML/JSTL interfaces.

## Project layout

```
source_88/
├── README.md
└── customer-management/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/Customer.java
        │   ├── service/CustomerService.java
        │   ├── service/CustomerServiceImpl.java
        │   └── controller/CustomerServlet.java
        └── webapp/
            ├── error-404.jsp
            ├── customer/
            │   ├── list.jsp
            │   ├── create.jsp
            │   ├── edit.jsp
            │   ├── delete.jsp
            │   └── view.jsp
            └── WEB-INF/web.xml
```

## Configuration
- Maven coordinates: `com.codegym:customer-management:1.0-SNAPSHOT`
- Packaging: WAR
- Java: 17
- Target server: Tomcat 10.1+ (Jakarta Servlet 6)
- Includes Jakarta Servlet, JSP and JSTL API/implementation dependencies.
- `web.xml` specifies the welcome resource and maps HTTP 404 errors to `error-404.jsp`.

## Build
Open a terminal in the `customer-management` directory and run:

```bash
mvn clean package
```

The WAR output path is `target/customer-management.war`.

## Assignment scope
The four Java files contain only class/interface declarations, fields or service method signatures with Javadoc. The five customer JSP views and `error-404.jsp` are comment-only placeholders. Customer CRUD logic, request dispatching and complete HTML/JSTL interfaces have intentionally not been implemented, per the explicit requirements.
