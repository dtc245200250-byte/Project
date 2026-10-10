# User Management — JDBC / MVC Skeleton

This assignment folder contains the requested Maven configuration and Java/JSP scaffolds. It intentionally does **not** implement CRUD, servlet request flow, JDBC SQL execution, or complete JSP interfaces, so you can practise those parts yourself.

## Structure

```
source_90/
├── README.md
└── user-management/
    ├── pom.xml
    ├── database.sql
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/User.java
        │   ├── dao/IUserDAO.java
        │   ├── dao/UserDAO.java
        │   └── controller/UserServlet.java
        └── webapp/
            ├── WEB-INF/web.xml
            └── user/
                ├── list.jsp
                ├── create.jsp
                ├── edit.jsp
                └── delete.jsp
```

## Prerequisites
- JDK 17+
- Maven
- MySQL 8.x
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Database setup
Open MySQL Workbench, DBeaver, or the MySQL CLI and execute `database.sql`. It creates the `demo` database and `users` table, then adds the two sample users if those email addresses are not already present.

## Maven configuration
The `pom.xml` contains dependencies for Jakarta Servlet 6, JSP 3.1, JSTL 3.0 and MySQL Connector/J 8.3.0. The `web.xml` is configured for Jakarta EE 10 web applications and uses `/users` as the welcome resource.

## Build
From the `user-management` directory, run:

```bash
mvn clean package
```

The WAR output path is `target/user-management.war`.

## Scaffold-only requirement
The model, DAO, controller and four JSP views contain only class/interface declarations, method signatures, Javadocs and TODO placeholders. Add the JDBC connection settings and implement CRUD, servlet action routing and JSP/JSTL interfaces yourself, as requested by the lesson.
