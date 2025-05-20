<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Payment - Zentutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #eff6ff;
            --hover-bg: #f0f4ff;
            --gray: #f8f9fa;
        }

        body {
            background-color: var(--gray);
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            background-color: var(--primary-light);
            min-height: 100vh;
            padding: 2rem 1.2rem;
            border-right: 1px solid #e0e0e0;
        }

        .sidebar h4 {
            font-weight: 600;
            margin-bottom: 2rem;
            color: var(--primary);
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 10px 12px;
            margin-bottom: 12px;
            text-decoration: none;
            color: #333;
            border-radius: 8px;
            transition: background 0.2s ease;
            font-weight: 500;
        }

        .sidebar a i {
            margin-right: 10px;
            color: var(--primary);
        }

        .sidebar a:hover {
            background-color: var(--hover-bg);
            color: var(--primary);
        }

        .main {
            padding: 2.5rem;
        }

        .card-section {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
            max-width: 600px;
            margin: auto;
        }

        h2 {
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #1e3a8a;
        }

        label {
            display: block;
            margin-top: 1rem;
            font-weight: 600;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .btn-submit {
            margin-top: 1.5rem;
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #1e40af;
        }

        .error {
            color: red;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <h4>Zentutor.lk</h4>
            <a href="payment-dashboard.jsp"><i class="fas fa-credit-card"></i> Payment</a>
            <a href="${pageContext.request.contextPath}/paymentList"><i class="fas fa-history"></i> History</a>
            <a href="${pageContext.request.contextPath}/invoice"><i class="fas fa-file-invoice"></i> Invoices</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 main">
            <div class="card-section">
                <h2>Update Payment</h2>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/paymentUpdate" method="post">
                    <input type="hidden" name="paymentId" value="${paymentToUpdate.paymentId}" />

                    <label for="tutorName">Tutor Name</label>
                    <input type="text" id="tutorName" name="tutorName" value="${paymentToUpdate.tutorName}" required />

                    <label for="rate">Amount (LKR)</label>
                    <input type="number" step="0.01" id="rate" name="rate" value="${paymentToUpdate.rate}" min="0" required />

                    <button type="submit" class="btn-submit">Update Payment</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
