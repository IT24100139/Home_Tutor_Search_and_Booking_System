package service;

import model.Tutor;
import model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileService {
    private static final String TUTORS_FILE = "tutors.txt";
    private static final String USERS_FILE = "users.txt";

    // Save tutors to file
    public static void saveTutors(List<Tutor> tutors) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(TUTORS_FILE))) {
            oos.writeObject(tutors);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Load tutors from file
    @SuppressWarnings("unchecked")
    public static List<Tutor> loadTutors() {
        File file = new File(TUTORS_FILE);
        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(TUTORS_FILE))) {
            return (List<Tutor>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Save users to file
    public static void saveUsers(List<User> users) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(USERS_FILE))) {
            oos.writeObject(users);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Load users from file
    @SuppressWarnings("unchecked")
    public static List<User> loadUsers() {
        File file = new File(USERS_FILE);
        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(USERS_FILE))) {
            return (List<User>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
