package com.get.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class CenterSearchController {

    @Autowired
    private SearchMapper searchMapper;

    private static final int RECORDS_PER_PAGE = 10;

    @GetMapping("/search")
    public ModelAndView search(@RequestParam("keyword") String keyword,
                               @RequestParam(value="lostPage", defaultValue="1") int lostPage,
                               @RequestParam(value="foundPage", defaultValue="1") int foundPage,
                               // === 경찰 습득물 페이징 추가 ===
                               @RequestParam(value="policePage", defaultValue="1") int policePage) {

        ModelAndView mv = new ModelAndView("searchresult/searchResult");

        // LOST_ITEMS 페이징 처리
        int totalLostRecords = searchMapper.countLostItems(keyword);
        PagingHelper lostPaging = new PagingHelper(totalLostRecords, lostPage, RECORDS_PER_PAGE);
        List<LostItemVo> lostItems = searchMapper.searchLostItems(keyword, lostPaging.getStartRecord(), RECORDS_PER_PAGE);
        mv.addObject("lostItems", lostItems);
        mv.addObject("lostPaging", lostPaging);

        // FOUND 페이징 처리
        int totalFoundRecords = searchMapper.countFoundItems(keyword);
        PagingHelper foundPaging = new PagingHelper(totalFoundRecords, foundPage, RECORDS_PER_PAGE);
        List<FoundItemVo> foundItems = searchMapper.searchFoundItems(keyword, foundPaging.getStartRecord(), RECORDS_PER_PAGE);
        mv.addObject("foundItems", foundItems);
        mv.addObject("foundPaging", foundPaging);

        // === 경찰 습득물 POLICE_FOUND 페이징 처리 추가 ===
        int totalPoliceFoundRecords = searchMapper.countPoliceFoundItems(keyword);
        PagingHelper policePaging = new PagingHelper(totalPoliceFoundRecords, policePage, RECORDS_PER_PAGE);
        List<PoliceFoundVo> policeItems = searchMapper.searchPoliceFoundItems(keyword, policePaging.getStartRecord(), RECORDS_PER_PAGE);
        mv.addObject("policeItems", policeItems);
        mv.addObject("policePaging", policePaging);

        mv.addObject("keyword", keyword);

        return mv;
    }
}
