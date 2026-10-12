package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

/**
 * UTF-8 text-file storage. Each physical line follows id|title|content|typeId.
 * Backslashes, pipes and line breaks in field values are escaped so a note can
 * safely contain arbitrary text without corrupting the record boundaries.
 */
public class NoteFileStrategy implements NoteStrategy {
    private static final Object FILE_LOCK = new Object();

    private final Path filePath;

    public NoteFileStrategy() {
        String configured = System.getenv("INOTES_FILE_PATH");
        if (configured == null || configured.isBlank()) {
            configured = Paths.get(System.getProperty("user.home"), "iNotes-notes.txt").toString();
        }
        filePath = Paths.get(configured).toAbsolutePath().normalize();
    }

    public Path getFilePath() {
        return filePath;
    }

    @Override
    public void save(Note note) throws IOException {
        synchronized (FILE_LOCK) {
            List<Note> notes = readNotes();
            if (note.getId() <= 0) {
                int nextId = notes.stream().mapToInt(Note::getId).max().orElse(0) + 1;
                note.setId(nextId);
                notes.add(note);
            } else {
                boolean found = false;
                for (int i = 0; i < notes.size(); i++) {
                    if (notes.get(i).getId() == note.getId()) {
                        notes.set(i, note);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    throw new IOException("Không tìm thấy ghi chú cần cập nhật (ID=" + note.getId() + ").");
                }
            }
            writeNotes(notes);
        }
    }

    @Override
    public void delete(int id) throws IOException {
        synchronized (FILE_LOCK) {
            List<Note> notes = readNotes();
            boolean changed = notes.removeIf(note -> note.getId() == id);
            if (changed) {
                writeNotes(notes);
            }
        }
    }

    @Override
    public List<Note> findAll() throws IOException {
        synchronized (FILE_LOCK) {
            List<Note> notes = readNotes();
            notes.sort(Comparator.comparingInt(Note::getId).reversed());
            return notes;
        }
    }

    @Override
    public List<Note> search(String keyword) throws IOException {
        String term = keyword == null ? "" : keyword.trim().toLowerCase(Locale.ROOT);
        if (term.isEmpty()) {
            return findAll();
        }
        return findAll().stream()
                .filter(note -> contains(note.getTitle(), term) || contains(note.getContent(), term))
                .toList();
    }

    private boolean contains(String value, String term) {
        return value != null && value.toLowerCase(Locale.ROOT).contains(term);
    }

    private List<Note> readNotes() throws IOException {
        List<Note> notes = new ArrayList<>();
        if (!Files.exists(filePath)) {
            return notes;
        }

        List<String> lines = Files.readAllLines(filePath, StandardCharsets.UTF_8);
        for (String line : lines) {
            if (line == null || line.isBlank()) {
                continue;
            }
            try {
                List<String> columns = splitEscaped(line);
                if (columns.size() != 4) {
                    continue;
                }
                int id = Integer.parseInt(columns.get(0));
                int typeId = Integer.parseInt(columns.get(3));
                if (id > 0 && typeId > 0) {
                    notes.add(new Note(id, columns.get(1), columns.get(2), typeId));
                }
            } catch (NumberFormatException ignored) {
                // Ignore a malformed line rather than preventing all notes from loading.
            }
        }
        return notes;
    }

    private void writeNotes(List<Note> notes) throws IOException {
        Path parent = filePath.getParent();
        if (parent != null) {
            Files.createDirectories(parent);
        }
        List<String> lines = new ArrayList<>();
        for (Note note : notes) {
            lines.add(note.getId() + "|" + escape(note.getTitle()) + "|" +
                    escape(note.getContent()) + "|" + note.getTypeId());
        }
        Files.write(filePath, lines, StandardCharsets.UTF_8,
                StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.WRITE);
    }

    private String escape(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                .replace("|", "\\|")
                .replace("\r", "\\r")
                .replace("\n", "\\n");
    }

    private List<String> splitEscaped(String line) {
        List<String> values = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '\\' && i + 1 < line.length()) {
                char escaped = line.charAt(++i);
                switch (escaped) {
                    case 'n' -> current.append('\n');
                    case 'r' -> current.append('\r');
                    case '|' -> current.append('|');
                    case '\\' -> current.append('\\');
                    default -> {
                        current.append('\\');
                        current.append(escaped);
                    }
                }
            } else if (c == '|') {
                values.add(current.toString());
                current.setLength(0);
            } else {
                current.append(c);
            }
        }
        values.add(current.toString());
        return values;
    }
}
