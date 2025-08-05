<%@ page import="java.util.List" %>
<%@ page import="com.library.controller.CategoryCountServlet.CategoryCount" %>

<!DOCTYPE html>
<html>
<head>
    <title>Books Per Category</title>
</head>
<body>
    <h1>Books Per Category</h1>

    <%
        List<CategoryCount> categoryCounts = (List<CategoryCount>) request.getAttribute("categoryCounts");
    %>

    <table border="1">
        <tr>
            <th>Category</th>
            <th>Count</th>
        </tr>
        <% for (CategoryCount cc : categoryCounts) { %>
        <tr>
            <td><%= cc.getCategory() %></td>
            <td><%= cc.getCount() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
