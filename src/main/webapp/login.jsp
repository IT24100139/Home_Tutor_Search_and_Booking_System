<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login - Home Tutor System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <div class="form-container">
    <h2>Login to Your Account</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/auth/login" method="post">
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>
      <button type="submit" class="btn btn-block">Login</button>
    </form>

    <p style="text-align: center; margin-top: 20px;">
      Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Register here</a>
    </p>
  </div>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
