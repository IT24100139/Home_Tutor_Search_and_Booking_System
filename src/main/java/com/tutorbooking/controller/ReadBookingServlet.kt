package com.tutorbooking.controller

import com.tutorbooking.model.Booking
import com.tutorbooking.service.BookingManager
import jakarta.servlet.ServletException
import jakarta.servlet.annotation.WebServlet
import jakarta.servlet.http.HttpServlet
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import java.io.IOException
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.stream.Collectors

@WebServlet("/view-bookings")
class ReadBookingServlet : HttpServlet() {

    private var bookingManager: BookingManager? = null

    // Called once when the servlet is initialized
    override fun init() {
        bookingManager = BookingManager(servletContext)
    }

    // GET: View all bookings
    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            // Step 1: Auto-update expired bookings to "Completed"
            updateBookingStatuses()

            val allBookings = bookingManager!!.allBookings
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
            val now = LocalDateTime.now()

            // Step 2: Filter and sort UPCOMING bookings
            val upcoming = allBookings.stream()
                .filter { b: Booking ->
                    try {
                        val bookingTime = LocalDateTime.parse("${b.date} ${b.time}", formatter)
                        return@filter (
                                (b.status == "Pending Confirmation" || b.status == "Confirmed")
                                        && bookingTime.isAfter(now)
                                )
                    } catch (e: Exception) {
                        System.err.println("Parse error (upcoming): " + e.message)
                        return@filter false
                    }
                }
                .sorted(
                    Comparator
                        .comparing { obj: Booking -> obj.date }
                        .thenComparing { obj: Booking -> obj.time }
                )
                .collect(Collectors.toList())

            // Step 3: Filter and sort COMPLETED + CANCELLED + past bookings
            val completed = allBookings.stream()
                .filter { b: Booking ->
                    try {
                        val bookingTime = LocalDateTime.parse("${b.date} ${b.time}", formatter)
                        return@filter (
                                b.status == "Completed"
                                        || b.status == "Cancelled"
                                        || bookingTime.isBefore(now)
                                )
                    } catch (e: Exception) {
                        System.err.println("Parse error (completed): " + e.message)
                        return@filter false
                    }
                }
                .sorted(
                    Comparator
                        .comparing { obj: Booking -> obj.date }
                        .thenComparing { obj: Booking -> obj.time }
                        .reversed()
                )
                .collect(Collectors.toList())

            // Step 4: Send both lists to the JSP
            request.setAttribute("upcomingBookings", upcoming)
            request.setAttribute("completedBookings", completed)

            // Step 5: Flash messages based on ?status
            val status = request.getParameter("status")
            if (status != null) {
                when (status) {
                    "created" -> request.setAttribute("success", "Booking created successfully!")
                    "updated" -> request.setAttribute("success", "Booking updated successfully!")
                    "cancelled" -> request.setAttribute("info", "Booking cancelled successfully.")
                }
            }

            // Final step: forward to JSP
            request.getRequestDispatcher("view-bookings.jsp").forward(request, response)

        } catch (e: Exception) {
            System.err.println("Error loading bookings: " + e.message)
            request.setAttribute("error", "Failed to load bookings.")
            request.getRequestDispatcher("view-bookings.jsp").forward(request, response)
        }
    }

    // Internal utility: Update booking status
    private fun updateBookingStatuses() {
        try {
            val bookings = bookingManager!!.allBookings
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
            val now = LocalDateTime.now()
            var hasChanges = false

            for (booking in bookings) {
                try {
                    val bookingTime = LocalDateTime.parse("${booking.date} ${booking.time}", formatter)
                    if ((booking.status == "Pending Confirmation" || booking.status == "Confirmed")
                        && bookingTime.isBefore(now)
                    ) {
                        booking.status = "Completed"
                        hasChanges = true
                    }
                } catch (e: Exception) {
                    System.err.println("Invalid booking format: ${e.message}")
                }
            }

            // Save changes only if any statuses were updated
            if (hasChanges) {
                bookingManager!!.saveAllBookings(bookings)
            }

        } catch (e: IOException) {
            System.err.println("Error auto-updating statuses: ${e.message}")
        }
    }
}