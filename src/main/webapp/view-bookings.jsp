<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking</title>

    <!-- Favicon and Icons -->
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Custom CSS for status badges -->
    <style>
        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-block;
        }
        .status-pending-confirmation { background-color: #FEF3C7; color: #92400E; }
        .status-confirmed { background-color: #D1FAE5; color: #065F46; }
        .status-cancelled { background-color: #FEE2E2; color: #991B1B; }
        .status-completed { background-color: #E0E7FF; color: #3730A3; }
        .status-rescheduled { background-color: #FCE7F3; color: #9D174D; }
    </style>
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

    <!-- Mobile Sidebar Toggle -->
    <button class="md:hidden p-4 bg-blue-500 text-white fixed top-0 left-0 z-50" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Main Content -->
    <main class="md:ml-64 flex-1">

        <!-- Header (User Profile & Logout) -->
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

        <div class="pt-20 px-6 mt-5">

            <!-- Notifications -->
            <c:if test="${not empty success}">
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">${success}</div>
            </c:if>
            <c:if test="${not empty info}">
                <div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-4">${info}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
            </c:if>

            <!-- New Booking Button -->
            <div class="mb-6">
                <a href="create-booking" class="block w-full bg-blue-500 text-white text-center py-3 rounded-lg hover:bg-blue-600">
                    <i class="fas fa-plus mr-2"></i> New Booking
                </a>
            </div>

            <!-- Upcoming Bookings Section -->
            <h2 class="text-2xl font-bold text-blue-900 mb-6">Upcoming Sessions</h2>
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty upcomingBookings}">
                        <div class="bg-white p-6 rounded-lg shadow text-center text-gray-500">No upcoming sessions found</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${upcomingBookings}" var="booking">
                            <div class="bg-white p-6 rounded-lg shadow">

                                <!-- Subject and Tutor + Status Badge -->
                                <div class="flex justify-between items-start mb-4">
                                    <div>
                                        <h3 class="text-xl font-semibold">${booking.subject}</h3>
                                        <p class="text-gray-600">${booking.tutor}</p>
                                    </div>
                                    <span class="status-badge status-${fn:replace(fn:toLowerCase(booking.status), ' ', '-')}">
                                            ${booking.status}
                                    </span>
                                </div>

                                <!-- Booking Details -->
                                <div class="grid grid-cols-1 md:grid-cols-5 gap-4 mb-4 text-sm">
                                    <div><p class="text-gray-500">Date</p><p class="font-medium">${booking.date}</p></div>
                                    <div><p class="text-gray-500">Time</p><p class="font-medium">${booking.time}</p></div>
                                    <div><p class="text-gray-500">Duration</p><p class="font-medium">${booking.duration}</p></div>
                                    <div><p class="text-gray-500">Type</p><p class="font-medium">${booking.sessionType}</p></div>
                                    <div><p class="text-gray-500">Booking ID</p><p class="font-medium">${booking.bookingId}</p></div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="flex space-x-2">
                                    <c:if test="${booking.status != 'Cancelled' && booking.status != 'Completed'}">
                                        <a href="update-booking?id=${booking.bookingId}" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                                            <i class="fas fa-edit mr-1"></i> Reschedule
                                        </a>
                                        <a href="delete-booking?id=${booking.bookingId}" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
                                            <i class="fas fa-times mr-1"></i> Cancel
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Completed Bookings Section -->
            <h2 class="text-2xl font-bold text-blue-900 mt-10 mb-6">Completed Sessions</h2>
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty completedBookings}">
                        <div class="bg-white p-6 rounded-lg shadow text-center text-gray-500">No completed sessions found</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${completedBookings}" var="booking">
                            <div class="bg-white p-6 rounded-lg shadow">
                                <div class="flex justify-between items-start mb-4">
                                    <div>
                                        <h3 class="text-xl font-semibold">${booking.subject}</h3>
                                        <p class="text-gray-600">${booking.tutor}</p>
                                    </div>
                                    <span class="status-badge status-${fn:replace(fn:toLowerCase(booking.status), ' ', '-')}">
                                            ${booking.status}
                                    </span>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-5 gap-4 mb-4 text-sm">
                                    <div><p class="text-gray-500">Date</p><p class="font-medium">${booking.date}</p></div>
                                    <div><p class="text-gray-500">Time</p><p class="font-medium">${booking.time}</p></div>
                                    <div><p class="text-gray-500">Duration</p><p class="font-medium">${booking.duration}</p></div>
                                    <div><p class="text-gray-500">Type</p><p class="font-medium">${booking.sessionType}</p></div>
                                    <div><p class="text-gray-500">Booking ID</p><p class="font-medium">${booking.bookingId}</p></div>
                                </div>

                                <!-- Cancellation Reason (if applicable) -->
                                <c:if test="${booking.status == 'Cancelled' && not empty booking.cancellationReason}">
                                    <div class="mt-2">
                                        <p class="text-sm text-gray-500">Cancellation Reason</p>
                                        <p class="text-red-500">${booking.cancellationReason}</p>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
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

<!-- Sidebar Toggle Script -->
<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('hidden');
    }
</script>
</body>
</html>
