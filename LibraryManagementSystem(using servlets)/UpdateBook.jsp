<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Book</title>
    <style>
        body { background: lavender; font-family: Arial, sans-serif; }
        .container {
            width: 600px; margin: 50px auto; background: #fff;
            padding: 30px; border-radius: 8px; box-shadow: 0 0 10px #aaa;
        }
        label { display: inline-block; width: 100px; }
        input, select { width: 200px; padding: 5px; margin-bottom: 15px; }
        .button-class {
            background-color: #808080; border: none; color: white;
            padding: 10px 20px; border-radius: 4px; cursor: pointer;
        }
        .back-button {
            background-color: red; text-decoration: none;
            padding: 10px 20px; border-radius: 4px; color: #fff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Book Details</h2>
        <form action="BookController" method="post">
            <input type="hidden" name="action" value="saveUpdate">
            <input type="hidden" name="bookId" value="${book.bookId}">
            <input type="hidden" name="availability" value="${book.availability}">

            <div>
                <label>Title:</label>
                <input type="text" name="title" value="${book.title}" required>
            </div>
            <div>
                <label>Author:</label>
                <input type="text" name="author" value="${book.author}" required>
            </div>
            <div>
                <label>Category:</label>
                <input type="text" name="category" value="${book.category}" required>
            </div>
            <div>
                <label>Status:</label>
                <select name="status">
                    <option value="A" <c:if test="${book.status eq 'A'}">selected</c:if>>Active</option>
                    <option value="I" <c:if test="${book.status eq 'I'}">selected</c:if>>Inactive</option>
                </select>
            </div>

            <button type="submit" class="button-class">Save Changes</button>
            <a href="BookController" class="back-button">Back</a>
        </form>
    </div>
</body>
</html>
