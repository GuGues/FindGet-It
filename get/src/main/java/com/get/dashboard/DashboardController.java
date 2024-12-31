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

        model.addAttribute("data", data);

        return "dashboard/dashboard";
        // => /WEB-INF/views/dashboard/dashboard.jsp
    }
}