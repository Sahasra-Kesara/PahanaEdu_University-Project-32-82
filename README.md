# Pahana Edu Billing System

[![Pahana Edu Banner](https://via.placeholder.com/1200x300?text=▶+Watch+Pahana+Edu+Demo)](https://res.cloudinary.com/dwf8ifbzs/video/upload/v1755611501/PahanaEdu_Demonstration_Video_oyqput.mp4)

**Pahana Edu** is a leading bookshop in Colombo City. This project is a **web-based billing and customer management system** designed to replace manual record-keeping with a secure, efficient, and user-friendly platform.

---

##  Features

- **User Authentication (Login)**
  - Secure login with username and password.
- **Add New Customer Accounts**
  - Store details: account number, name, address, telephone number, units consumed.
- ✏**Edit Customer Information**
  - Update existing customer records easily.
- **Manage Item Information**
  - Add, update, and delete items available in the bookshop.
- **Display Account Details**
  - Retrieve and display customer account information.
- **Calculate and Print Bill**
  - Compute bill based on units consumed and print receipts.
- **Help Section**
  - System usage guidelines for new users.
- **Exit System**
  - Graceful exit from the application.

*Additional functionalities can be easily added as needed.*

---

## Technology Stack

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-FF0000?style=for-the-badge&logo=apachetomcat&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)

- **Backend:** Java EE, JSP, Servlets  
- **Database:** MySQL  
- **Server:** Apache Tomcat 10.0.27  
- **Frontend:** HTML, CSS, Bootstrap (optional)  
- **Development Tools:** Eclipse/IntelliJ IDEA, MySQL Workbench  

---

## 🛠 Installation & Setup

### 1. Clone the repository

git clone https://github.com/YourUsername/PahanaEdu-BillingSystem.git

## 🛠 Installation & Setup

### 2. Setup MySQL Database
- Create a database named `pahana_edu`.
- Import the provided SQL scripts to create tables.

### 3. Configure Database Connection
- Update `DatabaseConnection.java` with your MySQL credentials.

### 4. Deploy on Tomcat
- Add the project to Tomcat `webapps`.
- Start the server at [http://localhost:8080/PahanaEdu-BillingSystem](http://localhost:8080/PahanaEdu-BillingSystem).


Create SQL database
-- Create the database
CREATE DATABASE pahanaedu;

-- Select the database to use
USE pahanaedu;

-- Create the tables
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

GRANT ALL PRIVILEGES ON pahanaedu.* TO 'root'@'localhost' IDENTIFIED BY 'Mathematics#123';
FLUSH PRIVILEGES;



CREATE USER 'pahanaeduuser'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON pahanaedu.* TO 'pahanaeduuser'@'localhost';
FLUSH PRIVILEGES;

### 5. Access the Application
- Login with default admin credentials or register new users.
