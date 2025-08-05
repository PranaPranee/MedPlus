<%@ page import="java.util.List" %>
<%@ page import="com.library.controller.ActiveMembersServlet.ActiveMember" %>

<!DOCTYPE html>
<html>
<head>
    <title>Active Members</title>
</head>
<body>
    <h1>Active Members</h1>

    <%
        List<ActiveMember> activeMembers = (List<ActiveMember>) request.getAttribute("activeMembers");
    %>

    <table border="1">
        <tr>
            <th>Member Name</th>
            <th>Books Issued</th>
        </tr>
        <% for (ActiveMember m : activeMembers) { %>
        <tr>
            <td><%= m.getName() %></td>
            <td><%= m.getBooksIssued() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
