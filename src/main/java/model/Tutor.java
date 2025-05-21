package model;

import java.io.Serializable;

public class Tutor implements Serializable, Comparable<Tutor> {
    private String id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String qualification;
    private String subjectExpertise;
    private double hourlyRate;
    private int experienceYears;
    private String availability;

    public Tutor() {}

    public Tutor(String id, String name, String email, String password, String phone, String address,
                 String qualification, String subjectExpertise, double hourlyRate, int experienceYears,
                 String availability) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.qualification = qualification;
        this.subjectExpertise = subjectExpertise;
        this.hourlyRate = hourlyRate;
        this.experienceYears = experienceYears;
        this.availability = availability;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }
    public String getSubjectExpertise() { return subjectExpertise; }
    public void setSubjectExpertise(String subjectExpertise) { this.subjectExpertise = subjectExpertise; }
    public double getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(double hourlyRate) { this.hourlyRate = hourlyRate; }
    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }
    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }

    @Override
    public int compareTo(Tutor other) {
        return this.subjectExpertise.compareToIgnoreCase(other.subjectExpertise);
    }

    @Override
    public String toString() {
        return "Tutor{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", qualification='" + qualification + '\'' +
                ", subjectExpertise='" + subjectExpertise + '\'' +
                ", hourlyRate=" + hourlyRate +
                ", experienceYears=" + experienceYears +
                ", availability='" + availability + '\'' +
                '}';
    }
}
