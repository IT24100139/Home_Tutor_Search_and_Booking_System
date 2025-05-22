
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
    <h2>Edit Profile</h2>
    <form action="user" method="post">
        <input type="hidden" name="action" value="update">
        Email: <input type="email" name="email" value="<%= user.getEmail() %>" required>
        Phone: <input type="text" name="phone" value="<%= user.getPhone() %>" required>
        Password: <input type="password" name="password" value="<%= user.getPassword() %>" required>
        <button type="submit">Update</button>
    </form>
    <br>
    <form action="user" method="post">
        <input type="hidden" name="action" value="delete">
        <button type="submit" style="background-color:red;">Delete Account</button>
    </form>
</div>
<%@ include file="footer.jsp" %>
