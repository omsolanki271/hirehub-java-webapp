# HireHub - Online Job Portal

## Project Overview

HireHub is a web-based Job Portal application developed using Java Servlet, JSP, JDBC, Maven, and MySQL.

The system allows administrators to manage job postings and users to search, view, and apply for jobs online.

---

## Features

### User Module

* User Registration
* User Login
* View Active Jobs
* Search Jobs
* View Job Details
* Apply for Jobs
* View Applied Jobs
* Update Profile
* Change Password
* Logout

### Admin Module

* Admin Login
* Admin Dashboard
* Add Job
* View Jobs
* Edit Job
* Delete Job
* Search Jobs
* View Job Details
* View Users
* Delete Users
* View Applications
* View Applicants
* Change Password
* Logout

---

## Technologies Used

* Java
* JSP
* Servlet
* JDBC
* Maven
* MySQL
* HTML
* CSS
* Bootstrap
* JSTL

---

## Database Tables

* admin
* users
* jobs
* apply_job

---

## Project Structure

```text
src/main/java
├── com.DB
├── com.dao
├── com.entity
└── com.servlet

src/main/webapp
├── admin
├── user
├── all_component
└── img
```

---

## Software Requirements

* Java 8+
* Apache Tomcat 9+
* Maven
* MySQL Server
* Eclipse IDE

---
## Setup Instructions

1. Clone the repository.

```bash
git clone https://github.com/your-username/hirehub-java-webapp.git
```

2. Create a MySQL database.

```sql
CREATE DATABASE hirehub;
```

3. Import required tables.

4. Update database credentials in:

```java
com.DB.DBConnect.java
```

5. Build the project using Maven.

```bash
mvn clean install
```

6. Deploy the generated WAR file on Apache Tomcat.

7. Start the server and open the application.

---

## Notes

* The project follows the MVC pattern using JSP, Servlet, JDBC, and MySQL.
* Some UI enhancements and design refinements were created with the assistance of AI-based development tools.
* Backend logic, database integration, feature implementation, and project integration were developed as part of the project.

---

## Author

Om Solanki

MCA Student | Java Backend Developer
