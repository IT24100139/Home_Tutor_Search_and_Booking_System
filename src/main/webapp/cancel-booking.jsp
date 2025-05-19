<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cancel Booking</title>
    <!-- Tailwind and FontAwesome -->
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="flex">

    <!-- Sidebar Navigation -->
    <aside class="fixed h-screen bg-blue-50 w-64 shadow-lg z-50 md:block hidden" id="sidebar">
        <div class="flex items-center justify-center px-4 py-6">
            <img src="favicon.jpeg" class="h-10 w-10 mr-3 rounded-lg" />
            <h2 class="text-xl font-bold text-gray-800">Zentutor.lk</h2>
        </div>
        <nav class="mt-4">
            <a href="dashboard.html" class="block p-4 text-gray-700 hover:bg-blue-100"><i class="fas fa-home mr-2"></i>Dashboard</a>
            <a href="user-profile.html" class="block p-4 text-gray-700 hover:bg-blue-100"><i class="fa-solid fa-user mr-2"></i>User Profile</a>
            <a href="view-bookings" class="block p-4 text-gray-700 hover:bg-blue-100"><i class="fas fa-calendar-alt mr-2"></i>Booking</a>
            <a href="feedback.html" class="block p-4 text-gray-700 hover:bg-blue-100"><i class="fas fa-star mr-2"></i>Feedback</a>
        </nav>
    </aside>

    <!-- Toggle for Mobile Sidebar -->
    <button class="md:hidden p-4 bg-blue-500 text-white fixed top-0 left-0 z-50" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Main Content Area -->
    <main class="md:ml-64 flex-1">
        <!-- Top User Info Bar -->
        <header class="fixed w-full md:w-[calc(100%-16rem)] bg-white shadow-sm py-4 px-6 flex justify-end items-center z-40">
            <div class="flex items-center gap-4">
                <img src="user.jpg" class="w-10 h-10 rounded-full object-cover border-2 border-gray-200" />
                <div>
                    <p class="font-medium">Rasiru Chathusara</p>
                    <span class="text-sm text-gray-500">User</span>
                </div>
                <button class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </button>
            </div>
        </header>

        <!-- Page Content -->
        <div class="pt-20 px-6 mt-5">
            <div class="bg-white p-6 rounded-lg shadow max-w-2xl mx-auto">
                <h2 class="text-2xl font-bold text-center mb-6">Cancel Booking</h2>

                <!-- Error Alert (from servlet) -->
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                            ${error}
                    </div>
                </c:if>

                <!-- Booking Details Section -->
                <div class="mb-6 text-gray-700">
                    <h3 class="text-xl font-semibold mb-2">${booking.subject}</h3>
                    <p class="mb-2">${booking.tutor}</p>
                    <p><strong>Date:</strong> ${booking.date}</p>
                    <p><strong>Time:</strong> ${booking.time}</p>
                    <p><strong>Duration:</strong> ${booking.duration}</p>
                </div>

                <!-- Cancel Booking Form -->
                <form action="delete-booking" method="post" class="space-y-6">
                    <!-- CSRF Token for protection -->
                    <input type="hidden" name="_csrf" value="${csrfToken}">
                    <!-- Booking ID to identify which booking to cancel -->
                    <input type="hidden" name="id" value="${booking.bookingId}">

                    <!-- Cancellation Reason Textarea -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Reason for Cancellation</label>
                        <textarea name="reason" rows="4" required class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex space-x-4">
                        <button type="submit" class="flex-1 bg-red-500 text-white py-3 rounded-lg hover:bg-red-600">
                            <i class="fas fa-trash mr-2"></i> Confirm Cancellation
                        </button>
                        <a href="view-bookings" class="flex-1 bg-gray-500 text-white py-3 rounded-lg hover:bg-gray-600 text-center">
                            <i class="fas fa-arrow-left mr-2"></i> Back
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<!-- Footer -->
<footer class="mt-8 border-t bg-white">
    <div class="container mx-auto px-6 py-4 text-center text-gray-600">
        <p>© 2025 Zentutor.lk. All rights reserved.</p>
    </div>
</footer>

<!-- JavaScript to toggle mobile sidebar -->
<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('hidden');
    }
</script>
</body>
</html>

