# Product Management — Java Web MVC

A Maven WAR application using Java 17, Jakarta Servlet/JSP, JSTL, and an in-memory Map service.

## Project structure

```
source_89/
├── README.md
└── customer-management/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/Product.java
        │   ├── service/ProductService.java
        │   ├── service/ProductServiceImpl.java
        │   └── controller/ProductServlet.java
        └── webapp/
            ├── error-404.jsp
            ├── product/
            │   ├── list.jsp
            │   ├── create.jsp
            │   ├── edit.jsp
            │   ├── delete.jsp
            │   └── view.jsp
            └── WEB-INF/web.xml
```

## Features
- List products and search by name (case-insensitive substring matching).
- Create a product.
- Update a product.
- Delete a product after a confirmation page.
- View product details.
- Validate product name, manufacturer, price, and numeric input.
- Five sample products are loaded into a static in-memory Map on application class initialization.

## Requirements
- JDK 17+
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)
- JSTL 3.0 (Maven dependencies are included)

## Build
Open a terminal in the `customer-management` directory:

```bash
mvn clean package
```

The WAR file is created at `target/customer-management.war`.

## Deploy
Copy `target/customer-management.war` into Tomcat's `webapps` folder and start Tomcat. Open:

`http://localhost:8080/customer-management/`

The `/products` servlet is configured as the welcome resource. Data is held in memory, so changes are lost when the JVM restarts.
