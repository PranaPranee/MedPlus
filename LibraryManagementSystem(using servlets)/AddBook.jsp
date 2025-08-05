<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book</title>
<style>
    .error {
        color: red;
    }
</style>
</head>
<body bgcolor="lavender">
<center>
<h1>Add Book</h1>

<form action="${pageContext.request.contextPath}/BookController" method="post">
    <label for="title">Enter Title :</label>
    <input type="text" id="title" name="title" value="${title}" required>
    <span class="error">${titleErrorLabel}</span>
    <br><br>

    <label for="author">Enter Author :</label>
    <input type="text" id="author" name="author" value="${author}" required>
    <span class="error">${authorErrorLabel}</span>
    <br><br>

    <label for="category">Category :</label>
    <input type="text" id="category" name="category" value="${category}" required>
    <span class="error">${categoryErrorLabel}</span>
    <br><br>

    <input type="hidden" name="action" value="addbook">
    <input type="submit" value="Submit">
    <input type="button" value="Back" onclick="history.back()">
</form>

</center>
</body>
</html>
