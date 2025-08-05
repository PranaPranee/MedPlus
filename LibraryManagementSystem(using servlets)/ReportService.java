package com.library.service;

import java.util.List;

public interface ReportService {
    List<OverdueBook> getOverdueBooks();
    List<CategoryCount> getBooksPerCategory();
    List<ActiveMember> getActiveMembers();

    class OverdueBook {
        private String title;
        private String memberName;
        private java.time.LocalDate issueDate;

        public OverdueBook(String title, String memberName, java.time.LocalDate issueDate) {
            this.title = title;
            this.memberName = memberName;
            this.issueDate = issueDate;
        }

        public String getTitle() { return title; }
        public String getMemberName() { return memberName; }
        public java.time.LocalDate getIssueDate() { return issueDate; }
    }

    class CategoryCount {
        private String category;
        private int count;

        public CategoryCount(String category, int count) {
            this.category = category;
            this.count = count;
        }

        public String getCategory() { return category; }
        public int getCount() { return count; }
    }

    class ActiveMember {
        private String name;
        private int booksIssued;

        public ActiveMember(String name, int booksIssued) {
            this.name = name;
            this.booksIssued = booksIssued;
        }

        public String getName() { return name; }
        public int getBooksIssued() { return booksIssued; }
    }
}
