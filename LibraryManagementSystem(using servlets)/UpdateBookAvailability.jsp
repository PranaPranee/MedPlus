<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Book Availability</title>
    <style>
        body {
            background: lavender;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 500px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px #aaa;
        }
        h2 {
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
        label {
            display: inline-block;
            width: 120px;
            margin-bottom: 10px;
        }
        input, select {
            width: 200px;
            padding: 5px;
            margin-bottom: 15px;
        }
        .button-class {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .back-button {
            background-color: transparent;
            color: red;
            border: none;
            padding: 10px 20px;
            text-decoration: underline;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Book Availability</h2>

        <form action="BookController" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="action" value="saveAvailabilityUpdate">
            <input type="hidden" name="bookId" value="${book.bookId}">
            <input type="hidden" name="title" value="${book.title}">
            <input type="hidden" name="author" value="${book.author}">
            <input type="hidden" name="category" value="${book.category}">
            <input type="hidden" name="status" value="${book.status}">

            <div>
                <label>Book ID:</label>
                <input type="text" value="${book.bookId}" readonly>
            </div>

            <div>
                <label>Title:</label>
                <input type="text" value="${book.title}" readonly>
            </div>

            <div>
                <label>Author:</label>
                <input type="text" value="${book.author}" readonly>
            </div>

            <div>
                <label>Category:</label>
                <input type="text" value="${book.category}" readonly>
            </div>

            <div>
                <label>Availability:</label>
                <select name="availability" id="availabilitySelect">
                    <option value="">-- Select Availability --</option>
                    <option value="A" <c:if test="${book.availability eq 'A'}">selected</c:if>>Available</option>
                    <option value="I" <c:if test="${book.availability eq 'I'}">selected</c:if>>Issued</option>
                </select>
            </div>

            <div>
                <button type="submit" class="button-class">Update Availability</button>
                <button type="button" class="back-button" onclick="window.location.href='BookController'">Back</button>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            const availability = document.getElementById('availabilitySelect').value;
            if (availability === "") {
                alert("Please select availability status.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
