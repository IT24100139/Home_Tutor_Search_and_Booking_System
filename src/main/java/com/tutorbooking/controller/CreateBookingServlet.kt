package com.tutorbooking.controller

import com.tutorbooking.model.Booking
import com.tutorbooking.service.BookingManager
import jakarta.servlet.ServletException
import jakarta.servlet.annotation.WebServlet
import jakarta.servlet.http.HttpServlet
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import java.io.IOException
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*
import java.util.regex.Pattern

@WebServlet("/create-booking")
class CreateBookingServlet : HttpServlet() {

    private var bookingManager: BookingManager? = null

    // Initialize BookingManager when servlet is loaded
    override fun init() {
        super.init()
        bookingManager = BookingManager(servletContext)
    }

    // GET method: Displays the booking form with CSRF protection
    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            val session = request.getSession(true)
            session.maxInactiveInterval = 30 * 60 // 30 min session timeout

            // Generate CSRF token
            val csrfToken = UUID.randomUUID().toString()
            session.setAttribute("csrfToken", csrfToken)

            // Debug logging (can be removed in production)
            println("Session ID (doGet) = ${session.id}")
            println("Generated CSRF Token = $csrfToken")

            // Prevent caching the booking form
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate")
            response.setHeader("Pragma", "no-cache")
            response.setDateHeader("Expires", 0)

            // Pass CSRF token to form
            request.setAttribute("csrfToken", csrfToken)
            request.getRequestDispatcher("book-tutor.jsp").forward(request, response)
        } catch (e: Exception) {
            e.printStackTrace()
            response.sendRedirect("view-bookings?error=Unable to load booking form.")
        }
    }

    // POST method: Handles booking form submission
    @Throws(ServletException::class, IOException::class)
    override fun doPost(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            // Validate session existence
            val session = request.getSession(false)
                ?: throw SessionException("Session expired. Please refresh.")

            println("Session ID (doPost) = ${session.id}")

            // Validate CSRF token
            val token = request.getParameter("_csrf")
            val sessionToken = session.getAttribute("csrfToken") as? String
                ?: throw SessionException("Missing CSRF token in session.")
            if (token == null || token != sessionToken) {
                throw SessionException("Invalid CSRF token.")
            }

            // Remove token after use
            session.removeAttribute("csrfToken")

            // Validate form fields and create booking object
            val booking = validateAndCreateBooking(request)

            // Persist booking
            bookingManager?.createBooking(booking)

            // Redirect to success page
            response.sendRedirect("view-bookings?status=created")

        } catch (e: SessionException) {
            e.printStackTrace()
            handleError(request, response, e.message)
        } catch (e: IllegalArgumentException) {
            e.printStackTrace()
            handleError(request, response, e.message)
        } catch (e: Exception) {
            e.printStackTrace()
            handleError(request, response, "A system error occurred. Try again.")
        }
    }

    // Validates all input fields and constructs a Booking object
    private fun validateAndCreateBooking(req: HttpServletRequest): Booking {
        val subject = required(req.getParameter("subject"), "Subject is required")
        val tutor = required(req.getParameter("tutor"), "Tutor is required")
        val date = required(req.getParameter("date"), "Date is required")
        val time = required(req.getParameter("time"), "Time is required")
        val duration = required(req.getParameter("duration"), "Duration is required")
        val sessionType = required(req.getParameter("sessionType"), "Session type is required")

        // Validate allowed subjects
        val validSubjects = listOf("Combined Maths", "Biology", "Physics", "Chemistry")
        require(validSubjects.contains(subject)) { "Invalid subject" }

        // Tutor list validation per subject
        val tutorMap = mapOf(
            "Combined Maths" to listOf("Dr. Sarah Wilson", "Prof. Kelum Senanayaka"),
            "Biology" to listOf("Dr. Amith Pussalla", "Dr. Nimali Perera"),
            "Physics" to listOf("Prof. Ravi Fernando", "Dr. Lakmal Wijesinghe"),
            "Chemistry" to listOf("Dr. Priya Mendis", "Prof. Anura Jayasinghe")
        )
        require(tutorMap[subject]?.contains(tutor) == true) { "Tutor not available for selected subject" }

        validateDate(date)
        validateTime(time)
        validateDurationSessionType(duration, sessionType)

        // Check if the tutor is free
        require(checkAvailability(tutor, date, time, duration, null)) {
            "Tutor is not available at the selected time"
        }

        return Booking(generateBookingId(), subject, tutor, date, time, duration, sessionType, "Pending Confirmation")
    }

    // Generic error forwarding method
    private fun handleError(req: HttpServletRequest, res: HttpServletResponse, msg: String?) {
        val csrfToken = UUID.randomUUID().toString()
        req.session.setAttribute("csrfToken", csrfToken)
        req.setAttribute("csrfToken", csrfToken)
        req.setAttribute("error", msg)
        req.getRequestDispatcher("book-tutor.jsp").forward(req, res)
    }

    // Required field validator
    private fun required(value: String?, msg: String): String {
        require(!(value == null || value.trim().isEmpty())) { msg }
        return value.trim()
    }

    // Date format and logic validation
    private fun validateDate(date: String) {
        require(Pattern.matches("\\d{4}-\\d{2}-\\d{2}", date)) { "Invalid date format (yyyy-MM-dd)" }
        require(!LocalDate.parse(date).isBefore(LocalDate.now())) { "Date cannot be in the past" }
    }

    // Time format validation
    private fun validateTime(time: String) {
        require(Pattern.matches("\\d{2}:\\d{2}", time)) { "Invalid time format (HH:mm)" }
    }

    // Duration must match appropriate session type
    private fun validateDurationSessionType(duration: String, type: String) {
        when (duration) {
            "30 Minutes" -> require(type == "Trial") { "30 min must be Trial" }
            "1 Hour", "1.5 Hours" -> require(type == "Regular") { "1–1.5h must be Regular" }
            "2 Hours" -> require(type == "Premium") { "2h must be Premium" }
            else -> throw IllegalArgumentException("Invalid duration")
        }
    }

    // Checks if there's a clash with existing bookings
    private fun checkAvailability(
        tutor: String,
        date: String,
        time: String,
        duration: String,
        excludeId: String?
    ): Boolean {
        val bookings = bookingManager!!.allBookings
        val durationMinutes = when (duration) {
            "30 Minutes" -> 30
            "1 Hour" -> 60
            "1.5 Hours" -> 90
            "2 Hours" -> 120
            else -> 0
        }

        val (h, m) = time.split(":").map { it.toInt() }
        val newStart = LocalDate.parse(date).atTime(h, m)
        val newEnd = newStart.plusMinutes(durationMinutes.toLong())

        for (b in bookings) {
            if (excludeId != null && b.bookingId == excludeId) continue
            if (b.tutor != tutor || b.date != date) continue

            val (bh, bm) = b.time.split(":").map { it.toInt() }
            val start = LocalDate.parse(b.date).atTime(bh, bm)
            val end = start.plusMinutes(
                when (b.duration) {
                    "30 Minutes" -> 30
                    "1 Hour" -> 60
                    "1.5 Hours" -> 90
                    "2 Hours" -> 120
                    else -> 0
                }.toLong()
            )

            // Check time overlap
            if (start.isBefore(newEnd) && end.isAfter(newStart)) {
                return false
            }
        }
        return true
    }

    // Generate unique booking ID like BK001, BK002...
    private fun generateBookingId(): String {
        val count = bookingManager!!.allBookings.size + 1
        return String.format("BK%03d", count)
    }

    // Custom exception for session-related errors
    private class SessionException(message: String?) : Exception(message)
}
