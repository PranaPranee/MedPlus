package com.library.controller;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import com.library.dao.BookDAOImplementation;
import com.library.model.IssueRecords;
import com.library.model.Member;
import com.library.service.IssueRecordServiceImplementation;
import com.library.service.MemberServiceImplementation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ActiveMembersServlet")
public class ActiveMembersServlet extends HttpServlet {

    private final IssueRecordServiceImplementation issueService = new IssueRecordServiceImplementation();
    private final MemberServiceImplementation memberService = new MemberServiceImplementation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<IssueRecords> allIssues = issueService.getAllIssues();

            Map<Integer, Long> memberIssueCount = allIssues.stream()
                .filter(issue -> issue.getReturnDate() == null)
                .collect(Collectors.groupingBy(IssueRecords::getMemberId, Collectors.counting()));

            List<ActiveMember> activeMembers = new ArrayList<>();
            for (Map.Entry<Integer, Long> entry : memberIssueCount.entrySet()) {
                Member member = memberService.fetchMemberById(entry.getKey());
                activeMembers.add(new ActiveMember(member.getName(), entry.getValue().intValue()));
            }

            request.setAttribute("activeMembers", activeMembers);
            request.getRequestDispatcher("/activeMembers.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Main.html");
        }
    }

    public static class ActiveMember {
        private final String name;
        private final int booksIssued;

        public ActiveMember(String name, int booksIssued) {
            this.name = name;
            this.booksIssued = booksIssued;
        }

        public String getName() { return name; }
        public int getBooksIssued() { return booksIssued; }
    }
}
