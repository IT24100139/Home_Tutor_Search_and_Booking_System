package com.tutorbooking.controller

import com.tutorbooking.model.Booking
import com.tutorbooking.service.BookingManager
import jakarta.servlet.ServletException
import jakarta.servlet.annotation.WebServlet
import jakarta.servlet.http.HttpServlet
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import java.io.IOException
import java.util.UUID

@WebServlet("/delete-booking")
class DeleteBookingServlet : HttpServlet() {
    private lateinit var bookingManager: BookingManager

    override fun init() {
        super.init()
        bookingManager = BookingManager(servletContext)
    }

    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            val id = request.getParameter("id")
            val booking: Booking? = bookingManager.getBookingById(id)

            if (booking == null) {
                response.sendRedirect("view-bookings?error=Booking not found")
                return
            }

            val csrfToken = UUID.randomUUID().toString()
            request.session.setAttribute("csrfToken", csrfToken)
            request.setAttribute("csrfToken", csrfToken)
            request.setAttribute("booking", booking)
            request.getRequestDispatcher("cancel-booking.jsp").forward(request, response)
        } catch (e: Exception) {
            response.sendRedirect("view-bookings?error=Error loading booking: " + e.message)
        }
    }

    @Throws(ServletException::class, IOException::class)
    override fun doPost(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            val submittedToken = request.getParameter("_csrf")
            val sessionToken = request.session.getAttribute("csrfToken") as? String
            if (submittedToken != sessionToken) {
                throw IllegalArgumentException("Invalid CSRF token")
            }

            val id = request.getParameter("id")
            val reason = request.getParameter("reason")

            bookingManager.cancelBooking(id, reason)
            response.sendRedirect("view-bookings?status=cancelled")
        } catch (e: Exception) {
            request.setAttribute("error", "Failed to cancel booking: " + e.message)
            request.getRequestDispatcher("cancel-booking.jsp").forward(request, response)
        }
    }
}