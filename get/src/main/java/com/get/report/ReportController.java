package com.get.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ReportMapper reportMapper;


    /**
     * 신고 내용 접수 처리
     * - reporterIdx, resiverIdx, rContent
     */
    @Autowired
    ReportService reportService;

    @PostMapping("/submit")
    @ResponseBody
    public String submitReport(ReportVO vo) {


        // 로그인된 사용자의 이메일을 가져옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();

        // 이메일로 mem_idx 조회

        String memIdx = reportService.selectMemIdxByEmail(email);
        if (memIdx == null) {
            throw new IllegalArgumentException("유효하지 않은 사용자입니다.");
        }

        // 신고자 ID 설정
        vo.setReporterIdx(memIdx);


        reportMapper.insertReport(vo);

        // 클라이언트에게 간단한 문자열 응답
        // 또는 JSON 응답으로 처리 가능
        return "OK";
    }

}