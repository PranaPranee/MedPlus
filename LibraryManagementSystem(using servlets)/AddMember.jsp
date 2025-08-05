<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register Member</title>
</head>
<body bgcolor="lavender">
<center>
    <h1>Register Member</h1>

    <form action="MemberController?action=register" method="post">
        <label for="name">Enter Name:</label>
        <input type="text" id="name" name="name" value="${name}" required>
        <span style="color:red;">${nameError}</span>
        <br><br>

        <label for="email">Enter Email:</label>
        <input type="email" id="email" name="email" value="${email}" required>
        <span style="color:red;">${emailError}</span>
        <br><br>

        <label for="mobile">Enter Mobile Number:</label>
        <input type="text" id="mobile" name="mobile" value="${mobile}" maxlength="10" required>
        <span style="color:red;">${mobileError}</span>
        <br><br>

        <label for="gender">Select Gender:</label>
        <select name="gender" id="gender">
            <option value="">--Select--</option>
            <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
            <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
        </select>
        <span style="color:red;">${genderError}</span>
        <br><br>

        <label for="address">Enter Address:</label>
        <input type="text" id="address" name="address" value="${address}" required>
        <span style="color:red;">${addressError}</span>
        <br><br>

        <input type="submit" value="Register">
        <input type="button" value="Back" onclick="window.location.href='MemberController?action=view'">
    </form>
</center>
</body>
</html>
