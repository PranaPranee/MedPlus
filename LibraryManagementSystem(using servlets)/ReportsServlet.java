package com.library.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.library.service.ReportService;
import com.library.service.ReportServiceImpl;

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {

    private ReportService reportService;

    @Override
    public void init() throws ServletException {
        reportService = new ReportServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            request.setAttribute("action", null);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Reports.jsp");
            dispatcher.forward(request, response);
            return;
        }

        switch (action) {
            case "overdueBooks":
                List<ReportService.OverdueBook> overdueBooks = reportService.getOverdueBooks();
                request.setAttribute("overdueBooks", overdueBooks);
                request.setAttribute("action", "overdueBooks");
                break;

            case "categoryCounts":
                List<ReportService.CategoryCount> categoryCounts = reportService.getBooksPerCategory();
                request.setAttribute("categoryCounts", categoryCounts);
                request.setAttribute("action", "categoryCounts");
                break;

            case "activeMembers":
                List<ReportService.ActiveMember> activeMembers = reportService.getActiveMembers();
                request.setAttribute("activeMembers", activeMembers);
                request.setAttribute("action", "activeMembers");
                break;

            default:
                request.setAttribute("action", null);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("Reports.jsp");
        dispatcher.forward(request, response);
    }
}
