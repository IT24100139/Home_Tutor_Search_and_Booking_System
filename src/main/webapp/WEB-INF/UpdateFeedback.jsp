<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Update Feedback</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { max-width: 500px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="email"], textarea {
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;
        }
        textarea { height: 100px; }
        button { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
        a { text-decoration: none; color: #2196F3; }
    </style>
</head>
<body>
<h1>Update Feedback</h1>
<form action="updateFeedback" method="post">
    <input type="hidden" name="id" value="${feedback.id}">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Update Feedback</title>
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
            .buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }
            .btn {
                display: inline-block;
                padding: 12px 24px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                text-decoration: none;
                text-align: center;
                transition: background-color 0.3s;
            }
            .btn-primary {
                background-color: #4CAF50;
                color: white;
            }
            .btn-primary:hover {
                background-color: #45a049;
            }
            .btn-secondary {
                background-color: #f44336;
                color: white;
            }
            .btn-secondary:hover {
                background-color: #d32f2f;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>Update Feedback</h1>

        <form action="${pageContext.request.contextPath}/updateFeedback" method="post">
            <input type="hidden" name="id" value="${feedback.id}">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${feedback.name}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${feedback.email}" required>
            </div>

            <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject" value="${feedback.subject}" required>
            </div>

            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" required>${feedback.message}</textarea>
            </div>

            <div class="buttons">
                <a href="${pageContext.request.contextPath}/listFeedbacks" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Update Feedback</button>
            </div>
        </form>
    </div>
    </body>
    </html>
    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${feedback.name}" required>
    </div>

    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${feedback.email}" required>
    </div>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <html>
    <head>
        <title>Update Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                line-height: 1.6;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="email"],
            textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            textarea {
                height: 100px;
                resize: vertical;
            }
            .actions {
                margin-top: 20px;
            }
            .btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                border: none;
                cursor: pointer;
            }
            .btn-cancel {
                background-color: #f44336;
                margin-left: 10px;
            }
            .btn:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>Update Feedback</h1>

        <form action="${pageContext.request.contextPath}/updateFeedback" method="post">
            <input type="hidden" name="id" value="${feedback.id}">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${feedback.name}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${feedback.email}" required>
            </div>

            <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject" value="${feedback.subject}" required>
            </div>

            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" required>${feedback.message}</textarea>
            </div>

            <div class="actions">
                <button type="submit" class="btn">Update Feedback</button>
                <a href="${pageContext.request.contextPath}/listFeedbacks" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
    </body>
    </html>
    <div class="form-group">
        <label for="subject">Subject:</label>
        <input type="text" id="subject" name="subject" value="${feedback.subject}" required>
    </div>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Update Feedback</title>
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
            .button-row {
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
            }
            .btn-update {
                background-color: #4CAF50;
                color: white;
            }
            .btn-update:hover {
                background-color: #45a049;
            }
            .btn-cancel {
                background-color: #f44336;
                color: white;
            }
            .btn-cancel:hover {
                background-color: #d32f2f;
            }
            .meta-info {
                font-size: 0.9em;
                color: #666;
                margin-top: 5px;
                text-align: right;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>Update Feedback</h1>

        <form action="${pageContext.request.contextPath}/updateFeedback" method="post">
            <input type="hidden" name="id" value="${feedback.id}">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${feedback.name}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${feedback.email}" required>
            </div>

            <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject" value="${feedback.subject}" required>
            </div>

            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" required>${feedback.message}</textarea>
            </div>

            <div class="meta-info">
                Originally submitted: <fmt:formatDate value="${feedback.dateSubmitted}" pattern="yyyy-MM-dd HH:mm:ss" />
            </div>

            <div class="button-row">
                <a href="${pageContext.request.contextPath}/listFeedbacks" class="btn btn-cancel">Cancel</a>
                <button type="submit" class="btn btn-update">Update Feedback</button>
            </div>
        </form>
    </div>
    </body>
    </html>
    <div class="form-group">
        <label for="message">Message:</label>
        <textarea id="message" name="message" required>${feedback.message}</textarea>
    </div>

    <button type="submit">Update Feedback</button>
    <a href="listFeedbacks" style="margin-left: 10px;">Cancel</a>
</form>
</body>
</html>