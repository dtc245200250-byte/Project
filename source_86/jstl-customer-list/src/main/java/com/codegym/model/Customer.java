package com.codegym.model;

public class Customer {
    private final String name;
    private final String birthDate;
    private final String address;
    private final String imageUrl;

    public Customer(String name, String birthDate, String address, String imageUrl) {
        this.name = name;
        this.birthDate = birthDate;
        this.address = address;
        this.imageUrl = imageUrl;
    }

    public String getName() {
        return name;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public String getAddress() {
        return address;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
