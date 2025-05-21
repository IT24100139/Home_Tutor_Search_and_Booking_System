<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tutor" %>
<%
  Tutor tutor = (Tutor) request.getAttribute("tutor");
  if (tutor == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile - Home Tutor System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <div class="form-container">
    <h2>Edit Profile</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form id="profileForm" action="${pageContext.request.contextPath}/profile/update" method="post">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" value="<%= tutor.getName() %>" required>
      </div>
      <div class="form-group">
        <label for="phone">Phone Number</label>
        <input type="tel" id="phone" name="phone" value="<%= tutor.getPhone() %>" required>
      </div>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" name="address" value="<%= tutor.getAddress() %>" required>
      </div>
      <div class="form-group">
        <label for="qualification">Qualification</label>
        <input type="text" id="qualification" name="qualification" value="<%= tutor.getQualification() %>" required>
      </div>
      <div class="form-group">
        <label for="subjectExpertise">Subject Expertise</label>
        <input type="text" id="subjectExpertise" name="subjectExpertise" value="<%= tutor.getSubjectExpertise() %>" required>
      </div>
      <div class="form-group">
        <label for="hourlyRate">Hourly Rate ($)</label>
        <input type="number" id="hourlyRate" name="hourlyRate" min="0" step="0.01"
               value="<%= tutor.getHourlyRate() %>" required>
      </div>
      <div class="form-group">
        <label for="experienceYears">Years of Experience</label>
        <input type="number" id="experienceYears" name="experienceYears" min="0"
               value="<%= tutor.getExperienceYears() %>" required>
      </div>
      <div class="form-group">
        <label for="availability">Availability</label>
        <textarea id="availability" name="availability" required><%= tutor.getAvailability() %></textarea>
      </div>
      <button type="submit" class="btn btn-block">Update Profile</button>
    </form>
  </div>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
