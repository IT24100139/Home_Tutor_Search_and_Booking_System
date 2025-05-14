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
import java.util.Comparator
import java.util.stream.Collectors

@WebServlet("/view-bookings")
class ReadBookingServlet : HttpServlet() {
    private lateinit var bookingManager: BookingManager

    override fun init() {
        super.init()
        bookingManager = BookingManager(servletContext)
    }

    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            updateBookingStatuses()

            val allBookings: List<Booking> = bookingManager.getAllBookings()
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
            val now = LocalDateTime.now()

            val upcoming = allBookings.stream()
                .filter { b ->
                    val bookingTime = LocalDateTime.parse("${b.getDate()} ${b.getTime()}", formatter)
                    (b.status == "Confirmed" || b.status == "Pending Confirmation") && bookingTime.isAfter(now)
                }
                .sorted(
                    Comparator.comparing(Booking::getDate)
                        .thenComparing(Booking::getTime)
                )
                .collect(Collectors.toList())

            val completed = allBookings.stream()
                .filter { b ->
                    val bookingTime = LocalDateTime.parse("${b.getDate()} ${b.getTime()}", formatter)
                    b.status == "Completed" || (b.status == "Cancelled" && bookingTime.isBefore(now))
                }
                .sorted(
                    Comparator.comparing(Booking::getDate)
                        .thenComparing(Booking::getTime)
                        .reversed()
                )
                .collect(Collectors.toList())

            request.setAttribute("upcomingBookings", upcoming)
            request.setAttribute("completedBookings", completed)

            request.getParameter("status")?.let { status ->
                when (status) {
                    "created" -> request.setAttribute("success", "Booking created successfully!")
                    "updated" -> request.setAttribute("success", "Booking updated successfully!")
                    "cancelled" -> request.setAttribute("info", "Booking cancelled successfully.")
                }
            }

            request.getRequestDispatcher("view-bookings.jsp").forward(request, response)
        } catch (e: IOException) {
            System.err.println("IO Error loading bookings: ${e.message}")
            request.setAttribute("error", "Failed to load bookings: Invalid data in bookings file. Please contact support.")
            request.getRequestDispatcher("view-bookings.jsp").forward(request, response)
        } catch (e: Exception) {
            System.err.println("Unexpected error loading bookings: ${e.message}")
            request.setAttribute("error", "Failed to load bookings: ${e.message}")
            request.getRequestDispatcher("view-bookings.jsp").forward(request, response)
        }
    }

    private fun updateBookingStatuses() {
        try {
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
            val now = LocalDateTime.now()
            val bookings = bookingManager.getAllBookings()

            bookings.forEach { booking ->
                if (booking.status == "Confirmed" || booking.status == "Pending Confirmation") {
                    val bookingTime = LocalDateTime.parse("${booking.getDate()} ${booking.getTime()}", formatter)
                    if (bookingTime.isBefore(now)) {
                        booking.setStatus("Completed")
                    }
                }
            }
            bookingManager.saveAllBookings(bookings)
        } catch (e: Exception) {
            System.err.println("Error updating booking statuses: ${e.message}")
        }
    }
}