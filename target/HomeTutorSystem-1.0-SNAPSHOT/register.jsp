
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="style.css">
<div class="container">
    <h2>Register</h2>
    <form action="user" method="post">
        <input type="hidden" name="action" value="register">
        Username: <input type="text" name="username" required>
        Email: <input type="email" name="email" required>
        Phone: <input type="text" name="phone" required>
        Password: <input type="password" name="password" required>
        Role:
        <select name="role">
            <option value="student">Student</option>
            <option value="tutor">Tutor</option>
        </select>
        <button type="submit">Register</button>
    </form>
</div>
<%@ include file="footer.jsp" %>
