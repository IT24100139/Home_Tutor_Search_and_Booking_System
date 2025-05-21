package service;

import model.Tutor;
import model.User;

import java.util.List;

public class AuthService {
    private final TutorService tutorService;

    public AuthService() {
        this.tutorService = new TutorService();
    }

    public User authenticate(String email, String password) {
        List<Tutor> tutors = tutorService.getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getEmail().equalsIgnoreCase(email) && tutor.getPassword().equals(password)) {
                return new User(tutor.getId(), tutor.getEmail(), "tutor");
            }
        }
        return null;
    }

    public boolean register(Tutor tutor) {
        return tutorService.addTutor(tutor);
    }

    public boolean emailExists(String email) {
        List<Tutor> tutors = tutorService.getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }
}
