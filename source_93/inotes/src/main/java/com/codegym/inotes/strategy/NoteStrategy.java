package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;
import java.util.List;

/**
 * Storage contract used by the application service.
 * Implementations may store notes in a relational database or a text file.
 */
public interface NoteStrategy {
    /** Inserts a new note or updates it when its ID already exists. */
    void save(Note note) throws Exception;

    /** Deletes a note using its identifier. */
    void delete(int id) throws Exception;

    /** Returns every note from this storage strategy. */
    List<Note> findAll() throws Exception;

    /** Searches note title and content for a keyword. */
    List<Note> search(String keyword) throws Exception;
}
