<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Member</title>
</head>
<body bgcolor="lavender">
<center>
<h1>Update Member Details</h1>

<form action="MemberController?action=update" method="post">
  <label for="memberid">Member Id :</label>
  <input type="number" id="memberid" name="memberId" value="${member.memberId}" readonly><br><br>

  <label for="name">Enter Name :</label>
  <input type="text" id="name" name="name" value="${member.name}">
  <span style="color:red;">${nameError}</span><br><br>

  <label for="email">Enter Email :</label>
  <input type="email" id="email" name="email" value="${member.email}">
  <span style="color:red;">${emailError}</span><br><br>

  <label for="mobile">Enter Mobile Number :</label>
  <input type="text" id="mobile" name="mobile" value="${member.mobile}">
  <span style="color:red;">${mobileError}</span><br><br>

  <label for="gender">Select Gender :</label>
  <select name="gender" id="gender">
    <option value="">--Select--</option>
    <option value="Male" ${member.gender == 'M' ? 'selected' : ''}>Male</option>
    <option value="Female" ${member.gender == 'F' ? 'selected' : ''}>Female</option>
  </select>
  <span style="color:red;">${genderError}</span><br><br>

  <label for="address">Enter Address :</label>
  <input type="text" id="address" name="address" value="${member.address}">
  <span style="color:red;">${addressError}</span><br><br>

  <input type="submit" value="Update">
  <input type="button" value="Back" onclick="window.location.href='MemberController?action=view'">
</form>
</center>
</body>
</html>
