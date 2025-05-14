<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reschedule Booking</title>
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
            <div class="bg-white p-6 rounded-lg shadow max-w-2xl mx-auto">
                <h2 class="text-2xl font-bold text-center mb-6">Reschedule Booking</h2>

                <c:if test="${not empty error}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                            ${error}
                    </div>
                </c:if>

                <form action="update-booking" method="post" class="space-y-6" onsubmit="return validateForm()">
                    <input type="hidden" name="_csrf" value="${csrfToken}">
                    <input type="hidden" name="id" value="${booking.bookingId}">

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                        <select name="subject" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="Advanced Calculus Session" ${booking.subject == 'Advanced Calculus Session' ? 'selected' : ''}>Advanced Calculus Session</option>
                            <option value="Chemistry Lab Practice" ${booking.subject == 'Chemistry Lab Practice' ? 'selected' : ''}>Chemistry Lab Practice</option>
                            <option value="Basic Algebra Review" ${booking.subject == 'Basic Algebra Review' ? 'selected' : ''}>Basic Algebra Review</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tutor</label>
                        <select name="tutor" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="Dr. Sarah Wilson" ${booking.tutor == 'Dr. Sarah Wilson' ? 'selected' : ''}>Dr. Sarah Wilson</option>
                            <option value="Prof. Kelum Senanayaka" ${booking.tutor == 'Prof. Kelum Senanayaka' ? 'selected' : ''}>Prof. Kelum Senanayaka</option>
                            <option value="Dr. Amith Pussalla" ${booking.tutor == 'Dr. Amith Pussalla' ? 'selected' : ''}>Dr. Amith Pussalla</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date</label>
                        <input type="date" name="date" value="${booking.date}" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Time</label>
                        <input type="time" name="time" value="${booking.time}" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Duration</label>
                        <select name="duration" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="30 Minutes" ${booking.duration == '30 Minutes' ? 'selected' : ''}>30 Minutes</option>
                            <option value="1 Hour" ${booking.duration == '1 Hour' ? 'selected' : ''}>1 Hour</option>
                            <option value="1.5 Hours" ${booking.duration == '1.5 Hours' ? 'selected' : ''}>1.5 Hours</option>
                            <option value="2 Hours" ${booking.duration == '2 Hours' ? 'selected' : ''}>2 Hours</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Session Type</label>
                        <select name="sessionType" class="w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="Trial" ${booking.sessionType == 'Trial' ? 'selected' : ''}>Trial</option>
                            <option value="Regular" ${booking.sessionType == 'Regular' ? 'selected' : ''}>Regular</option>
                            <option value="Premium" ${booking.sessionType == 'Premium' ? 'selected' : ''}>Premium</option>
                        </select>
                    </div>

                    <div class="flex space-x-4">
                        <button type="submit" class="flex-1 bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600">
                            <i class="fas fa-save mr-2"></i>Save Changes
                        </button>
                        <a href="view-bookings" class="flex-1 bg-gray-500 text-white py-3 rounded-lg hover:bg-gray-600 text-center">
                            <i class="fas fa-arrow-left mr-2"></i>Cancel
                        </a>
                    </div>
                </form>
                <script>
                    function validateForm() {
                        const date = document.querySelector('input[name="date"]').value;
                        const time = document.querySelector('input[name="time"]').value;
                        const today = new Date().toISOString().split('T')[0];
                        if (date < today) {
                            alert('Date cannot be in the past');
                            return false;
                        }
                        if (!time) {
                            alert('Please select a valid time');
                            return false;
                        }
                        return true;
                    }
                </script>
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