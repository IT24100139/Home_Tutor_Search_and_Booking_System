<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Tutor" %>
<%@ page import="java.util.List" %>
<%
  List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors");
%>
<!DOCTYPE html>
<html>
<head>
  <title>All Tutors - Home Tutor System</title>
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
  <h2>All Available Tutors</h2>

  <div class="search-box" style="margin-bottom: 30px;">
    <form id="searchForm" action="${pageContext.request.contextPath}/search" method="get">
      <input type="text" id="searchInput" name="subject" placeholder="Search by subject...">
      <button type="submit">Search</button>
    </form>
  </div>

  <% if (tutors.isEmpty()) { %>
  <div class="alert" style="text-align: center;">
    No tutors are currently registered in the system.
  </div>
  <% } else { %>
  <div class="tutors-table">
    <table>
      <thead>
      <tr>
        <th>Name</th>
        <th>Subject Expertise</th>
        <th>Qualification</th>
        <th>Hourly Rate</th>
        <th>Experience</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (Tutor tutor : tutors) { %>
      <tr>
        <td><%= tutor.getName() %></td>
        <td><%= tutor.getSubjectExpertise() %></td>
        <td><%= tutor.getQualification() %></td>
        <td>$<%= String.format("%.2f", tutor.getHourlyRate()) %></td>
        <td><%= tutor.getExperienceYears() %> years</td>
        <td>
          <a href="${pageContext.request.contextPath}/api/tutors/<%= tutor.getId() %>" class="btn">View</a>
          <% if (session.getAttribute("user") != null) { %>
          <a href="#" class="btn" style="background-color: #2196F3;">Book</a>
          <% } %>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
  <% } %>
</main>

<style>
  .tutors-table {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    padding: 20px;
    overflow-x: auto;
  }

  .tutors-table table {
    width: 100%;
    border-collapse: collapse;
  }

  .tutors-table th, .tutors-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
  }

  .tutors-table th {
    background-color: #f8f9fa;
    font-weight: 600;
    color: #333;
  }

  .tutors-table tr:hover {
    background-color: #f5f5f5;
  }

  .tutors-table .btn {
    padding: 5px 10px;
    font-size: 14px;
    margin-right: 5px;
  }
</style>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
