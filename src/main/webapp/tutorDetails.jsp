<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tutor" %>
<%
  Tutor tutor = (Tutor) request.getAttribute("tutor");
  if (tutor == null) {
    response.sendRedirect(request.getContextPath() + "/search");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title><%= tutor.getName() %> - Home Tutor System</title>
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
        <% if (session.getAttribute("user") != null) { %>
        <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
        <% } else { %>
        <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
        <% } %>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
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

  <% if (session.getAttribute("user") != null) { %>
  <div style="margin-top: 20px; text-align: center;">
    <a href="#" class="btn" style="background-color: #2196F3; display: inline-block; padding: 10px 30px;">
      Book a Session
    </a>
  </div>
  <% } else { %>
  <p style="text-align: center; margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/login.jsp">Login</a> to book a session with this tutor.
  </p>
  <% } %>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
