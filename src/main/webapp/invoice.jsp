<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Generate invoice number format inside JSP
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice History - Zentutor</title>
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
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
        }

        .invoice-entry {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 1rem;
            background: #f9fbff;
            border: 1px solid #e1e5f2;
            border-radius: 10px;
            margin-bottom: 1rem;
        }

        .invoice-left {
            flex: 1;
        }

        .invoice-id {
            font-weight: 600;
            color: var(--text-dark);
        }

        .invoice-description {
            font-size: 14px;
            color: #555;
        }

        .invoice-date {
            font-size: 13px;
            color: #999;
        }

        .invoice-right {
            text-align: right;
        }

        .invoice-amount {
            font-weight: 600;
            color: var(--text-dark);
        }

        .btn-pdf {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 5px;
            margin-top: 5px;
            font-size: 14px;
        }

        .btn-pdf:hover {
            background-color: var(--hover);
        }

        .footer {
            text-align: center;
            padding: 1.5rem;
            font-size: 14px;
            color: #aaa;
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
                <h2>Invoice History</h2>

                <c:choose>
                    <c:when test="${empty payments}">
                        <p class="text-muted">No invoices available.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${payments}" varStatus="i">
                            <div class="invoice-entry">
                                <div class="invoice-left">
                                    <div class="invoice-id">
                                        INV-<fmt:formatDate value="${p.paymentDate}" pattern="yyyyMMdd" />-${i.index + 1}
                                    </div>
                                    <div class="invoice-description">${p.tutorName}</div>
                                    <div class="invoice-date">
                                        <fmt:formatDate value="${p.paymentDate}" pattern="dd MMMM yyyy" />
                                    </div>
                                </div>
                                <div class="invoice-right">
                                    <div class="invoice-amount">LKR <fmt:formatNumber value="${p.total}" type="currency" currencySymbol=""/></div>
                                    <button class="btn btn-pdf"><i class="fas fa-download"></i> PDF</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="footer">© 2025 Zentutor.lk. All rights reserved.</div>
        </div>
    </div>
</div>
</body>
</html>
