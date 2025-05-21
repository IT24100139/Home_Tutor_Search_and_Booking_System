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
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.*
import java.util.regex.Pattern

@WebServlet("/update-booking")
class UpdateBookingServlet : HttpServlet() {

    private var bookingManager: BookingManager? = null

    // Initialize BookingManager once servlet starts
    override fun init() {
        bookingManager = BookingManager(servletContext)
    }

    //GET request handler for loading edit form
    @Throws(ServletException::class, IOException::class)
    override fun doGet(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            val id = request.getParameter("id")
            val booking = bookingManager!!.getBookingById(id)

            if (booking == null) {
                response.sendRedirect("view-bookings?error=Booking not found")
                return
            }

            // Generate CSRF token and attach to session/request
            val csrfToken = UUID.randomUUID().toString()
            request.session.setAttribute("csrfToken", csrfToken)

            // Disable caching for security
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate")
            response.setHeader("Pragma", "no-cache")
            response.setDateHeader("Expires", 0)

            // Attach data to render
            request.setAttribute("csrfToken", csrfToken)
            request.setAttribute("booking", booking)
            request.getRequestDispatcher("edit-bookings.jsp").forward(request, response)

        } catch (e: Exception) {
            System.err.println("Error in UpdateBookingServlet doGet: " + e.message)
            response.sendRedirect("view-bookings?error=Error loading booking: " + e.message)
        }
    }

    //POST request handler for updating booking after form submit
    @Throws(ServletException::class, IOException::class)
    override fun doPost(request: HttpServletRequest, response: HttpServletResponse) {
        try {
            // CSRF token validation
            val submittedToken = request.getParameter("_csrf")
            val sessionToken = request.session.getAttribute("csrfToken") as String
            require(!(submittedToken == null || sessionToken != submittedToken)) { "Invalid CSRF token" }
            request.session.removeAttribute("csrfToken")

            // Retrieve existing booking
            val id = request.getParameter("id")
            val existing = bookingManager!!.getBookingById(id)
            if (existing == null) {
                response.sendRedirect("view-bookings?error=Booking not found")
                return
            }

            // Extract and validate form data
            val subject = required(request.getParameter("subject"))
            val tutor = required(request.getParameter("tutor"))
            val date = required(request.getParameter("date"))
            val time = required(request.getParameter("time"))
            val duration = required(request.getParameter("duration"))
            val sessionType = required(request.getParameter("sessionType"))

            validateSubjectAndTutor(subject, tutor)
            validateDateFormat(date)
            validateTimeFormat(time)
            validateDurationSessionType(duration, sessionType)
            require(checkAvailability(tutor, date, time, duration, id)) { "Tutor is unavailable at selected time" }

            // Create updated booking object
            val updated = Booking().apply {
                bookingId = id
                this.subject = subject
                this.tutor = tutor
                this.date = date
                this.time = time
                this.duration = duration
                this.sessionType = sessionType
                this.status = "Pending Confirmation"
            }

            // Persist updates
            bookingManager!!.updateBooking(updated)
            response.sendRedirect("view-bookings?status=updated")

        } catch (e: IllegalArgumentException) {
            handleError(request, response, e.message)
        } catch (e: Exception) {
            handleError(request, response, "Failed to update booking: " + e.message)
        }
    }

    //Error handler – re-show edit form with error message
    private fun handleError(req: HttpServletRequest, res: HttpServletResponse, msg: String?) {
        val csrfToken = UUID.randomUUID().toString()
        req.session.setAttribute("csrfToken", csrfToken)
        req.setAttribute("csrfToken", csrfToken)
        req.setAttribute("error", msg)

        try {
            val id = req.getParameter("id")
            val booking = bookingManager!!.getBookingById(id)
            req.setAttribute("booking", booking)
        } catch (e: IOException) {
            System.err.println("Error loading booking during error: " + e.message)
        }

        req.getRequestDispatcher("edit-bookings.jsp").forward(req, res)
    }

    //Ensures the value is present and trimmed
    private fun required(value: String?): String {
        require(!(value == null || value.trim().isEmpty())) { "All fields are required" }
        return value.trim()
    }

    //Validates that subject and tutor pairing is allowed
    private fun validateSubjectAndTutor(subject: String, tutor: String) {
        val validSubjects = listOf("Combined Maths", "Biology", "Physics", "Chemistry")

        val tutorMap = mapOf(
            "Combined Maths" to listOf("Dr. Sarah Wilson", "Prof. Kelum Senanayaka"),
            "Biology" to listOf("Dr. Amith Pussalla", "Dr. Nimali Perera"),
            "Physics" to listOf("Prof. Ravi Fernando", "Dr. Lakmal Wijesinghe"),
            "Chemistry" to listOf("Dr. Priya Mendis", "Prof. Anura Jayasinghe")
        )

        require(validSubjects.contains(subject)) { "Invalid subject selected" }
        require(tutorMap[subject]?.contains(tutor) == true) { "Invalid tutor selected for subject" }
    }

    //Validates booking date format and if it is not in the past
    private fun validateDateFormat(date: String) {
        require(Pattern.matches("\\d{4}-\\d{2}-\\d{2}", date)) { "Invalid date format. Use yyyy-MM-dd" }
        require(!LocalDate.parse(date).isBefore(LocalDate.now())) { "Booking date cannot be in the past" }
    }

    //Validates time format (HH:mm)
    private fun validateTimeFormat(time: String) {
        require(Pattern.matches("\\d{2}:\\d{2}", time)) { "Invalid time format. Use HH:mm" }
    }

    //Ensures sessionType matches the selected duration
    private fun validateDurationSessionType(duration: String, sessionType: String) {
        when (duration) {
            "30 Minutes" -> require(sessionType == "Trial") { "30 min must be Trial" }
            "1 Hour", "1.5 Hours" -> require(sessionType == "Regular") { "1–1.5h must be Regular" }
            "2 Hours" -> require(sessionType == "Premium") { "2h must be Premium" }
            else -> throw IllegalArgumentException("Invalid duration")
        }
    }

    //Checks for overlapping bookings with the same tutor
    private fun checkAvailability(
        tutor: String,
        date: String,
        time: String,
        duration: String,
        excludeId: String?
    ): Boolean {
        val bookings = bookingManager!!.allBookings
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")

        val start = LocalDateTime.parse("$date $time", formatter)
        val end = start.plusMinutes(getDurationInMinutes(duration).toLong())

        for (b in bookings) {
            if (excludeId != null && b.bookingId == excludeId) continue
            if (b.tutor != tutor || b.date != date) continue

            val bStart = LocalDateTime.parse("${b.date} ${b.time}", formatter)
            val bEnd = bStart.plusMinutes(getDurationInMinutes(b.duration).toLong())

            if (bStart.isBefore(end) && bEnd.isAfter(start)) {
                return false // Overlap detected
            }
        }
        return true
    }

    //Converts duration string to minutes
    private fun getDurationInMinutes(duration: String): Int {
        return when (duration) {
            "30 Minutes" -> 30
            "1 Hour" -> 60
            "1.5 Hours" -> 90
            "2 Hours" -> 120
            else -> 0
        }
    }
}