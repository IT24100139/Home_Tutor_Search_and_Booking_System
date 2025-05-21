<%--
  Created by IntelliJ IDEA.
  User: cheth
  Date: 20/05/2025
  Time: 9:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>404 Not Found</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
  <div class="container">
    <h1>Home Tutor Search</h1>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
      </ul>
    </nav>
  </div>
</header>

<main class="container">
  <div class="error-page">
    <h2>404 - Page Not Found</h2>
    <p>The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn">Go to Homepage</a>
  </div>
</main>
</body>
</html>
