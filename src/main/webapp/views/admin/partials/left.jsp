<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/11/2025
  Time: 6:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel = "shortcut icon" href = "../favicon.jpeg" type = "image/x-icon">
<script src = "https://cdn.tailwindcss.com"></script>
<link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src = "https://kit.fontawesome.com/46b998f154.js" crossorigin = "anonymous"></script>
</head>
<body class="bg-gray-100">
<div class="flex">
  <!-- Side Navigation -->
  <aside class="fixed h-screen bg-blue-50 w-64 shadow-lg z-50">
    <div class="flex items-center justify-center px-4 py-6">
      <div class="flex items-center justify-start w-full">
        <!--  <div class="p-4"> -->
        <img src="../favicon.jpeg" alt="Logo" class="h-10 w-10 mr-3 rounded-lg">
        <h2 class="text-2xl font-bold text-gray-800">Admin Panel</h2>
      </div>
    </div>
    <nav class="mt-4">
      <a href="#dashboard" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-home mr-2"></i> Dashboard
      </a>
      <a href="#create-admin" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-user-plus mr-2"></i> Create New Admin
      </a>
      <a href="#manage-users" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-users mr-2"></i> Manage Users
      </a>
      <a href="#manage-tutors" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-chalkboard-teacher mr-2"></i> Manage Tutors
      </a>
      <a href="#bookings" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-calendar-alt mr-2"></i> Booking System
      </a>
      <a href="#feedback" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
        <i class="fas fa-star mr-2"></i> Feedback & Ratings
      </a>
    </nav>
  </aside>

  <!-- Main Content -->
  <main class="ml-64 flex-1">
    <!-- Top Bar -->
    <header class="fixed w-[calc(100%-16rem)] bg-white shadow-sm py-4 px-6 flex justify-end items-center z-40">
      <div class="flex items-center gap-4">
        <!-- Profile Section -->
        <div class="flex items-center gap-3">
          <img src="../admin.jpg" alt="Profile"
               class="w-10 h-10 rounded-full object-cover border-2 border-gray-200">
          <div>
            <p class="font-medium">Isuru Udana</p>
            <span class="text-sm text-gray-500">Admin</span>
          </div>
        </div>
        <a href="./login.jsp" class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 inline-flex items-center">
          <i class="fas fa-sign-out-alt mr-2"></i>Logout
        </a>
      </div>
    </header>

    <!-- Content Areas -->
    <div class="pt-20 px-6 mt-16">
