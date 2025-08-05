package com.library.dao;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.library.model.IssueRecords;
import com.library.util.DatabaseConnection;

public class IssueRecordDAOImplementation implements IssueRecordDAO {

    @Override
    public boolean issueBook(IssueRecords record) {
        String insertIssue = "INSERT INTO issue_records (BookId, MemberId, Status, IssueDate) VALUES (?, ?, 'I', ?)";
        String insertLog = "INSERT INTO issue_records_log (IssueId, BookId, MemberId, Status, IssueDate, ReturnDate) VALUES (?, ?, ?, ?, ?, NULL)";
        String updateAvailability = "UPDATE books SET Availability='I' WHERE BookId=?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            IssueRecords active = getActiveIssueByBookId(record.getBookId());
            if (active != null) {
                throw new SQLException("Book is already issued.");
            }

            int issueId;
            // Insert new issue
            try (PreparedStatement pstmt = conn.prepareStatement(insertIssue, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, record.getBookId());
                pstmt.setInt(2, record.getMemberId());
                pstmt.setDate(3, Date.valueOf(record.getIssueDate()));
                pstmt.executeUpdate();

                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        issueId = rs.getInt(1);
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            // Insert log
            try (PreparedStatement logStmt = conn.prepareStatement(insertLog)) {
                logStmt.setInt(1, issueId);
                logStmt.setInt(2, record.getBookId());
                logStmt.setInt(3, record.getMemberId());
                logStmt.setString(4, "I");
                logStmt.setDate(5, Date.valueOf(record.getIssueDate()));
                logStmt.executeUpdate();
            }

            // Update availability
            try (PreparedStatement availStmt = conn.prepareStatement(updateAvailability)) {
                availStmt.setInt(1, record.getBookId());
                availStmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean returnBook(int issueId) {
        String updateIssue = "UPDATE issue_records SET Status='R', ReturnDate=? WHERE IssueId=?";
        String insertLog = "INSERT INTO issue_records_log (IssueId, BookId, MemberId, Status, IssueDate, ReturnDate) " +
                           "SELECT IssueId, BookId, MemberId, 'R', IssueDate, ? FROM issue_records WHERE IssueId=?";
        String updateAvailability = "UPDATE books SET Availability='A' WHERE BookId = (SELECT BookId FROM issue_records WHERE IssueId=?)";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            LocalDate today = LocalDate.now();

            // Update main record
            try (PreparedStatement updateStmt = conn.prepareStatement(updateIssue)) {
                updateStmt.setDate(1, Date.valueOf(today));
                updateStmt.setInt(2, issueId);

                if (updateStmt.executeUpdate() != 1) {
                    conn.rollback();
                    return false;
                }
            }

            // Insert log
            try (PreparedStatement logStmt = conn.prepareStatement(insertLog)) {
                logStmt.setDate(1, Date.valueOf(today));
                logStmt.setInt(2, issueId);
                logStmt.executeUpdate();
            }

            // Update book availability
            try (PreparedStatement availStmt = conn.prepareStatement(updateAvailability)) {
                availStmt.setInt(1, issueId);
                availStmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public IssueRecords getActiveIssueByBookId(int bookId) {
        String query = "SELECT * FROM issue_records WHERE BookId=? AND Status='I'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new IssueRecords(
                        rs.getInt("IssueId"),
                        rs.getInt("BookId"),
                        rs.getInt("MemberId"),
                        rs.getString("Status"),
                        rs.getDate("IssueDate").toLocalDate(),
                        rs.getDate("ReturnDate") != null ? rs.getDate("ReturnDate").toLocalDate() : null
                    );
                }
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<IssueRecords> getAllIssues() {
        List<IssueRecords> issues = new ArrayList<>();
        String sql = "SELECT * FROM issue_records";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                issues.add(new IssueRecords(
                    rs.getInt("IssueId"),
                    rs.getInt("BookId"),
                    rs.getInt("MemberId"),
                    rs.getString("Status"),
                    rs.getDate("IssueDate").toLocalDate(),
                    rs.getDate("ReturnDate") != null ? rs.getDate("ReturnDate").toLocalDate() : null
                ));
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return issues;
    }

    @Override
    public List<Integer> getAvailableBookIds() {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT BookId FROM books WHERE Availability='A' AND Status='A'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getInt("BookId"));
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Integer> getValidMemberIds() {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT MemberId FROM member";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getInt("MemberId"));
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return list;
    }
}
