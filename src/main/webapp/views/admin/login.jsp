<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/14/2025
  Time: 9:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="./partials/hedder.jsp"%>

<title>Admin Login</title>
<link rel="shortcut icon" type="image/x-icon" href = "./favicon.jpeg" >
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src = "https://kit.fontawesome.com/46b998f154.js" crossorign = "anonymous"></script>
</head>

<body class="bg-indigo-100 min-h-screen flex items-center justify-center">
<div class="w-full max-w-md p-6 space-y-8 bg-indigo-50 rounded-lg shadow-lg">

    <!-- Logo Section -->
    <div class="text-center">
        <h1 class="text-3xl font-bold text-gray-800">
            <i class="fas fa-lock mr-2 text-blue-500"></i>Admin Portal
        </h1>
        <p class="mt-2 text-gray-500">Please sign in to continue</p>
    </div>

    <!-- Login Form -->
    <form class="mt-8 space-y-6" action="${pageContext.request.contextPath}/login" method="post">
        <div class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <div class="relative">
                    <input type="email"
                           name="email"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="Enter your Email"
                           required>
                    <i class="fas fa-id-card absolute right-3 top-3 text-gray-400"></i>
                </div>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                <div class="relative">
                    <input type="password"
                           name="password"
                           class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="Enter your password"
                           required>
                    <i class="fas fa-lock absolute right-3 top-3 text-gray-400"></i>
                </div>
            </div>
        </div>
        <p class="text-red-600 font-bold text-center ">
            ${errorMessage}
        </p>
        <!-- Remember Me & Forgot Password -->
        <div class="flex items-center justify-between">
            <div class="flex items-center">
                <input type="checkbox" class="h-4 w-4 text-blue-500 focus:ring-blue-500 border-gray-300 rounded">
                <label class="ml-2 text-sm text-gray-600">Remember me</label>
            </div>
            <a href="#" class="text-sm text-blue-500 hover:text-blue-700">Forgot password?</a>
        </div>

        <button type="submit"
                class="w-full bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-300">
            <i class="fas fa-sign-in-alt mr-2"></i>Login
        </button>

        <!-- Dashboard Link -->
        <div class="text-center mt-4">
            <a href="dashboard.html" class="text-sm text-gray-600 hover:text-blue-500">
                <i class="fas fa-arrow-left mr-2"></i>Back to Dashboard
            </a>
        </div>
    </form>
</div>
</body>
</html>