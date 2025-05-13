<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/10/2025
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="./partials/hedder.jsp"%>

    <title>Admin Dashboard</title>

<%@ include file="./partials/left.jsp"%>


            <!-- Dashboard Section -->
            <div id="dashboard" class="content-section">
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold">Dashboard Overview</h1>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h3 class="text-lg font-semibold mb-2">Total Tutors</h3>
                        <p class="text-3xl font-bold text-blue-500">5</p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h3 class="text-lg font-semibold mb-2">Total Users</h3>
                        <p class="text-3xl font-bold text-green-500">265</p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h3 class="text-lg font-semibold mb-2">Bookings</h3>
                        <p class="text-3xl font-bold text-purple-500">35</p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h3 class="text-lg font-semibold mb-2">Avg. Rating</h3>
                        <p class="text-3xl font-bold text-yellow-500">4.8</p>
                    </div>
                </div>
                <!-- New Admin Management Table -->
                <div class="mb-8">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold">Admin Management</h2>
                    </div>

                    <div class="bg-white rounded-lg shadow overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Admin ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                            <tr>
                                <td class="px-6 py-4">Isuru Udana</td>
                                <td class="px-6 py-4">1234</td>
                                <td class="px-6 py-4">Admin</td>
                                <td class="px-6 py-4">
                                    <a href="EditAdmin.jsp?id=1234" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors mr-1">
                                        Edit
                                    </a>

                                    <button
                                            class="bg-red-500 hover:bg-red-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors"
                                            onclick="deleteAdmin(this)">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                            <tbody class="divide-y divide-gray-200">
                            <tr>
                                <td class="px-6 py-4">Yasith Gawrawa</td>
                                <td class="px-6 py-4">6789</td>
                                <td class="px-6 py-4">Editor</td>
                                <td class="px-6 py-4">
                                    <a href="EditAdmin.jsp?id=1234" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors mr-1">
                                        Edit
                                    </a>

                                    <button
                                            class="bg-red-500 hover:bg-red-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors"
                                            onclick="deleteAdmin(this)">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <!-- Manage Users Section -->

            <!-- Manage Tutors Section -->

            <!-- Booking System Section -->

            <!-- Feedback Section -->
<%@ include file="ManageAdminCreate.jsp"%>