package com.library.controller;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import com.library.dao.BookDAOImplementation;
import com.library.model.Book;
import com.library.service.BookServiceImplementation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CategoryCountServlet")
public class CategoryCountServlet extends HttpServlet {

    private final BookServiceImplementation bookService = new BookServiceImplementation(new BookDAOImplementation());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Book> allBooks = bookService.getAllBooks();
            Map<String, Long> countByCategory = allBooks.stream()
                .collect(Collectors.groupingBy(Book::getCategory, Collectors.counting()));

            List<CategoryCount> categoryCounts = countByCategory.entrySet().stream()
                .map(entry -> new CategoryCount(entry.getKey(), entry.getValue()))
                .sorted(Comparator.comparingLong(CategoryCount::getCount).reversed())
                .collect(Collectors.toList());

            request.setAttribute("categoryCounts", categoryCounts);
            request.getRequestDispatcher("/categoryCount.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Main.html");
        }
    }

    public static class CategoryCount {
        private final String category;
        private final Long count;

        public CategoryCount(String category, Long count) {
            this.category = category;
            this.count = count;
        }

        public String getCategory() { return category; }
        public Long getCount() { return count; }
    }
}
