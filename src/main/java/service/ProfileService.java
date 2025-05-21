package service;

import model.Tutor;

public class ProfileService {
    private final TutorService tutorService;

    public ProfileService() {
        this.tutorService = new TutorService();
    }

    public Tutor getTutorProfile(String tutorId) {
        return tutorService.getTutorById(tutorId);
    }

    public boolean updateTutorProfile(Tutor tutor) {
        return tutorService.updateTutor(tutor);
    }

    public boolean deleteTutorProfile(String tutorId) {
        return tutorService.deleteTutor(tutorId);
    }
}
