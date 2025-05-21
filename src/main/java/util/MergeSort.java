package util;

import model.Tutor;

import java.util.List;

public class MergeSort {
    public static void sort(List<Tutor> tutors) {
        if (tutors.size() > 1) {
            int mid = tutors.size() / 2;
            List<Tutor> left = tutors.subList(0, mid);
            List<Tutor> right = tutors.subList(mid, tutors.size());

            sort(left);
            sort(right);

            merge(tutors, left, right);
        }
    }

    private static void merge(List<Tutor> tutors, List<Tutor> left, List<Tutor> right) {
        int i = 0, j = 0, k = 0;

        while (i < left.size() && j < right.size()) {
            if (left.get(i).compareTo(right.get(j)) <= 0) {
                tutors.set(k++, left.get(i++));
            } else {
                tutors.set(k++, right.get(j++));
            }
        }

        while (i < left.size()) {
            tutors.set(k++, left.get(i++));
        }

        while (j < right.size()) {
            tutors.set(k++, right.get(j++));
        }
    }
}
