<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.tutorbooking.service.BookingManager" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon">
    <link rel="shortcut icon" href="favicon.ico?v=2">
    <link rel="apple-touch-icon" href="favicon.jpeg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="flex">
    <!-- Side Navigation -->
    <aside class="fixed h-screen bg-blue-50 w-64 shadow-lg z-50 md:block hidden" id="sidebar">
        <div class="flex items-center justify-center px-4 py-6">
            <div class="flex items-center justify-start w-full">
                <img src="favicon.jpeg" alt="Logo" class="h-10 w-10 mr-3 rounded-lg">
                <h2 class="text-xl font-bold text-gray-800">Zentutor.lk</h2>
            </div>
        </div>
        <nav class="mt-4">
            <a href="dashboard.html" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
                <i class="fas fa-home mr-2"></i> Dashboard
            </a>
            <a href="user-profile.html" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
                <i class="fa-solid fa-user mr-2"></i> User Profile
            </a>
            <a href="view-bookings" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
                <i class="fas fa-calendar-alt mr-2"></i> Booking
            </a>
            <a href="feedback.html" class="block p-4 text-gray-700 hover:bg-blue-100 nav-link">
                <i class="fas fa-star mr-2"></i> Feedback
            </a>
        </nav>
    </aside>
    <button class="md:hidden p-4 bg-blue-500 text-white fixed top-0 left-0 z-50" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
    <main class="md:ml-64 flex-1">
        <header class="fixed w-full md:w-[calc(100%-16rem)] bg-white shadow-sm py-4 px-6 flex justify-end items-center z-40">
            <div class="flex items-center gap-4">
                <div class="flex items-center gap-3">
                    <img src="user.jpg" alt="Profile" class="w-10 h-10 rounded-full object-cover border-2 border-gray-200">
                    <div>
                        <p class="font-medium">Rasiru Chathusara</p>
                        <span class="text-sm text-gray-500">User</span>
                    </div>
                </div>
                <button class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </button>
            </div>
        </header>
        <div class="pt-20 px-6 mt-5">
            <c:if test="${not empty success}">
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                        ${success}
                </div>
            </c:if>
            <c:if test="${not empty info}">
                <div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-4">
                        ${info}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                        ${error}
                </div>
            </c:if>

            <div class="mb-6">
                <a href="book-tutor.jsp" class="block w-full bg-blue-500 text-white text-center py-3 rounded-lg hover:bg-blue-600">
                    <i class="fas fa-plus mr-2"></i>New Booking
                </a>
            </div>

            <h2 class="text-2xl font-bold text-blue-900 mb-6">Upcoming Sessions</h2>
            <div class="space-y-4">
                <c:forEach items="${upcomingBookings}" var="booking">
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h3 class="text-xl font-semibold mb-2">${booking.subject}</h3>
                        <p class="text-gray-600 mb-4">${booking.tutor}</p>

                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                <tr class="border-b">
                                    <th class="text-left py-2">Date</th>
                                    <th class="text-left py-2">Time</th>
                                    <th class="text-left py-2">Duration</th>
                                    <th class="text-left py-2">Status</th>
                                    <th class="text-left py-2">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="py-3">${booking.date}</td>
                                    <td class="py-3">${booking.time}</td>
                                    <td class="py-3">${booking.duration}</td>
                                    <td class="py-3">
                                        <span class="px-2 py-1 rounded
                                            ${booking.status == 'Confirmed' ? 'bg-green-100 text-green-800' :
                                              booking.status == 'Pending Confirmation' ? 'bg-yellow-100 text-yellow-800' :
                                              'bg-red-100 text-red-800'}">
                                                ${booking.status}
                                        </span>
                                    </td>
                                    <td class="py-3">
                                        <a href="update-booking?id=${booking.bookingId}"
                                           class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">
                                            Reschedule
                                        </a>
                                        <a href="delete-booking?id=${booking.bookingId}"
                                           class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 ml-2">
                                            Cancel
                                        </a>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="mt-8">
                <h2 class="text-2xl font-bold text-blue-900 mb-6">Completed Sessions</h2>
                <div class="bg-white p-6 rounded-lg shadow">
                    <ul class="space-y-3">
                        <c:forEach items="${completedBookings}" var="booking">
                            <li class="border-b pb-3">
                                <h4 class="font-semibold">${booking.subject}</h4>
                                <p class="text-gray-600">
                                        ${booking.date} | ${booking.time} | ${booking.duration}
                                    <c:if test="${booking.status == 'Cancelled'}">
                                        <span class="text-red-500 ml-2">(Cancelled: ${booking.cancellationReason})</span>
                                    </c:if>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </main>
</div>
<footer class="mt-8 border-t bg-white">
    <div class="container mx-auto px-6 py-4 text-center text-gray-600">
        <p>© 2025 Zentutor.lk. All rights reserved.</p>
    </div>
</footer>
<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('hidden');
    }
</script>
</body>
</html>