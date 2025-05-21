<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Feedback System</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
      line-height: 1.6;
    }
    .container {
      width: 80%;
      max-width: 800px;
      margin: 40px auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    h1 {
      color: #2c3e50;
      text-align: center;
      margin-bottom: 30px;
      border-bottom: 2px solid #eee;
      padding-bottom: 10px;
    }
    .card-container {
      display: flex;
      justify-content: space-around;
      margin: 40px 0;
    }
    .card {
      flex: 1;
      background: #f9f9f9;
      margin: 0 10px;
      padding: 20px;
      border-radius: 5px;
      text-align: center;
      transition: all 0.3s ease;
      border: 1px solid #ddd;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .card h2 {
      color: #3498db;
      margin-top: 0;
    }
    .card p {
      color: #7f8c8d;
    }
    .btn {
      display: inline-block;
      background: #3498db;
      color: white;
      padding: 10px 15px;
      border-radius: 4px;
      text-decoration: none;
      margin-top: 15px;
      transition: background 0.3s ease;
    }
    .btn:hover {
      background: #2980b9;
    }
    .footer {
      text-align: center;
      margin-top: 30px;
      color: #95a5a6;
      font-size: 0.9em;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Welcome to Feedback System</h1>

  <div class="card-container">
    <div class="card">
      <h2>Submit Feedback</h2>
      <p>Share your thoughts, suggestions, or comments with us. We value your input!</p>
      <a href="${pageContext.request.contextPath}/feedback" class="btn">Submit Now</a>
    </div>

    <div class="card">
      <h2>View Feedbacks</h2>
      <p>Browse through all the feedback that has been submitted to our system.</p>
      <a href="${pageContext.request.contextPath}/listFeedbacks" class="btn">View All</a>
    </div>
  </div>

  <div class="footer">
    <p>Feedback Management System &copy; 2023</p>
  </div>
</div>
</body>
</html>