package service;

import model.Tutor;
import util.MergeSort;

import java.util.List;

public class SearchService {
    private final TutorService tutorService;

    public SearchService() {
        this.tutorService = new TutorService();
    }

    public List<Tutor> searchTutorsBySubject(String subject) {
        List<Tutor> tutors = tutorService.searchTutorsBySubject(subject);
        MergeSort.sort(tutors); // Sort by subject expertise
        return tutors;
    }

    public List<Tutor> getAllTutorsSorted() {
        return tutorService.getAllTutors();
    }
}
