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
import java.util.UUID
import java.util.regex.Pattern

@WebServlet("/update-booking")
class UpdateBookingServlet : HttpServlet() {
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
            request.getRequestDispatcher("edit-bookings.jsp").forward(request, response)
        } catch (e: Exception) {
            response.sendRedirect("view-bookings?error=Error loading booking: ${e.message}")
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
            val existing: Booking? = bookingManager.getBookingById(id)

            if (existing == null) {
                response.sendRedirect("view-bookings?error=Booking not found")
                return
            }

            val subject = request.getParameter("subject")?.trim()
            val tutor = request.getParameter("tutor")?.trim()
            val date = request.getParameter("date")?.trim()
            val time = request.getParameter("time")?.trim()
            val duration = request.getParameter("duration")?.trim()
            val sessionType = request.getParameter("sessionType")?.trim()

            if (subject.isNullOrEmpty() || tutor.isNullOrEmpty() || date.isNullOrEmpty() ||
                time.isNullOrEmpty() || duration.isNullOrEmpty() || sessionType.isNullOrEmpty()) {
                throw IllegalArgumentException("All fields are required")
            }

            val validSubjects = listOf("Combined Maths", "Biology", "Physics", "Chemistry")
            if (subject !in validSubjects) {
                throw IllegalArgumentException("Invalid subject selected")
            }

            val tutorMap = mapOf(
                "Combined Maths" to listOf("Dr. Sarah Wilson", "Prof. Kelum Senanayaka"),
                "Biology" to listOf("Dr. Amith Pussalla", "Dr. Nimali Perera"),
                "Physics" to listOf("Prof. Ravi Fernando", "Dr. Lakmal Wijesinghe"),
                "Chemistry" to listOf("Dr. Priya Mendis", "Prof. Anura Jayasinghe")
            )
            val validTutors = tutorMap[subject] ?: throw IllegalArgumentException("No tutors available for subject")
            if (tutor !in validTutors) {
                throw IllegalArgumentException("Invalid tutor selected for the subject")
            }

            val datePattern = Pattern.compile("\\d{4}-\\d{2}-\\d{2}")
            if (!datePattern.matcher(date).matches()) {
                throw IllegalArgumentException("Invalid date format. Use yyyy-MM-dd")
            }
            val bookingDate = LocalDate.parse(date)
            if (bookingDate.isBefore(LocalDate.now())) {
                throw IllegalArgumentException("Booking date cannot be in the past")
            }

            val timePattern = Pattern.compile("\\d{2}:\\d{2}")
            if (!timePattern.matcher(time).matches()) {
                throw IllegalArgumentException("Invalid time format. Use HH:mm")
            }

            val validDurations = listOf("30 Minutes", "1 Hour", "1.5 Hours", "2 Hours")
            if (duration !in validDurations) {
                throw IllegalArgumentException("Invalid duration")
            }

            val validSessionTypes = listOf("Trial", "Regular", "Premium")
            if (sessionType !in validSessionTypes) {
                throw IllegalArgumentException("Invalid session type")
            }

            if (!checkAvailability(tutor, date, time, duration, id)) {
                throw IllegalArgumentException("Tutor is unavailable at the selected time")
            }

            val updated = Booking()
            updated.bookingId = id
            updated.subject = subject
            updated.setTutor(tutor)
            updated.setDate(date)
            updated.setTime(time)
            updated.setDuration(duration)
            updated.setSessionType(sessionType)
            updated.setStatus("Rescheduled")

            bookingManager.updateBooking(updated)
            response.sendRedirect("view-bookings?status=updated")
        } catch (e: IllegalArgumentException) {
            request.setAttribute("error", e.message)
            request.getRequestDispatcher("edit-bookings.jsp").forward(request, response)
        } catch (e: Exception) {
            request.setAttribute("error", "Failed to update booking: ${e.message}")
            request.getRequestDispatcher("edit-bookings.jsp").forward(request, response)
        }
    }

    private fun checkAvailability(tutor: String, date: String, time: String, duration: String, excludeId: String? = null): Boolean {
        val bookings = bookingManager.getAllBookings()
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
        val startTime = LocalDateTime.parse("$date $time", formatter)
        val durationMinutes = when (duration) {
            "30 Minutes" -> 30
            "1 Hour" -> 60
            "1.5 Hours" -> 90
            "2 Hours" -> 120
            else -> 0
        }
        val endTime = startTime.plusMinutes(durationMinutes.toLong())

        return bookings.none { b ->
            if (excludeId != null && b.bookingId == excludeId) return@none false
            b.tutor == tutor && b.date == date &&
                    LocalDateTime.parse("${b.date} ${b.time}", formatter).let { bStart ->
                        val bEnd = bStart.plusMinutes(when (b.duration) {
                            "30 Minutes" -> 30
                            "1 Hour" -> 60
                            "1.5 Hours" -> 90
                            "2 Hours" -> 120
                            else -> 0
                        }.toLong())
                        bStart < endTime && bEnd > startTime
                    }
        }
    }
}