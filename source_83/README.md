# Product Discount Calculator

## Project structure

```
source_83/
├── README.md
└── product-discount-calculator/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/DiscountServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Requirements
- JDK 17 or later
- Maven
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Build the WAR
Open a terminal in the `product-discount-calculator` directory and run:

```bash
mvn clean package
```

The packaged application is generated at `target/product-discount-calculator.war`.

## Deploy
Copy the WAR file to Tomcat's `webapps` directory and start Tomcat. Open:

`http://localhost:8080/product-discount-calculator/`

## Calculation
The form submits these values using POST to `/display-discount`:
- Product Description
- List Price
- Discount Percent

The servlet calculates:

```
Discount Amount = List Price * Discount Percent * 0.01
Discount Price = List Price - Discount Amount
```

For example, List Price = 200 and Discount Percent = 15 gives Discount Amount = 30.00 and Discount Price = 170.00. Numeric inputs are validated, and monetary results are rounded to two decimal places.
