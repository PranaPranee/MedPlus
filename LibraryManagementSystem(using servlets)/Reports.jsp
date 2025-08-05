<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.library.controller.ReportsServlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.library.service.ReportService.OverdueBook" %>
<%@ page import="com.library.service.ReportService.CategoryCount" %>
<%@ page import="com.library.service.ReportService.ActiveMember" %>


<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: lavender;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        .btn-container {
            text-align: center;
            margin: 20px;
        }
        .btn-container form {
            display: inline-block;
            margin: 0 10px;
        }
        .btn-container button {
            background-color:  #A5A391;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-container button:hover {
            background-color:  #A5A391;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 30px auto;
            background-color: white;
            box-shadow: 0 0 10px #ccc;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #e6e6e6;
        }
        p {
            text-align: center;
            font-size: 16px;
            color: #555;
        }
    </style>
</head>
<body>

    <h2>Library Reports</h2>

    <div class="btn-container">
        <form action="ReportsServlet" method="get">
            <input type="hidden" name="action" value="overdueBooks" />
            <button type="submit">Overdue Books</button>
        </form>
        <form action="ReportsServlet" method="get">
            <input type="hidden" name="action" value="categoryCounts" />
            <button type="submit">Books Per Category</button>
        </form>
        <form action="ReportsServlet" method="get">
            <input type="hidden" name="action" value="activeMembers" />
            <button type="submit">Active Members</button>
        </form>
    </div>

    <%
        String action = (String) request.getAttribute("action");

        if (action == null) {
    %>
        <p>No report type selected.</p>
    <%
        } else if ("overdueBooks".equals(action)) {
            List<OverdueBook> overdueBooks = (List<OverdueBook>) request.getAttribute("overdueBooks");
            if (overdueBooks != null && !overdueBooks.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    %>
        <table>
            <tr>
                <th>Book Title</th>
                <th>Member Name</th>
                <th>Issue Date</th>
            </tr>
            <%
                for (OverdueBook ob : overdueBooks) {
            %>
            <tr>
                <td><%= ob.getTitle() %></td>
                <td><%= ob.getMemberName() %></td>
                <td><%= ob.getIssueDate().format(formatter) %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
            } else {
    %>
        <p>No overdue books found.</p>
    <%
            }

        } else if ("categoryCounts".equals(action)) {
            List<CategoryCount> categoryCounts = (List<CategoryCount>) request.getAttribute("categoryCounts");
            if (categoryCounts != null && !categoryCounts.isEmpty()) {
    %>
        <table>
            <tr>
                <th>Category</th>
                <th>Count</th>
            </tr>
            <%
                for (CategoryCount cc : categoryCounts) {
            %>
            <tr>
                <td><%= cc.getCategory() %></td>
                <td><%= cc.getCount() %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
            } else {
    %>
        <p>No book category data found.</p>
    <%
            }

        } else if ("activeMembers".equals(action)) {
            List<ActiveMember> activeMembers = (List<ActiveMember>) request.getAttribute("activeMembers");
            if (activeMembers != null && !activeMembers.isEmpty()) {
    %>
        <table>
            <tr>
                <th>Member Name</th>
                <th>Books Issued</th>
            </tr>
            <%
                for (ActiveMember am : activeMembers) {
            %>
            <tr>
                <td><%= am.getName() %></td>
                <td><%= am.getBooksIssued() %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
            } else {
    %>
        <p>No active members found.</p>
    <%
            }

        } else {
    %>
        <p>Invalid report type.</p>
    <%
        }
    %>

</body>
</html>
