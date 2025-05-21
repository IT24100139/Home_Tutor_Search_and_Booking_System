package util;

import model.Tutor;

import java.util.ArrayList;
import java.util.List;

public class BST {
    private Node root;

    private class Node {
        Tutor tutor;
        Node left, right;

        Node(Tutor tutor) {
            this.tutor = tutor;
        }
    }

    public void insert(Tutor tutor) {
        root = insert(root, tutor);
    }

    private Node insert(Node node, Tutor tutor) {
        if (node == null) return new Node(tutor);

        if (tutor.compareTo(node.tutor) < 0) {
            node.left = insert(node.left, tutor);
        } else if (tutor.compareTo(node.tutor) > 0) {
            node.right = insert(node.right, tutor);
        }

        return node;
    }

    public List<Tutor> inOrderTraversal() {
        List<Tutor> tutors = new ArrayList<>();
        inOrderTraversal(root, tutors);
        return tutors;
    }

    private void inOrderTraversal(Node node, List<Tutor> tutors) {
        if (node != null) {
            inOrderTraversal(node.left, tutors);
            tutors.add(node.tutor);
            inOrderTraversal(node.right, tutors);
        }
    }

    public Tutor search(String subject) {
        return search(root, subject);
    }

    private Tutor search(Node node, String subject) {
        if (node == null) return null;

        int cmp = subject.compareToIgnoreCase(node.tutor.getSubjectExpertise());
        if (cmp < 0) {
            return search(node.left, subject);
        } else if (cmp > 0) {
            return search(node.right, subject);
        } else {
            return node.tutor;
        }
    }

    public List<Tutor> searchAll(String subject) {
        List<Tutor> result = new ArrayList<>();
        searchAll(root, subject, result);
        return result;
    }

    private void searchAll(Node node, String subject, List<Tutor> result) {
        if (node == null) return;

        int cmp = subject.compareToIgnoreCase(node.tutor.getSubjectExpertise());
        if (cmp <= 0) {
            searchAll(node.left, subject, result);
        }
        if (cmp == 0) {
            result.add(node.tutor);
        }
        if (cmp >= 0) {
            searchAll(node.right, subject, result);
        }
    }
}
