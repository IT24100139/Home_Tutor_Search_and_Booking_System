<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/14/2025
  Time: 5:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="./partials/hedder.jsp"%>
<title>Edit Role</title>
<%@ include file="./partials/left.jsp"%>

<div class="content-section">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold">Edit Admin Role</h1>
    </div>

    <div class="bg-white p-8 rounded-lg shadow-lg max-w-2xl mx-4">
        <form action="${pageContext.request.contextPath}/edit" method="post">
            <input type="hidden" name="id" value="${record.id}">

            <div class="space-y-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Current Role</label>
                    <div class="w-full px-4 py-2 bg-gray-100 rounded-lg">
                        ${record.role}
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">New Role</label>
                    <select name="role"
                            class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="Admin" ${record.role == 'Admin' ? 'selected' : ''}>Admin</option>
                        <option value="Editor" ${record.role == 'Editor' ? 'selected' : ''}>Editor</option>
                    </select>
                </div>

                <div class="flex items-center gap-4 mt-8">
                    <button type="submit"
                            class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition duration-300">
                        Update Role
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