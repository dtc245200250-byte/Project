package com.codegym.inotes.model;

import java.util.List;

/** Supported categories shared by the MySQL and TXT strategies. */
public class NoteType {
    private final int id;
    private final String name;
    private final String description;

    public NoteType(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }

    public static List<NoteType> defaults() {
        return List.of(
            new NoteType(1, "Cá nhân", "Ghi chú cá nhân"),
            new NoteType(2, "Công việc", "Công việc và lịch họp"),
            new NoteType(3, "Học tập", "Bài học và ôn tập")
        );
    }

    public static String nameOf(int id) {
        return defaults().stream()
                .filter(type -> type.id == id)
                .map(NoteType::getName)
                .findFirst()
                .orElse("Khác");
    }
}
