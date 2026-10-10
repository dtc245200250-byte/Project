# JSP Servlet Demo

A minimal Maven WAR application for **Java 17+** and **Apache Tomcat 10.1+**. It uses Jakarta Servlet 6.0 and JSP 3.1 APIs.

## Project structure

```text
jsp-servlet-demo/
├── pom.xml
└── src/
    └── main/
        ├── java/com/codegym/HelloServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml
```

## Build the WAR

Run from this directory:

```bash
mvn clean package
```

When Maven reports `BUILD SUCCESS`, the deployable archive is:

`target/jsp-servlet-demo.war`

## Deploy to Tomcat

Copy `target/jsp-servlet-demo.war` into Tomcat's `webapps` directory, then start or restart Tomcat. The default context path is the WAR name.

- Homepage: `http://localhost:8080/jsp-servlet-demo/`
- Servlet test: `http://localhost:8080/jsp-servlet-demo/hello`

The homepage shows the server time at the time of the request; refresh the page to update it. Tomcat must be running, and Maven and a compatible JDK must be installed locally.
