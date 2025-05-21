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
  <title>My Profile - Home Tutor System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/search">Find Tutors</a></li>
        <li><a href="${pageContext.request.contextPath}/profile/edit">Edit Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success">
    <%= request.getAttribute("success") %>
  </div>
  <% } %>

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-error">
    <%= request.getAttribute("error") %>
  </div>
  <% } %>

  <div class="profile-header">
    <div class="profile-avatar">
      <%= tutor.getName().charAt(0) %>
    </div>
    <div class="profile-info">
      <h2><%= tutor.getName() %></h2>
      <p><%= tutor.getQualification() %></p>
    </div>
  </div>

  <div class="profile-details">
    <div class="detail-row">
      <div class="detail-label">Email</div>
      <div class="detail-value"><%= tutor.getEmail() %></div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Phone</div>
      <div class="detail-value"><%= tutor.getPhone() %></div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Address</div>
      <div class="detail-value"><%= tutor.getAddress() %></div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Subject Expertise</div>
      <div class="detail-value"><%= tutor.getSubjectExpertise() %></div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Hourly Rate</div>
      <div class="detail-value">$<%= String.format("%.2f", tutor.getHourlyRate()) %></div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Experience</div>
      <div class="detail-value"><%= tutor.getExperienceYears() %> years</div>
    </div>
    <div class="detail-row">
      <div class="detail-label">Availability</div>
      <div class="detail-value"><%= tutor.getAvailability() %></div>
    </div>
  </div>

  <form action="${pageContext.request.contextPath}/profile/delete" method="post" style="margin-top: 20px;">
    <button type="submit" class="btn" style="background-color: #f44336;"
            onclick="return confirm('Are you sure you want to delete your profile? This cannot be undone.');">
      Delete Profile
    </button>
  </form>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
