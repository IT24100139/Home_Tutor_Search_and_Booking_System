<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/14/2025
  Time: 8:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div id="create-admin" class="content-section">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold">Add New Admin</h1>
    </div>

    <div class="bg-white p-8 rounded-lg shadow-lg max-w-2xl mx-4">
        <form action="${pageContext.request.contextPath}/add" method="post">
            <div class="space-y-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                    <div class="relative">
                        <input type="text"
                               name="name"
                               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="Enter full name"
                               required>
                        <i class="fas fa-user absolute right-3 top-3 text-gray-400"></i>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                    <div class="relative">
                        <input type="email"
                               name="email"
                               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="Enter email address"
                               required>
                        <i class="fas fa-envelope absolute right-3 top-3 text-gray-400"></i>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                    <div class="relative">
                        <input type="password"
                               name="password"
                               class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="Enter password"
                               required>
                        <i class="fas fa-lock absolute right-3 top-3 text-gray-400"></i>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
                    <select name="role"
                            class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required>
                        <option value="Admin">Admin</option>
                        <option value="Editor">Editor</option>
                    </select>
                </div>

                <div class="flex items-center gap-4 mt-8">
                    <button type="submit"
                            class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        <i class="fas fa-save mr-2"></i>Save
                    </button>
                    <a href="${pageContext.request.contextPath}/list"
                       class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300 transition duration-300">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="./partials/bottom.jsp"%>