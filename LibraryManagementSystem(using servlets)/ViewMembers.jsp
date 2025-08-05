<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Members</title>
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
		<h1>Member Details</h1>

		<c:if test="${not empty updateMessage}">
			<script>
				alert("${updateMessage}");
			</script>
		</c:if>
		<p>Total members: ${fn:length(members)}</p>
		<table>
			<thead>
				<tr>
					<th>Member ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Mobile</th>
					<th>Gender</th>
					<th>Address</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${members}" var="row">
					<tr>
						<td><c:out value="${row.memberId}" /></td>
						<td><c:out value="${row.name}" /></td>
						<td><c:out value="${row.email}" /></td>
						<td><c:out value="${row.mobile}" /></td>
						<td><c:out value="${row.gender}" /></td>
						<td><c:out value="${row.address}" /></td>
						<td>
							<form action="MemberController" method="get">
								<input type="hidden" name="action" value="edit" /> <input
									type="hidden" name="memberId" value="${row.memberId}" />
								<button type="submit" class="button-class">Update</button>
							</form>

						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br> <a href="Member.html" class="button-class"
			style="background-color: red;">Back</a>
	</center>
</body>
</html>
