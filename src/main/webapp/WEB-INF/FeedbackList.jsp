<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Feedback List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        .message { color: green; margin-bottom: 15px; }
        .add-btn { display: inline-block; padding: 10px 15px; background: #4CAF50; color: white; text-decoration: none; }
    </style>
</head>
<body>
<h1>Feedback List</h1>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Feedback List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
        }
        .update-link {
            color: #2196F3;
        }
        .delete-link {
            color: #f44336;
        }
        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .button {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Feedback List</h1>

    <c:if test="${not empty message}">
    <div class="success-message">${message}</div>
    </c:if>

    <a href="${pageContext.request.contextPath}/feedback" class="button">Submit New Feedback</a>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Feedback List</title>
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
                max-width: 1000px;
                margin: 40px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }
            .success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 4px;
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f8f9fa;
                color: #495057;
                font-weight: bold;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .td-message {
                max-width: 300px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .actions {
                white-space: nowrap;
            }
            .btn {
                display: inline-block;
                padding: 8px 16px;
                margin: 5px 0;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: bold;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #45a049;
            }
            .btn-edit {
                background-color: #2196F3;
            }
            .btn-edit:hover {
                background-color: #0b7dda;
            }
            .btn-delete {
                background-color: #f44336;
            }
            .btn-delete:hover {
                background-color: #d32f2f;
            }
            .empty-list {
                text-align: center;
                padding: 30px;
                background-color: #f8f9fa;
                border-radius: 4px;
                margin: 20px 0;
                color: #6c757d;
            }
            .header-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>All Feedback</h1>

        <c:if test="${not empty message}">
            <div class="success-message">${message}</div>
        </c:if>

        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/" class="btn">Home</a>
            <a href="${pageContext.request.contextPath}/feedback" class="btn">Submit New Feedback</a>
        </div>

        <c:choose>
            <c:when test="${empty feedbacks}">
                <div class="empty-list">
                    <h3>No feedback entries found</h3>
                    <p>There are currently no feedback submissions. Please create one using the "Submit New Feedback" button.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Date Submitted</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="feedback" items="${feedbacks}">
                        <tr>
                            <td>${feedback.id}</td>
                            <td>${feedback.name}</td>
                            <td>${feedback.email}</td>
                            <td>${feedback.subject}</td>
                            <td class="td-message">${feedback.message}</td>
                            <td><fmt:formatDate value="${feedback.dateSubmitted}" pattern="yyyy-MM-dd HH:mm" /></td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/updateFeedback?id=${feedback.id}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/deleteFeedback?id=${feedback.id}"
                                   onclick="return confirm('Are you sure you want to delete this feedback?')"
                                   class="btn btn-delete">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
    </body>
    </html>
