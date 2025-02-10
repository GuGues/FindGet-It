package com.get.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired
    private DashboardMapper dashboardMapper;

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        DashboardVO data = new DashboardVO();

        // 1) 습득물
        data.setFoundTotalCount(dashboardMapper.selectFoundTotalCount());
        data.setFoundFinishedCount(dashboardMapper.selectFoundFinishedCount());
        data.setFoundOngoingCount(dashboardMapper.selectFoundOngoingCount());

        // 2) 분실물
        data.setLostTotalCount(dashboardMapper.selectLostTotalCount());
        data.setLostFinishedCount(dashboardMapper.selectLostFinishedCount());
        data.setLostOngoingCount(dashboardMapper.selectLostOngoingCount());

        // 3) 지역 통계
        data.setFoundRegionStats(dashboardMapper.selectFoundRegionStats());
        data.setLostRegionStats(dashboardMapper.selectLostRegionStats());

        // 4) 월별 업로드 통계
        data.setFoundMonthlyStats(dashboardMapper.selectFoundMonthlyStats());
        data.setLostMonthlyStats(dashboardMapper.selectLostMonthlyStats());

        // 5) 새로운 통계
        data.setTotalUserCount(dashboardMapper.selectTotalUserCount());
        data.setBannedUserCount(dashboardMapper.selectBannedUserCount());
        data.setReportCount(dashboardMapper.selectReportCount());
        data.setSuccessfulChatCount(dashboardMapper.selectSuccessfulChatCount());


        model.addAttribute("data", data);

        return "dashboard/dashboard";
        // => /WEB-INF/views/dashboard/dashboard.jsp
    }

    @GetMapping("/number")
    public String showNumberDashboard(Model model) {
        DashboardVO data = new DashboardVO();

        // 1) 습득물
        data.setFoundTotalCount(dashboardMapper.selectFoundTotalCount());
        data.setFoundFinishedCount(dashboardMapper.selectFoundFinishedCount());
        data.setFoundOngoingCount(dashboardMapper.selectFoundOngoingCount());

        // 2) 분실물
        data.setLostTotalCount(dashboardMapper.selectLostTotalCount());
        data.setLostFinishedCount(dashboardMapper.selectLostFinishedCount());
        data.setLostOngoingCount(dashboardMapper.selectLostOngoingCount());

        // 3) 지역 통계
        data.setFoundRegionStats(dashboardMapper.selectFoundRegionStats());
        data.setLostRegionStats(dashboardMapper.selectLostRegionStats());

        // 4) 월별 업로드 통계
        data.setFoundMonthlyStats(dashboardMapper.selectFoundMonthlyStats());
        data.setLostMonthlyStats(dashboardMapper.selectLostMonthlyStats());

        // 5) 새로운 통계
        data.setTotalUserCount(dashboardMapper.selectTotalUserCount());
        data.setBannedUserCount(dashboardMapper.selectBannedUserCount());
        data.setReportCount(dashboardMapper.selectReportCount());
        data.setSuccessfulChatCount(dashboardMapper.selectSuccessfulChatCount());


        model.addAttribute("data", data);

        return "dashboard/number";
        // => /WEB-INF/views/dashboard/number.jsp
    }
}