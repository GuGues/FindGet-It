package com.get.report;

import org.springframework.stereotype.Service;

@Service
public class ReportService {
    private final ReportMapper reportMapper;

    public ReportService(ReportMapper reportMapper) {
        this.reportMapper = reportMapper;
    }

    public String selectMemIdxByEmail(String email) {
        return reportMapper.selectMemIdxByEmail(email);
    }
}