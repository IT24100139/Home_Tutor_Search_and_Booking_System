<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Feedback</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }
    .container {
      max-width: 600px;
      margin: 40px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }
    .form-group {
      margin-bottom: 20px;
    }
    label {
      display: block;
      font-weight: bold;
      margin-bottom: 5px;
      color: #555;
    }
    input[type="text"],
    input[type="email"],
    textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }
    textarea {
      height: 150px;
      resize: vertical;
    }
    .error {
      color: #dc3545;
      background-color: #f8d7da;
      padding: 10px;
      border-radius: 4px;
      margin-bottom: 20px;
    }
    .button-container {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
    }
    .btn {
      display: inline-block;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      text-decoration: none;
      text-align: center;
      transition: background-color 0.3s;
    }
    .btn-submit {
      background-color: #4CAF50;
      color: white;
      flex-grow: 1;
      margin-left: 10px;
    }
    .btn-submit:hover {
      background-color: #45a049;
    }
    .btn-cancel {
      background-color: #6c757d;
      color: white;
    }
    .btn-cancel:hover {
      background-color: #5a6268;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Submit Feedback</h1>

  <c:if test="${not empty error}">
    <div class="error">${error}</div>
  </c:if>

  <form action="${pageContext.request.contextPath}/feedback" method="post">
    <div class="form-group">
      <label for="name">Name:</label>
      <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
      <label for="subject">Subject:</label>
      <input type="text" id="subject" name="subject" required>
    </div>

    <div class="form-group">
      <label for="message">Message:</label>
      <textarea id="message" name="message" required></textarea>
    </div>

    <div class="button-container">
      <a href="${pageContext.request.contextPath}/" class="btn btn-cancel">Cancel</a>
      < type="submit" class="btn btn-submit">Submit Feedback</>
    </div>
  </form>
</div>
</body>
</html>