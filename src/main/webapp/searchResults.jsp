<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tutor" %>
<%@ page import="java.util.List" %>
<%
  List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors");
  String searchSubject = (String) request.getAttribute("searchSubject");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Search Results - Home Tutor System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <% if (session.getAttribute("user") != null) { %>
        <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
        <% } else { %>
        <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
        <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
        <% } %>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <h2>
    <% if (searchSubject != null) { %>
    Tutors for: <%= searchSubject %>
    <% } else { %>
    All Tutors
    <% } %>
  </h2>

  <form id="searchForm" action="${pageContext.request.contextPath}/search" method="get" class="search-box">
    <input type="text" id="searchInput" name="subject" placeholder="Search by subject..."
           value="<%= searchSubject != null ? searchSubject : "" %>">
    <button type="submit">Search</button>
  </form>

  <% if (tutors.isEmpty()) { %>
  <p>No tutors found matching your criteria.</p>
  <% } else { %>
  <div class="tutor-list">
    <% for (Tutor tutor : tutors) { %>
    <div class="tutor-card">
      <h3><%= tutor.getName() %></h3>
      <span class="expertise"><%= tutor.getSubjectExpertise() %></span>
      <p class="qualification"><%= tutor.getQualification() %></p>
      <p class="rate">$<%= String.format("%.2f", tutor.getHourlyRate()) %> per hour</p>
      <p><%= tutor.getExperienceYears() %> years of experience</p>
      <p>Availability: <%= tutor.getAvailability() %></p>
      <div class="actions">
        <a href="${pageContext.request.contextPath}/api/tutors/<%= tutor.getId() %>" class="btn">View Details</a>
        <% if (session.getAttribute("user") != null) { %>
        <a href="#" class="btn" style="background-color: #2196F3;">Book Session</a>
        <% } %>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
