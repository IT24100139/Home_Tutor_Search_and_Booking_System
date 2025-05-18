package com.tutorbooking.controller

import com.tutorbooking.model.Booking
import com.tutorbooking.service.BookingManager
import jakarta.servlet.ServletException
import jakarta.servlet.annotation.WebServlet
import jakarta.servlet.http.HttpServlet
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import java.io.IOException
import java.util.*

@WebServlet("/delete-booking")
class DeleteBookingServlet : HttpServlet() {

    private var bookingManager: BookingManager? = null

    // Initialize BookingManager instance
    override fun init() {
        bookingManager = BookingManager(servletContext)
    }

    // GET: Show cancellation form
    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            // Fetch booking ID from query string
            val bookingId = request.getParameter("id")
            val booking = bookingManager!!.getBookingById(bookingId)

            // If no booking found, redirect with error
            if (booking == null) {
                response.sendRedirect("view-bookings?error=Booking not found")
                return
            }

            // Generate CSRF token and save in session
            val csrfToken = UUID.randomUUID().toString()
            request.session.setAttribute("csrfToken", csrfToken)

            // Prevent caching of this sensitive form
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate")
            response.setHeader("Pragma", "no-cache")
            response.setDateHeader("Expires", 0)

            // Pass data to JSP
            request.setAttribute("csrfToken", csrfToken)
            request.setAttribute("booking", booking)
            request.getRequestDispatcher("cancel-booking.jsp").forward(request, response)

        } catch (e: Exception) {
            // Log error and redirect with generic message
            System.err.println("Error in DeleteBookingServlet (GET): " + e.message)
            response.sendRedirect("view-bookings?error=Unable to load cancellation page")
        }
    }

    // POST: Cancel the booking
    @Throws(ServletException::class, IOException::class)
    override fun doPost(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            // Validate CSRF token
            val submittedToken = request.getParameter("_csrf")
            val sessionToken = request.session.getAttribute("csrfToken") as String

            if (submittedToken == null || sessionToken == null || submittedToken != sessionToken) {
                throw SecurityException("Invalid or missing CSRF token")
            }

            // Invalidate CSRF token after use
            request.session.removeAttribute("csrfToken")

            // Get form data
            val id = request.getParameter("id")
            val reason = request.getParameter("reason")

            // Validate that a cancellation reason was given
            require(!(id == null || reason == null || reason.trim().isEmpty())) {
                "Reason for cancellation is required."
            }

            // Perform the cancellation
            bookingManager!!.cancelBooking(id, reason.trim())

            // Redirect to booking list with success status
            response.sendRedirect("view-bookings?status=cancelled")

        } catch (e: Exception) {
            // In case of any error, reload the cancel form with error message
            val csrfToken = UUID.randomUUID().toString()
            request.session.setAttribute("csrfToken", csrfToken)
            request.setAttribute("csrfToken", csrfToken)
            request.setAttribute("error", "Failed to cancel booking: ${e.message}")

            var booking: Booking? = null
            try {
                // Try to fetch booking again to re-show in form
                booking = bookingManager!!.getBookingById(request.getParameter("id"))
            } catch (_: IOException) {}

            request.setAttribute("booking", booking)
            request.getRequestDispatcher("cancel-booking.jsp").forward(request, response)
        }
    }
}
