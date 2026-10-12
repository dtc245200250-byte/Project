package com.codegym.inotes.controller;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;
import com.codegym.inotes.service.NoteManagement;
import com.codegym.inotes.strategy.NoteStorageFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/** MVC controller for iNotes screens and note use cases. */
@WebServlet(name = "NoteServlet", urlPatterns = "/notes")
public class NoteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String storage = configureStorage(request);
        NoteManagement management = new NoteManagement(NoteStorageFactory.create(storage));
        String action = value(request.getParameter("action"), "list");

        try {
            switch (action) {
                case "create" -> showForm(request, response, "/note/create.jsp");
                case "view" -> showExistingNote(request, response, management, "/note/view.jsp");
                case "edit" -> showExistingNote(request, response, management, "/note/edit.jsp");
                default -> {
                    String keyword = value(request.getParameter("q"), "");
                    request.setAttribute("keyword", keyword);
                    request.setAttribute("notes", management.searchNotes(keyword));
                    request.setAttribute("noteTypes", NoteType.defaults());
                    request.setAttribute("storage", storage);
                    request.getRequestDispatcher("/note/list.jsp").forward(request, response);
                }
            }
        } catch (Exception exception) {
            throw new ServletException("Không thể tải ghi chú. Hãy kiểm tra nguồn lưu trữ đang chọn.", exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String storage = configureStorage(request);
        NoteManagement management = new NoteManagement(NoteStorageFactory.create(storage));
        String action = value(request.getParameter("action"), "");

        try {
            switch (action) {
                case "create" -> management.addNote(
                        request.getParameter("title"),
                        request.getParameter("content"),
                        parseInt(request.getParameter("typeId")));
                case "edit" -> management.updateNote(
                        parseInt(request.getParameter("id")),
                        request.getParameter("title"),
                        request.getParameter("content"),
                        parseInt(request.getParameter("typeId")));
                case "delete" -> management.deleteNote(parseInt(request.getParameter("id")));
                default -> {
                    response.sendRedirect(request.getContextPath() + "/notes");
                    return;
                }
            }
            // Post/Redirect/Get prevents duplicate creation after browser refresh.
            response.sendRedirect(request.getContextPath() + "/notes?storage=" + storage);
        } catch (IllegalArgumentException exception) {
            request.setAttribute("errorMessage", exception.getMessage());
            request.setAttribute("noteTypes", NoteType.defaults());
            if ("edit".equals(action)) {
                try {
                    request.setAttribute("note", management.findNoteById(parseInt(request.getParameter("id"))));
                } catch (Exception ignored) {
                    // Keep the validation message visible if reloading the note also fails.
                }
                request.getRequestDispatcher("/note/edit.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/note/create.jsp").forward(request, response);
            }
        } catch (Exception exception) {
            throw new ServletException("Không thể lưu thay đổi ghi chú. Hãy kiểm tra cấu hình MySQL hoặc file.", exception);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        request.setAttribute("noteTypes", NoteType.defaults());
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private void showExistingNote(HttpServletRequest request, HttpServletResponse response,
                                  NoteManagement management, String jsp)
            throws Exception {
        int id = parseInt(request.getParameter("id"));
        Note note = management.findNoteById(id);
        if (note == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy ghi chú.");
            return;
        }
        request.setAttribute("note", note);
        request.setAttribute("noteTypes", NoteType.defaults());
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private String configureStorage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String requested = request.getParameter("storage");
        if (requested != null && !requested.isBlank()) {
            session.setAttribute("noteStorage", NoteStorageFactory.normalize(requested));
        }
        if (session.getAttribute("noteStorage") == null) {
            session.setAttribute("noteStorage", "DB");
        }
        return NoteStorageFactory.normalize((String) session.getAttribute("noteStorage"));
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException exception) {
            throw new IllegalArgumentException("ID hoặc phân loại không hợp lệ.");
        }
    }

    private String value(String input, String fallback) {
        return input == null || input.isBlank() ? fallback : input.trim();
    }
}
