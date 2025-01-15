package com.get.android;

import com.get.search.FoundItemVo;
import com.get.search.LostItemVo;
import com.get.search.PoliceFoundVo;
import com.get.search.SearchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/appSearch")
public class AppSearchController {

    @Autowired
    private SearchMapper searchMapper;

    // 페이지당 표시할 레코드 수
    private static final int PAGE_SIZE = 8;

    /**
     * 예) GET /appSearch/result?keyword=키워드&lostPage=1&foundPage=1&policePage=1
     */
    @GetMapping("/result")
    public Map<String, Object> searchAll(
            @RequestParam("keyword") String keyword,
            @RequestParam(value="lostPage", defaultValue="1") int lostPage,
            @RequestParam(value="foundPage", defaultValue="1") int foundPage,
            @RequestParam(value="policePage", defaultValue="1") int policePage
    ) {
        // ------ 분실물 (LOST_ITEMS) ------
        int lostTotal = searchMapper.countLostItems(keyword);
        int lostTotalPages = (int) Math.ceil((double) lostTotal / PAGE_SIZE);
        int lostOffset = (lostPage - 1) * PAGE_SIZE;
        List<LostItemVo> lostItems = searchMapper.searchLostItems(keyword, lostOffset, PAGE_SIZE);

        // ------ 습득물 (FOUND) ------
        int foundTotal = searchMapper.countFoundItems(keyword);
        int foundTotalPages = (int) Math.ceil((double) foundTotal / PAGE_SIZE);
        int foundOffset = (foundPage - 1) * PAGE_SIZE;
        List<FoundItemVo> foundItems = searchMapper.searchFoundItems(keyword, foundOffset, PAGE_SIZE);

        // ------ 경찰 습득물 (POLICE_FOUND) ------
        int policeTotal = searchMapper.countPoliceFoundItems(keyword);
        int policeTotalPages = (int) Math.ceil((double) policeTotal / PAGE_SIZE);
        int policeOffset = (policePage - 1) * PAGE_SIZE;
        List<PoliceFoundVo> policeItems = searchMapper.searchPoliceFoundItems(keyword, policeOffset, PAGE_SIZE);

        // JSON으로 반환할 최상위 Map
        Map<String, Object> result = new HashMap<>();

        // (1) 분실물
        Map<String, Object> lostData = new HashMap<>();
        lostData.put("items", lostItems);
        lostData.put("currentPage", lostPage);
        lostData.put("totalPages", lostTotalPages);
        lostData.put("totalRecords", lostTotal);
        result.put("lostPageData", lostData);

        // (2) 습득물
        Map<String, Object> foundData = new HashMap<>();
        foundData.put("items", foundItems);
        foundData.put("currentPage", foundPage);
        foundData.put("totalPages", foundTotalPages);
        foundData.put("totalRecords", foundTotal);
        result.put("foundPageData", foundData);

        // (3) 경찰 습득물
        Map<String, Object> policeData = new HashMap<>();
        policeData.put("items", policeItems);
        policeData.put("currentPage", policePage);
        policeData.put("totalPages", policeTotalPages);
        policeData.put("totalRecords", policeTotal);
        result.put("policePageData", policeData);

        return result;
    }
}