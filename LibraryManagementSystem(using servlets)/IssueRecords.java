package com.library.model;

import java.time.LocalDate;

public class IssueRecords {

    private int issueId;
    private int bookId;
    private int memberId;
    private LocalDate issueDate;
    private LocalDate returnDate;
    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public IssueRecords() {}

    public IssueRecords(int issueId, int bookId, int memberId, String status, LocalDate issueDate, LocalDate returnDate) {
        this.issueId = issueId;
        this.bookId = bookId;
        this.memberId = memberId;
        this.status = status;
        this.issueDate = issueDate;
        this.returnDate = returnDate;
    }

    public int getIssueId() {
        return issueId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }


    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }
    
    public IssueRecords(int bookId, int memberId, String availability, LocalDate issueDate) {
        this(0, bookId, memberId, availability, issueDate, null);
    }
    
    public IssueRecords(int issueId, int bookId, int memberId, String status, LocalDate issueDate) {
        this.issueId = issueId;
        this.bookId = bookId;
        this.memberId = memberId;
        this.status = status;
        this.issueDate = issueDate;
    }

}

