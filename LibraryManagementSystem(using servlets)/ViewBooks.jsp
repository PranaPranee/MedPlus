<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <style>
        table {
            width: 750px;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px 12px;
            text-align: center;
        }
        .button-class {
            background-color: rgb(128, 128, 128);
            border: none;
            color: white;
            padding: 8px 12px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body bgcolor="lavender">
    <center>
        <h1>Book Details</h1>
        <c:if test="${not empty updateMessage}">
            <script>alert("${updateMessage}");</script>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Category</th>
                    <th>Status</th>
                    <th>Availability</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${books}">
                    <tr>
                        <td><c:out value="${row.bookId}"/></td>
                        <td><c:out value="${row.title}"/></td>
                        <td><c:out value="${row.author}"/></td>
                        <td><c:out value="${row.category}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${row.status eq 'A'}">Active</c:when>
                                <c:when test="${row.status eq 'I'}">Inactive</c:when>
                                <c:otherwise><c:out value="${row.status}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${row.availability eq 'A'}">Available</c:when>
                                <c:when test="${row.availability eq 'I'}">Issued</c:when>
                                <c:otherwise><c:out value="${row.availability}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
    <form action="BookController" method="post" style="display:inline;">
        <input type="hidden" name="action" value="updateBook" />
        <input type="hidden" name="bookId" value="${row.bookId}" />
        <button type="submit" class="button-class">Update</button>
    </form>
    <form action="BookController" method="post" style="display:inline;">
        <input type="hidden" name="action" value="updateAvailability" />
        <input type="hidden" name="bookId" value="${row.bookId}" />
        <button type="submit" class="button-class">Availability</button>
    </form>
</td>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <br>
        <a href="Book.html" class="button-class" style="background-color:red;">Back</a>
    </center>
</body>
</html>
