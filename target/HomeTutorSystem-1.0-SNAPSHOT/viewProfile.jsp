
<%@ page import="com.example.hometutorsystem.User" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="style.css">
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container">
    <h2>User Profile</h2>
    <p><strong>Username:</strong> <%= user.getUsername() %></p>
    <p><strong>Email:</strong> <%= user.getEmail() %></p>
    <p><strong>Phone:</strong> <%= user.getPhone() %></p>
    <p><strong>Role:</strong> <%= user.getRole() %></p>
    <form action="profile.jsp" method="get">
        <button type="submit">Update Details</button>
    </form>
</div>
<%@ include file="footer.jsp" %>
