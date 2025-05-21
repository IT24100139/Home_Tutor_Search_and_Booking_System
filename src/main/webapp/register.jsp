<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Register - Home Tutor System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <div class="form-container">
    <h2>Register as a Tutor</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form id="registerForm" action="${pageContext.request.contextPath}/auth/register" method="post">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" required>
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>
      <div class="form-group">
        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
      </div>
      <div class="form-group">
        <label for="phone">Phone Number</label>
        <input type="tel" id="phone" name="phone" required>
      </div>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" name="address" required>
      </div>
      <div class="form-group">
        <label for="qualification">Qualification</label>
        <input type="text" id="qualification" name="qualification" required>
      </div>
      <div class="form-group">
        <label for="subjectExpertise">Subject Expertise</label>
        <input type="text" id="subjectExpertise" name="subjectExpertise" required>
      </div>
      <div class="form-group">
        <label for="hourlyRate">Hourly Rate ($)</label>
        <input type="number" id="hourlyRate" name="hourlyRate" min="0" step="0.01" required>
      </div>
      <div class="form-group">
        <label for="experienceYears">Years of Experience</label>
        <input type="number" id="experienceYears" name="experienceYears" min="0" required>
      </div>
      <div class="form-group">
        <label for="availability">Availability</label>
        <textarea id="availability" name="availability" required></textarea>
      </div>
      <button type="submit" class="btn btn-block">Register</button>
    </form>

    <p style="text-align: center; margin-top: 20px;">
      Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
    </p>
  </div>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
