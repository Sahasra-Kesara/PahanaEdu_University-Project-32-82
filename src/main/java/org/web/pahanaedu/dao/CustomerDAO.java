package org.web.pahanaedu.dao;

import org.web.pahanaedu.model.Customer;
import org.web.pahanaedu.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public static boolean addCustomer(Customer customer) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO customers (account_no, name, address, phone, units) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer.getAccountNo());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getPhone());
            stmt.setInt(5, customer.getUnits());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateCustomer(Customer customer) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE customers SET name=?, address=?, phone=?, units=? WHERE account_no=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhone());
            stmt.setInt(4, customer.getUnits());
            stmt.setString(5, customer.getAccountNo());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Customer getCustomerByAccountNo(String accountNo) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM customers WHERE account_no=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setAccountNo(rs.getString("account_no"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                c.setPhone(rs.getString("phone"));
                c.setUnits(rs.getInt("units"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM customers";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setAccountNo(rs.getString("account_no"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                c.setPhone(rs.getString("phone"));
                c.setUnits(rs.getInt("units"));
                customers.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public static boolean deleteCustomer(String accountNo) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false); // start transaction

            try {
                // 1. Delete billing records for this customer
                String deleteBilling = "DELETE FROM billing WHERE account_no = ?";
                try (PreparedStatement stmtBilling = conn.prepareStatement(deleteBilling)) {
                    stmtBilling.setString(1, accountNo);
                    stmtBilling.executeUpdate();
                }

                // 2. Delete customer
                String deleteCustomer = "DELETE FROM customers WHERE account_no = ?";
                try (PreparedStatement stmtCustomer = conn.prepareStatement(deleteCustomer)) {
                    stmtCustomer.setString(1, accountNo);
                    int rows = stmtCustomer.executeUpdate();
                    conn.commit();
                    return rows > 0;
                }
            } catch (SQLException ex) {
                conn.rollback(); // rollback on error
                ex.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
