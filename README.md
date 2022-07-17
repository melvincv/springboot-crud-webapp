# Spring Boot Web App Deployment

## Build on AWS EC2

[How to Build](https://github.com/melvincv/springboot-crud-webapp/blob/master/notes/Build%20Instructions.pdf)

## Deploy on Docker

1. Create a file called .env from the given copy and fill in the variable values.
2. Check the Dockerfile and compose.yml file.
3. Run this to build the image and bring up the services (containers):

```
    docker compose up -d --build
```

4. Once you are done, run this to bring it down:

```
    docker compose down
```

# References

Spring Boot CRUD Web application with Pagination and Sorting features using Spring Boot, ThymeLeaf, Spring Data JPA, Hibernate, MySQL database

### Tutorial - Spring Boot CRUD Web Application with Thymeleaf, Spring MVC, Spring Data JPA, Hibernate, MySQL
https://www.javaguides.net/2020/05/spring-boot-crud-web-application-with-thymeleaf.html

### YouTube Video - Spring Boot CRUD Web Application with Thymeleaf, Spring MVC, Spring Data JPA, Hibernate, MySQL
https://youtu.be/_5sAmaRJd2c

### Tutorial - Pagination and Sorting with Spring Boot, ThymeLeaf, Spring Data JPA, Hibernate, MySQL
https://www.javaguides.net/2020/06/pagination-and-sorting-with-spring-boot-thymeleaf-spring-data-jpa-hibernate-mysql.html

### YouTube Video  - Pagination and Sorting with Spring Boot, ThymeLeaf, Spring Data JPA, Hibernate, MySQL
=> https://youtu.be/Aie8n12EFQc
