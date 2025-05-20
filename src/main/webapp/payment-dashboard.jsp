<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zentutor - Payment Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">

    <!-- FontAwesome for icons -->
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
        }

        .card-section h2 {
            font-weight: 600;
            color: #1e3a8a;
            margin-bottom: 1rem;
        }

        .action-tile {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--primary-light);
            padding: 1rem 1.2rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            transition: all 0.2s ease;
            text-decoration: none;
            color: #1e3a8a;
            font-weight: 500;
        }

        .action-tile i {
            font-size: 1.2rem;
            margin-right: 12px;
        }

        .action-tile:hover {
            background-color: var(--hover-bg);
            transform: translateX(4px);
        }

        .icon-left {
            display: flex;
            align-items: center;
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

        <!-- Main Section -->
        <div class="col-md-10 main">
            <div class="card-section">
                <h2>Payment Submission</h2>
                <p class="text-muted">Select a payment method to proceed with your tutor payment.</p>

                <!-- Payment Options -->
                <a href="cardPayment.jsp" class="action-tile">
                    <div class="icon-left">
                        <i class="fas fa-credit-card"></i>
                        Pay with Credit/Debit Card
                    </div>
                    <i class="fas fa-arrow-right"></i>
                </a>

                <a href="${pageContext.request.contextPath}/bankTransfer" class="action-tile">
                    <div class="icon-left">
                        <i class="fas fa-university"></i>
                        Pay via Bank Transfer
                    </div>
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
