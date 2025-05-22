
<!DOCTYPE html>
<html>
<head>
    <title>Home Tutor System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    Home Tutor System
</header>
<jsp:include page='<%= request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/") + 1) %>' />
<footer>
    &copy; 2025 Home Tutor System | Designed for Students
</footer>
</body>
</html>
