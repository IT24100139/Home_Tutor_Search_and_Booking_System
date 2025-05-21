// Form validation for registration
document.addEventListener('DOMContentLoaded', function() {
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }

            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }

            return true;
        });
    }

    // Search functionality
    const searchForm = document.getElementById('searchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            const searchInput = document.getElementById('searchInput').value;
            if (!searchInput.trim()) {
                e.preventDefault();
                alert('Please enter a subject to search for');
                return false;
            }
            return true;
        });
    }

    // Profile edit validation
    const profileForm = document.getElementById('profileForm');
    if (profileForm) {
        profileForm.addEventListener('submit', function(e) {
            const hourlyRate = document.getElementById('hourlyRate').value;
            const experienceYears = document.getElementById('experienceYears').value;

            if (isNaN(hourlyRate) || hourlyRate <= 0) {
                e.preventDefault();
                alert('Hourly rate must be a positive number');
                return false;
            }

            if (isNaN(experienceYears) || experienceYears < 0) {
                e.preventDefault();
                alert('Experience years must be a non-negative number');
                return false;
            }

            return true;
        });
    }
});