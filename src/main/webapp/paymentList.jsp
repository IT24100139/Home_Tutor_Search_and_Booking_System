<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment History - Zentutor</title>
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
            transition: background-color 0.3s ease;
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
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
            transition: transform 0.3s ease;
        }

        h2 {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
        }

        .table {
            margin-top: 1rem;
            border-radius: 12px;
            overflow: hidden;
        }

        th {
            background-color: #e9efff;
            color: var(--text-dark);
        }

        td {
            vertical-align: middle;
        }

        .action-btn {
            margin: 0 4px;
            transition: transform 0.2s ease;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        .btn-blue {
            background-color: var(--primary);
            color: white;
            border: none;
        }

        .btn-blue:hover {
            background-color: var(--hover);
        }

        .text-muted {
            font-size: 14px;
            color: #6c757d;
        }

        .table-hover tbody tr:hover {
            background-color: #f0f8ff;
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
                <h2><i class="fas fa-table me-2"></i>Payment History</h2>

                <c:choose>
                    <c:when test="${empty payments}">
                        <p class="text-muted">No payment records available.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover align-middle">
                                <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Tutor</th>
                                    <th>Method</th>
                                    <th>Amount</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="p" items="${payments}">
                                    <tr>
                                        <td><fmt:formatDate value="${p.paymentDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>${p.tutorName}</td>
                                        <td>${p.paymentMethod}</td> <!-- ✅ Show method -->
                                        <td>LKR ${p.total}</td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/paymentList" style="display:inline;">
                                                <input type="hidden" name="paymentId" value="${p.paymentId}" />
                                                <input type="hidden" name="action" value="delete" />
                                                <button type="submit" class="btn btn-blue btn-sm action-btn" title="Delete">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/paymentList" style="display:inline;">
                                                <input type="hidden" name="paymentId" value="${p.paymentId}" />
                                                <input type="hidden" name="action" value="update" />
                                                <button type="submit" class="btn btn-blue btn-sm action-btn" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</body>
</html>
