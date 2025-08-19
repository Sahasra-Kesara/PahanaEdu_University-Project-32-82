# Pahana Edu Billing System



https://github.com/user-attachments/assets/0a1e3574-da93-4a52-84db-91bdf298f9ec



**Demonstration Video:** [Watch Demo Video](https://drive.google.com/file/d/1UhDcKnImDZrpr0Ql2J2iwh3GAJS42K1a/view?usp=drive_link)

---

## 1. Introduction

**Pahana Edu** is a leading bookshop in Colombo City, serving hundreds of customers monthly. Traditionally, customer account details and billing operations were maintained manually, which posed challenges in accuracy, efficiency, and scalability.  

This project introduces a **web-based billing and customer management system** that leverages modern software technologies to streamline operations, enhance data security, and improve customer service delivery. The system provides structured management of customer accounts, billing, and inventory, ensuring transparency and efficiency in day-to-day business activities.

---

## 2. Objectives

- To design and implement a **secure, scalable, and user-friendly** billing system.  
- To automate **customer account management** and **bill generation**.  
- To provide administrative functionalities for managing items and users.  
- To reduce errors associated with manual record-keeping.  
- To create a platform that can be further extended with additional features.  

---

## 3. Key Features

- **User Authentication**
  - Secure login with username and password for administrators and staff.  
- **Customer Management**
  - Add, edit, and update customer details (account number, name, address, telephone number, units consumed).  
- **Item Management**
  - Add, update, and delete items available in the bookshop inventory.  
- **Account Information Display**
  - Retrieve and present customer account details for verification and billing.  
- **Billing System**
  - Automatic computation of charges based on consumption or item purchase.  
  - Printing of bills/receipts for customers.  
- **System Help**
  - Documentation and usage guidelines for new users.  
- **System Exit**
  - Secure logout and session termination.  

---

## 4. Technology Stack

- **Backend:** Java EE (Servlets, JSP)  
- **Database:** MySQL  
- **Server:** Apache Tomcat 10.0.27  
- **Frontend:** HTML, CSS, Bootstrap  
- **Development Tools:** IntelliJ IDEA / Eclipse, MySQL Workbench  

---

## 5. Installation & Setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/YourUsername/PahanaEdu-BillingSystem.git
```

### Step 2: Database Setup

Run the following SQL script in MySQL Workbench:


-- Create the database
CREATE DATABASE pahanaedu;

USE pahanaedu;

-- Create tables
CREATE TABLE admin (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50),
    role VARCHAR(20)
);

CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_no VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    units INT
);

CREATE TABLE billing (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_no VARCHAR(20),
    units INT,
    total DECIMAL(10,2),
    billing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_no) REFERENCES customers(account_no)
);

CREATE TABLE item (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT DEFAULT 0
);

-- Database User Privileges
GRANT ALL PRIVILEGES ON pahanaedu.* TO 'root'@'localhost' IDENTIFIED BY 'Mathematics#123';
FLUSH PRIVILEGES;

CREATE USER 'pahanaeduuser'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON pahanaedu.* TO 'pahanaeduuser'@'localhost';
FLUSH PRIVILEGES;

### Step 3: Configure Database Connection

- Open `DatabaseConnection.java`.  
- Update the MySQL username and password according to your local setup.

---

### Step 4: Deploy on Tomcat

1. Copy the project into `Tomcat/webapps/`.  
2. Start the Tomcat server.  
3. Access the system at:  
   [http://localhost:8080/PahanaEDU_war_exploded/login.jsp](http://localhost:8080/PahanaEDU_war_exploded/login.jsp)

---

### Step 5: Access the Application

- Use default admin credentials (configured in the SQL script) or register new users.

---

### 6. Academic Relevance

This project demonstrates the application of **Advanced Programming concepts**, including:

- Web application development using **Java EE (JSP/Servlets)**  
- Secure **database integration with MySQL**  
- Deployment and configuration of **enterprise web applications** on Apache Tomcat  
- Application of **version control (Git/GitHub)** for collaborative software engineering  
- Practical understanding of **MVC design patterns** and modular system architecture  

The project aligns with real-world **enterprise system development** practices and provides a foundation for future academic and industrial extensions.

---

### 7. Version Control & Workflow

The system development followed a structured **Git-based workflow** to ensure proper version management:

- **Main Branch:** Stable production-ready code  
- **Feature Branches:** Separate branches for new features such as `feature/role-management` and `feature/two-columns-view`  
- **Commit History:** Daily commits documenting progressive changes, bug fixes, and feature implementations  
- **Merging Strategy:** Feature branches merged into `main` after peer review and successful testing  

This approach highlights **best practices in collaborative development** and ensures that the system remains maintainable and extensible.

---

### 8. Conclusion

The **Pahana Edu Billing System** successfully addresses the limitations of manual record-keeping by introducing a computerized solution that is efficient, reliable, and extensible.  

Through this project, significant improvements in **data management**, **billing automation**, and **system usability** were achieved.  

This work illustrates the integration of **software engineering principles** with **real-world business requirements**, providing a strong academic and practical contribution to the field of **Advanced Programming**.
