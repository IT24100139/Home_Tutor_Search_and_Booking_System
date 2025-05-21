package service;

import model.Tutor;
import util.BST;
import util.MergeSort;

import java.util.List;

public class TutorService {
    private BST tutorBST;

    public TutorService() {
        loadTutorsToBST();
    }

    private void loadTutorsToBST() {
        tutorBST = new BST();
        List<Tutor> tutors = FileService.loadTutors();
        for (Tutor tutor : tutors) {
            tutorBST.insert(tutor);
        }
    }

    public List<Tutor> getAllTutors() {
        List<Tutor> tutors = tutorBST.inOrderTraversal();
        MergeSort.sort(tutors); // Sort by subject expertise
        return tutors;
    }

    public boolean addTutor(Tutor tutor) {
        List<Tutor> tutors = getAllTutors();
        tutors.add(tutor);
        FileService.saveTutors(tutors);
        loadTutorsToBST(); // Refresh BST
        return true;
    }

    public Tutor getTutorById(String id) {
        List<Tutor> tutors = getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getId().equals(id)) {
                return tutor;
            }
        }
        return null;
    }

    public boolean updateTutor(Tutor updatedTutor) {
        List<Tutor> tutors = getAllTutors();
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getId().equals(updatedTutor.getId())) {
                tutors.set(i, updatedTutor);
                FileService.saveTutors(tutors);
                loadTutorsToBST(); // Refresh BST
                return true;
            }
        }
        return false;
    }

    public boolean deleteTutor(String id) {
        List<Tutor> tutors = getAllTutors();
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getId().equals(id)) {
                tutors.remove(i);
                FileService.saveTutors(tutors);
                loadTutorsToBST(); // Refresh BST
                return true;
            }
        }
        return false;
    }

    public List<Tutor> searchTutorsBySubject(String subject) {
        return tutorBST.searchAll(subject);
    }
}
