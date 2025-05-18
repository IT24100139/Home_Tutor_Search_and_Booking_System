<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book a Tutor</title>
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

    <!-- Toggle Sidebar for Mobile -->
    <button class="md:hidden p-4 bg-blue-500 text-white fixed top-0 left-0 z-50" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Main Content -->
    <main class="md:ml-64 flex-1">
        <!-- Header Section -->
        <header class="fixed w-full md:w-[calc(100%-16rem)] bg-white shadow-sm py-4 px-6 flex justify-end items-center z-40">
            <div class="flex items-center gap-4">
                <img src="user.jpg" alt="Profile" class="w-10 h-10 rounded-full object-cover border-2 border-gray-200">
                <div>
                    <p class="font-medium">Rasiru Chathusara</p>
                    <span class="text-sm text-gray-500">User</span>
                </div>
                <button class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </button>
            </div>
        </header>

        <!-- Booking Form -->
        <div class="pt-20 px-6 mt-5">
            <div class="bg-white p-6 rounded-lg shadow max-w-2xl mx-auto">
                <h2 class="text-2xl font-bold text-center mb-6">Book a Tutor</h2>

                <!-- Error Alert (if any) -->
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6">
                        <p class="font-bold">Error:</p>
                        <p>${error}</p>
                    </div>
                </c:if>

                <!-- Booking Form -->
                <form action="create-booking" method="post" class="space-y-6">
                    <!-- ✅ CSRF token included from servlet -->
                    <input type="hidden" name="_csrf" value="${csrfToken}" />

                    <!-- Subject Dropdown -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                        <select name="subject" id="subject" class="w-full px-4 py-3 border rounded-lg" required onchange="updateTutors()">
                            <option value="">Choose Subject</option>
                            <option value="Combined Maths">Combined Maths</option>
                            <option value="Biology">Biology</option>
                            <option value="Physics">Physics</option>
                            <option value="Chemistry">Chemistry</option>
                        </select>
                    </div>

                    <!-- Tutor Dropdown (populated by JavaScript) -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tutor</label>
                        <select name="tutor" id="tutor" class="w-full px-4 py-3 border rounded-lg" required>
                            <option value="">Choose Tutor</option>
                        </select>
                    </div>

                    <!-- Date Field -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Date</label>
                        <input type="date" name="date" class="w-full px-4 py-3 border rounded-lg" required>
                    </div>

                    <!-- Time Field -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Time</label>
                        <input type="time" name="time" class="w-full px-4 py-3 border rounded-lg" required>
                    </div>

                    <!-- Duration Dropdown -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Duration</label>
                        <select name="duration" id="duration" class="w-full px-4 py-3 border rounded-lg" required onchange="updateSessionType()">
                            <option value="">Select Duration</option>
                            <option value="30 Minutes">30 Minutes</option>
                            <option value="1 Hour">1 Hour</option>
                            <option value="1.5 Hours">1.5 Hours</option>
                            <option value="2 Hours">2 Hours</option>
                        </select>
                    </div>

                    <!-- Session Type (auto-updated based on duration) -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Session Type</label>
                        <select name="sessionType" id="sessionType" class="w-full px-4 py-3 border rounded-lg" required>
                            <option value="">Select Session Type</option>
                            <option value="Trial">Trial</option>
                            <option value="Regular">Regular</option>
                            <option value="Premium">Premium</option>
                        </select>
                    </div>

                    <!-- Form Buttons -->
                    <div class="flex space-x-4">
                        <button type="submit" class="flex-1 bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600">
                            <i class="fas fa-book mr-2"></i> Book Now
                        </button>
                        <a href="view-bookings" class="flex-1 bg-gray-500 text-white py-3 rounded-lg hover:bg-gray-600 text-center">
                            <i class="fas fa-arrow-left mr-2"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<!-- JavaScript Section -->
<script>
    // Subject-tutor mapping
    const tutorMap = {
        "Combined Maths": ["Dr. Sarah Wilson", "Prof. Kelum Senanayaka"],
        "Biology": ["Dr. Amith Pussalla", "Dr. Nimali Perera"],
        "Physics": ["Prof. Ravi Fernando", "Dr. Lakmal Wijesinghe"],
        "Chemistry": ["Dr. Priya Mendis", "Prof. Anura Jayasinghe"]
    };

    // Update tutor dropdown based on selected subject
    function updateTutors() {
        const subject = document.getElementById("subject").value;
        const tutorSelect = document.getElementById("tutor");
        tutorSelect.innerHTML = '<option value="">Choose Tutor</option>';
        if (tutorMap[subject]) {
            tutorMap[subject].forEach(tutor => {
                const option = document.createElement("option");
                option.value = tutor;
                option.text = tutor;
                tutorSelect.appendChild(option);
            });
        }
    }

    // Automatically adjust session type based on duration
    function updateSessionType() {
        const duration = document.getElementById("duration").value;
        const sessionType = document.getElementById("sessionType");
        if (duration === "30 Minutes") sessionType.value = "Trial";
        else if (duration === "2 Hours") sessionType.value = "Premium";
        else sessionType.value = "Regular";
    }

    // Sidebar toggling for mobile
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('hidden');
    }
</script>
</body>
</html>

