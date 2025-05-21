<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/14/2025
  Time: 8:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="./partials/hedder.jsp"%>
<title>Admin List</title>
<%@ include file="./partials/left.jsp"%>

<!-- Dashboard Section -->
<div id="dashboard" class="content-section">
  <div class="flex justify-between items-center mb-6">
    <h1 class="text-2xl font-bold">Dashboard Overview</h1>
  </div>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
    <div class="bg-white p-6 rounded-lg shadow">
      <h3 class="text-lg font-semibold mb-2">Total Tutors</h3>
      <p class="text-3xl font-bold text-blue-500">3</p>
    </div>
    <div class="bg-white p-6 rounded-lg shadow">
      <h3 class="text-lg font-semibold mb-2">Total Users</h3>
      <p class="text-3xl font-bold text-green-500">24</p>
    </div>
    <div class="bg-white p-6 rounded-lg shadow">
      <h3 class="text-lg font-semibold mb-2">Bookings</h3>
      <p class="text-3xl font-bold text-purple-500">2</p>
    </div>
    <div class="bg-white p-6 rounded-lg shadow">
      <h3 class="text-lg font-semibold mb-2">Avg. Rating</h3>
      <p class="text-3xl font-bold text-yellow-500">4.8</p>
    </div>
  </div>

  <!-- Admin Management Table -->
  <div class="mb-8">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold">Admin Management</h2>
      <form class="flex gap-4 items-center" action="${pageContext.request.contextPath}/list" method="get">
        <div class="relative">
          <input type="text"
                 name="search"
                 placeholder="Search by name"
                 class="px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                 value="${param.search}">
          <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
        </div>
        <button type="submit"
                class="px-4 py-2 bg-sky-500 text-white rounded-lg hover:bg-sky-700 transition duration-300">
          Search
        </button>
        <button type="button"
                onclick="window.location.href='${pageContext.request.contextPath}/list'"
                class="px-4 py-2 bg-rose-300 text-gray-700 rounded-lg hover:bg-rose-400 transition duration-300">
          Clear
        </button>
      </form>
    </div>

    <div class="bg-white rounded-lg shadow overflow-x-auto">
      <table class="w-full">
        <thead class="bg-gray-50">
        <tr>
          <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
          <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
          <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
          <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
          <c:if test="${user.role eq 'Admin'}">
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
          </c:if>
        </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
        <c:forEach items="${records}" var="record">
          <tr>
            <td class="px-6 py-4">${record.id}</td>
            <td class="px-6 py-4">${record.name}</td>
            <td class="px-6 py-4">${record.email}</td>
            <td class="px-6 py-4">${record.role}</td>
            <c:if test="${user.role eq 'Admin'}">
              <td class="px-6 py-4">
                <a href="${pageContext.request.contextPath}/edit?id=${record.id}"
                   class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors mr-1">
                  Edit Role
                </a>
                <form action="${pageContext.request.contextPath}/delete" method="post" style="display:inline;">
                  <input type="hidden" name="id" value="${record.id}">
                  <button class="bg-red-500 hover:bg-red-600 text-white px-3 py-1.5 rounded-md text-sm transition-colors"
                          onclick="return confirm('Are you sure you want to delete this record?')">
                    Delete
                  </button>
                </form>
              </td>
            </c:if>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<c:if test="${user.role eq 'Admin'}">

  <%@ include file="add.jsp"%>

</c:if>