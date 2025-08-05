package com.library.service;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.library.service.ReportService.ActiveMember;
import com.library.service.ReportService.CategoryCount;
import com.library.service.ReportService.OverdueBook;
import com.library.util.DatabaseConnection;

public class ReportServiceImpl implements ReportService {

    @Override
    public List<OverdueBook> getOverdueBooks() {
        List<OverdueBook> overdueBooks = new ArrayList<>();

        String query = "SELECT b.Title, m.Name, ir.IssueDate " +
                       "FROM issue_records ir " +
                       "JOIN books b ON ir.BookId = b.BookId " +
                       "JOIN members m ON ir.MemberId = m.MemberId " +
                       "WHERE ir.Status = 'I' AND ir.IssueDate < ?";

        LocalDate today = LocalDate.now();
        LocalDate overdueDate = today.minusDays(14); // 14-day limit

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setDate(1, Date.valueOf(overdueDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String title = rs.getString("Title");
                String memberName = rs.getString("Name");
                LocalDate issueDate = rs.getDate("IssueDate").toLocalDate();

                overdueBooks.add(new OverdueBook(title, memberName, issueDate));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return overdueBooks;
    }

    @Override
    public List<CategoryCount> getBooksPerCategory() {
        List<CategoryCount> counts = new ArrayList<>();

        String query = "SELECT Category, COUNT(BookId) AS Count FROM books GROUP BY Category";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String category = rs.getString("Category");
                int count = rs.getInt("Count");
                counts.add(new CategoryCount(category, count));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return counts;
    }


    @Override
    public List<ActiveMember> getActiveMembers() {
        List<ActiveMember> members = new ArrayList<>();

        String query = "SELECT m.Name, COUNT(*) AS BooksIssued " +
                       "FROM issue_records ir " +
                       "JOIN members m ON ir.MemberId = m.MemberId " +
                       "GROUP BY m.Name " +
                       "ORDER BY BooksIssued DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("Name");
                int count = rs.getInt("BooksIssued");

                members.add(new ActiveMember(name, count));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return members;
    }
}
