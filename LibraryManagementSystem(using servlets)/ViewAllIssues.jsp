<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.IssueRecords" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Issues</title>
    <style>
        body {
            background-color: lavender;
            font-family: Arial, sans-serif;
            text-align: center;
        }
        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #999;
            color: white;
        }
        .back-button {
            background-color: gray;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h1>Issued Books</h1>

<table>
    <thead>
        <tr>
            <th>Issue ID</th>
            <th>Book ID</th>
            <th>Member ID</th>
            <th>Availability</th>
            <th>Issue Date</th>
            <th>Return Date</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="issue" items="${issues}">
            <tr>
                <td>${issue.issueId}</td>
                <td>${issue.bookId}</td>
                <td>${issue.memberId}</td>
                <td>${issue.availability}</td>
                <td>${issue.issueDate}</td>
                <td>${issue.returnDate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<a href="javascript:history.back()" class="back-button">Back</a>

</body>
</html>
