<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Bank Transfer Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --hover: #1e40af;
            --light-bg: #f3f4f6;
            --card-bg: #ffffff;
            --text-dark: #1e293b;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            background-color: #eff6ff;
            min-height: 100vh;
            padding: 2rem 1.2rem;
            border-right: 1px solid #e0e0e0;
        }

        .sidebar h4 {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 2rem;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 10px 12px;
            margin-bottom: 12px;
            text-decoration: none;
            color: #333;
            border-radius: 8px;
            transition: background-color 0.2s ease;
            font-weight: 500;
        }

        .sidebar a i {
            margin-right: 10px;
            color: var(--primary);
        }

        .sidebar a:hover {
            background-color: #e0ecff;
            color: var(--primary);
        }

        .main {
            padding: 2.5rem;
        }

        .card-section {
            background-color: var(--card-bg);
            border-radius: 12px;
            padding: 2rem;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 6px 20px rgba(0,0,0,0.05);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: var(--primary);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: var(--hover);
        }

        .error {
            color: red;
            margin-bottom: 10px;
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

        <!-- Main Form Area -->
        <div class="col-md-10 main">
            <div class="card-section">
                <h2>Bank Transfer</h2>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/bankTransfer">
                    <label for="tutorName">Tutor Name</label>
                    <input type="text" id="tutorName" name="tutorName" required />

                    <label for="amount">Amount (LKR)</label>
                    <input type="text" id="amount" name="amount" required />

                    <label for="accountNumber">Account Number</label>
                    <input type="text" id="accountNumber" name="accountNumber" required />

                    <label for="accountName">Account Holder Name</label>
                    <input type="text" id="accountName" name="accountName" required />

                    <label for="bankName">Bank Name</label>
                    <input type="text" id="bankName" name="bankName" required />

                    <label for="branchCode">Branch Code</label>
                    <input type="text" id="branchCode" name="branchCode" required />

                    <button type="submit">Submit Payment</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
