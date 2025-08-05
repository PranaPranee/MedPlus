package com.library.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

import com.library.dao.BookDAOImplementation;
import com.library.model.Book;
import com.library.model.IssueRecords;
import com.library.model.Member;
import com.library.service.BookServiceImplementation;
import com.library.service.IssueRecordServiceImplementation;
import com.library.service.MemberServiceImplementation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OverdueBooksServlet")
public class OverdueBooksServlet extends HttpServlet {

    private final IssueRecordServiceImplementation issueService = new IssueRecordServiceImplementation();
    private final BookServiceImplementation bookService = new BookServiceImplementation(new BookDAOImplementation());
    private final MemberServiceImplementation memberService = new MemberServiceImplementation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<IssueRecords> allIssues = issueService.getAllIssues();
            List<IssueRecords> overdue = allIssues.stream()
                .filter(issue -> issue.getReturnDate() == null)
                .filter(issue -> issue.getIssueDate().isBefore(LocalDate.now().minusDays(1)))
                .collect(Collectors.toList());

            List<OverdueBook> overdueBooks = new ArrayList<>();
            for (IssueRecords issue : overdue) {
                Book book = bookService.getBookById(issue.getBookId());
                Member member = memberService.fetchMemberById(issue.getMemberId());
                overdueBooks.add(new OverdueBook(book.getTitle(), member.getName(), issue.getIssueDate()));
            }

            request.setAttribute("overdueBooks", overdueBooks);
            request.getRequestDispatcher("/overdueBooks.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Main.html");
        }
    }

    public static class OverdueBook {
        private final String title;
        private final String memberName;
        private final LocalDate issueDate;

        public OverdueBook(String title, String memberName, LocalDate issueDate) {
            this.title = title;
            this.memberName = memberName;
            this.issueDate = issueDate;
        }

        public String getTitle() { return title; }
        public String getMemberName() { return memberName; }
        public LocalDate getIssueDate() { return issueDate; }
    }
}
