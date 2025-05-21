<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Tutor Search and Booking System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
    <div class="container">
        <h1>Home Tutor Search</h1>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
                <li><a href="${pageContext.request.contextPath}/search">Find Tutors</a></li>
            </ul>
        </nav>
    </div>
</header>

<main class="container">
    <section class="hero">
        <h2>Find the Perfect Tutor for Your Needs</h2>
        <p>Browse through our qualified tutors and book sessions at your convenience.</p>
        <a href="${pageContext.request.contextPath}/search" class="btn">Browse Tutors</a>
    </section>

    <section class="features">
        <div class="feature">
            <h3>Qualified Tutors</h3>
            <p>All our tutors are verified and have excellent qualifications.</p>
        </div>
        <div class="feature">
            <h3>Flexible Scheduling</h3>
            <p>Choose time slots that work best for you.</p>
        </div>
        <div class="feature">
            <h3>Various Subjects</h3>
            <p>From math to music, we have experts in all fields.</p>
        </div>
    </section>
</main>

<footer>
    <div class="container">
        <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>