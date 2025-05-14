<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Booking</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon">
    <link rel="shortcut icon" href="favicon.ico?v=2">
    <link rel="apple-touch-icon" href="favicon.jpeg">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="flex">
    <!-- Side Navigation -->
    <aside class="fixed h-screen bg-blue-50 w-64 shadow-lg z-50">
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
    <main class="ml-64 flex-1">
        <header class="fixed w-[calc(100%-16rem)] bg-white shadow-sm py-4 px-6 flex justify-end items-center z-40">
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
            <div class="max-w-md mx-auto bg-white p-8 rounded-lg shadow">
                <h1 class="text-2xl font-bold text-center mb-8">New Booking</h1>

                <c:if test="${not empty error}">
                    <div class="bg-red-100 border border-red-400 text-Red-700 px-4 py-3 rounded mb-4">
                            ${error}
                    </div>
                </c:if>

                <form action="create-booking" method="post" class="space-y-6" onsubmit="return validateForm()">
                    <!-- Subject Selection -->
                    <div>
                        <h2 class="text-lg font-semibold mb-3">Select Subject</h2>
                        <select name="subject" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="">Choose Subject</option>
                            <option value="Advanced Calculus Session">Advanced Calculus Session</option>
                            <option value="Chemistry Lab Practice">Chemistry Lab Practice</option>
                            <option value="Basic Algebra Review">Basic Algebra Review</option>
                        </select>
                    </div>

                    <!-- Tutor Selection -->
                    <div>
                        <h2 class="text-lg font-semibold mb-3">Select Tutor</h2>
                        <select name="tutor" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="">Choose Tutor</option>
                            <option value="Dr. Sarah Wilson">Dr. Sarah Wilson</option>
                            <option value="Prof. Kelum Senanayaka">Prof. Kelum Senanayaka</option>
                            <option value="Dr. Amith Pussalla">Dr. Amith Pussalla</option>
                        </select>
                    </div>

                    <!-- Date and Time -->
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <h2 class="text-lg font-semibold mb-3">Date</h2>
                            <input type="date" name="date" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        </div>
                        <div>
                            <h2 class="text-lg font-semibold mb-3">Time</h2>
                            <input type="time" name="time" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        </div>
                    </div>

                    <!-- Duration -->
                    <div>
                        <h2 class="text-lg font-semibold mb-3">Duration</h2>
                        <select name="duration" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="">Select Duration</option>
                            <option value="30 Minutes">30 Minutes</option>
                            <option value="1 Hour">1 Hour</option>
                            <option value="1.5 Hours">1.5 Hours</option>
                            <option value="2 Hours">2 Hours</option>
                        </select>
                    </div>

                    <!-- Session Type -->
                    <div>
                        <h2 class="text-lg font-semibold mb-3">Session Type</h2>
                        <select name="sessionType" class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            <option value="">Choose Session Type</option>
                            <option value="Trial">Trial</option>
                            <option value="Regular">Regular</option>
                            <option value="Premium">Premium</option>
                        </select>
                    </div>

                    <!-- Confirm Button -->
                    <button type="submit" class="w-full bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 transition-colors mt-8">
                        Confirm Booking
                    </button>
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
</body>
</html>