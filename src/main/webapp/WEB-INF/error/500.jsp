<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Server Error</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f7f9fc;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      text-align: center;
    }
    .error-container {
      background-color: white;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      width: 90%;
    }
    h1 {
      color: #d32f2f;
      margin-bottom: 20px;
      font-size: 2.5em;
    }
    .error-code {
      font-size: 5em;
      font-weight: bold;
      color: #34495e;
      margin: 20px 0;
    }
    p {
      color: #7f8c8d;
      margin-bottom: 30px;
      font-size: 1.1em;
      line-height: 1.6;
    }
    .btn {
      display: inline-block;
      background-color: #3498db;
      color: white;
      padding: 12px 24px;
      border-radius: 4px;
      text-decoration: none;
      font-weight: bold;
      transition: background-color 0.3s;
    }
    .btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>
<div class="error-container">
  <h1>Server Error</h1>
  <div class="error-code">500</div>
  <p>Something went wrong on our end. Our technical team has been notified and is working to fix the issue.</p>
  <p>Please try again later or contact support if the problem persists.</p>
  <%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html>
  <html>
  <head>
    <title>Server Error</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
        color: #333;
      }
      .container {
        max-width: 800px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
      }
      .error-code {
        font-size: 120px;
        color: #e74c3c;
        margin: 0;
        line-height: 1;
      }
      .error-message {
        font-size: 24px;
        color: #333;
        margin: 20px 0 30px;
      }
      .error-details {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 4px;
        margin: 20px 0;
        text-align: left;
        overflow: auto;
      }
      .btn {
        display: inline-block;
        background-color: #3498db;
        color: white;
        padding: 12px 24px;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
        transition: background-color 0.3s;
      }
      .btn:hover {
        background-color: #2980b9;
      }
      .suggestion {
        margin-top: 30px;
        color: #666;
      }
    </style>
  </head>
  <body>
  <div class="container">
    <h1 class="error-code">500</h1>
    <h2 class="error-message">Server Error</h2>
    <p>Sorry, something went wrong on our end. We're working to fix the problem.</p>

    <c:if test="${not empty pageContext.exception}">
      <div class="error-details">
        <p><strong>Error Details:</strong> ${pageContext.exception.message}</p>
      </div>
    </c:if>

    <div class="suggestion">
      <p>Please try again later or contact the administrator if the problem persists.</p>
      <a href="${pageContext.request.contextPath}/" class="btn">Home Page</a>
    </div>
  </div>
  </body>
  </html>
  <a href="${pageContext.request.contextPath}/" class="btn">Back to Home</a>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Server Error</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f7f9fc;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      text-align: center;
    }
    .error-container {
      background-color: white;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      width: 90%;
    }
    h1 {
      color: #d32f2f;
      margin-bottom: 20px;
      font-size: 2.5em;
    }
    .error-code {
      font-size: 5em;
      font-weight: bold;
      color: #34495e;
      margin: 20px 0;
    }
    p {
      color: #7f8c8d;
      margin-bottom: 30px;
      font-size: 1.1em;
      line-height: 1.6;
    }
    .btn {
      display: inline-block;
      background-color: #3498db;
      color: white;
      padding: 12px 24px;
      border-radius: 4px;
      text-decoration: none;
      font-weight: bold;
      transition: background-color 0.3s;
    }
    .btn:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>
<div class="error-container">
  <h1>Server Error</h1>
  <div class="error-code">500</div>
  <p>Something went wrong on our end. Our technical team has been notified and is working to fix the issue.</p>
  <p>Please try again later or contact support if the problem persists.</p>

  <a href="${pageContext.request.contextPath}/" class="btn">Back to Home</a>
</div>
</body>
</html>