package com.codegym.inotes.strategy;

/** Creates one of the supported storage strategy implementations. */
public final class NoteStorageFactory {
    private NoteStorageFactory() {
    }

    public static NoteStrategy create(String storage) {
        if ("FILE".equalsIgnoreCase(storage)) {
            return new NoteFileStrategy();
        }
        return new NoteDBStrategy();
    }

    public static String normalize(String storage) {
        return "FILE".equalsIgnoreCase(storage) ? "FILE" : "DB";
    }
}
