package com.library.service;

import java.util.List;

import com.library.model.IssueRecords;

public interface IssueRecordService {
    boolean issueBook(IssueRecords record) throws Exception;
    boolean returnBook(int issueId) throws Exception;
    IssueRecords getActiveIssueByBookId(int bookId) throws Exception;
    List<IssueRecords> getAllIssues() throws Exception;
    List<Integer> getAvailableBookIds() throws Exception;
    List<Integer> getValidMemberIds() throws Exception;
}

