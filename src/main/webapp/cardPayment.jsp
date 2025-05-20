<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Card Payment - Zentutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #2563eb; --light-bg: #f3f4f6; --card-bg: #ffffff; --text-dark: #1e293b; --input-border: #d1d5db; }
        body { background-color: var(--light-bg); font-family: 'Segoe UI', sans-serif; }
        .sidebar { background-color: #eff6ff; min-height: 100vh; padding: 2rem 1.2rem; border-right: 1px solid #e0e0e0; }
        .sidebar h4 { font-weight: 600; color: var(--primary); margin-bottom: 2rem; }
        .sidebar a { display: flex; align-items: center; padding: 10px 12px; margin-bottom: 12px; text-decoration: none; color: #333; border-radius: 8px; transition: background 0.2s ease; font-weight: 500; }
        .sidebar a i { margin-right: 10px; color: var(--primary); }
        .sidebar a:hover { background-color: #e0ecff; color: var(--primary); }
        .main { padding: 2.5rem; }
        .card-payment { background: var(--card-bg); border-radius: 12px; padding: 2rem; max-width: 600px; margin: 0 auto; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05); }
        .card-payment h2 { color: var(--text-dark); font-weight: 600; margin-bottom: 1.5rem; }
        label { font-weight: 500; margin-top: 1rem; color: #374151; }
        input { width: 100%; padding: 10px; margin-top: 6px; border: 1px solid var(--input-border); border-radius: 8px; font-size: 14px; }
        .btn-submit { background-color: var(--primary); color: white; border: none; padding: 12px; margin-top: 1.5rem; border-radius: 8px; font-weight: 600; width: 100%; transition: background-color 0.3s ease; }
        .btn-submit:hover { background-color: #1e40af; }
        .error { color: red; margin-bottom: 1rem; font-weight: 500; text-align: center; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <h4>Zentutor.lk</h4>
            <a href="payment-dashboard.jsp"><i class="fas fa-credit-card"></i> Payment</a>
            <a href="${pageContext.request.contextPath}/paymentList"><i class="fas fa-history"></i> History</a>
            <a href="${pageContext.request.contextPath}/invoice"><i class="fas fa-file-invoice"></i> Invoices</a>
        </div>
        <div class="col-md-10 main">
            <div class="card-payment">
                <h2>Payment Submission</h2>
                <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
                <form method="post" action="${pageContext.request.contextPath}/cardPayment">
                    <label for="tutorName">Tutor Name</label>
                    <input type="text" id="tutorName" name="tutorName" placeholder="Enter Tutor Name" required />
                    <label for="amount">Amount (LKR)</label>
                    <input type="text" id="amount" name="amount" placeholder="Enter amount" required />
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" maxlength="19" placeholder="1234 5678 9012 3456" required />
                    <label for="cardHolder">Card Holder Name</label>
                    <input type="text" id="cardHolder" name="cardHolder" required />
                    <label for="expiryDate">Expiry Date</label>
                    <input type="month" id="expiryDate" name="expiryDate" required />
                    <label for="cvv">CVV</label>
                    <input type="password" id="cvv" name="cvv" maxlength="4" placeholder="123" required />
                    <button type="submit" class="btn-submit">🔒 Pay Now</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
