package com.codegym.inotes.service;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.strategy.NoteStrategy;

import java.util.List;
import java.util.Objects;

/** Coordinates note use cases without depending on any specific storage backend. */
public class NoteManagement {
    private NoteStrategy strategy;

    public NoteManagement(NoteStrategy strategy) {
        setStrategy(strategy);
    }

    /** Allows storage strategy to be switched at runtime. */
    public void setStrategy(NoteStrategy strategy) {
        this.strategy = Objects.requireNonNull(strategy, "strategy must not be null");
    }

    public NoteStrategy getStrategy() {
        return strategy;
    }

    public List<Note> searchNotes(String keyword) throws Exception {
        if (keyword == null || keyword.isBlank()) {
            return strategy.findAll();
        }
        return strategy.search(keyword.trim());
    }

    public void addNote(String title, String content, int typeId) throws Exception {
        String cleanedTitle = title == null ? "" : title.trim();
        if (cleanedTitle.isEmpty()) {
            throw new IllegalArgumentException("Tiêu đề ghi chú không được để trống.");
        }
        if (cleanedTitle.length() > 255) {
            throw new IllegalArgumentException("Tiêu đề không được dài quá 255 ký tự.");
        }
        validateType(typeId);
        strategy.save(new Note(cleanedTitle, content == null ? "" : content, typeId));
    }

    public void updateNote(int id, String title, String content, int typeId) throws Exception {
        if (id < 1) {
            throw new IllegalArgumentException("ID ghi chú không hợp lệ.");
        }
        String cleanedTitle = title == null ? "" : title.trim();
        if (cleanedTitle.isEmpty() || cleanedTitle.length() > 255) {
            throw new IllegalArgumentException("Tiêu đề không được để trống và tối đa 255 ký tự.");
        }
        validateType(typeId);
        strategy.save(new Note(id, cleanedTitle, content == null ? "" : content, typeId));
    }

    public void deleteNote(int id) throws Exception {
        if (id < 1) {
            throw new IllegalArgumentException("ID ghi chú không hợp lệ.");
        }
        strategy.delete(id);
    }

    public Note findNoteById(int id) throws Exception {
        return strategy.findAll().stream()
                .filter(note -> note.getId() == id)
                .findFirst()
                .orElse(null);
    }

    private void validateType(int typeId) {
        if (typeId < 1 || typeId > 3) {
            throw new IllegalArgumentException("Vui lòng chọn một phân loại hợp lệ.");
        }
    }
}
