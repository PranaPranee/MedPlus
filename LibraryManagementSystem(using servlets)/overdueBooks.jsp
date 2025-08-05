<%@ page import="java.util.List" %>
<%@ page import="com.library.controller.OverdueBooksServlet.OverdueBook" %>

<!DOCTYPE html>
<html>
<head>
    <title>Overdue Books Report</title>
</head>
<body>
    <h1>Overdue Books</h1>

    <%
        List<OverdueBook> overdueBooks = (List<OverdueBook>) request.getAttribute("overdueBooks");
    %>

    <table border="1">
        <tr>
            <th>Title</th>
            <th>Member</th>
            <th>Issue Date</th>
        </tr>
        <% for (OverdueBook book : overdueBooks) { %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getMemberName() %></td>
            <td><%= book.getIssueDate() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
