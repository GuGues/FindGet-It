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

    /**
     * 모바일 앱에서 검색할 때 사용:
     * /appSearch/result?keyword=OOO
     */
    @GetMapping("/result")
    public Map<String, Object> searchAll(@RequestParam("keyword") String keyword) {

        // (1) 분실물 전체 검색 (페이징 X, 간단 예시)
        // 필요하다면 기존 searchLostItems를 그대로 쓰고, offset/limit을 0~큰값으로 설정할 수도 있음
        List<LostItemVo> lostItems = searchMapper.searchLostItems(keyword, 0, 99999);

        // (2) 습득물 전체 검색
        List<FoundItemVo> foundItems = searchMapper.searchFoundItems(keyword, 0, 99999);

        // (3) 경찰 습득물 전체 검색
        List<PoliceFoundVo> policeItems = searchMapper.searchPoliceFoundItems(keyword, 0, 99999);

        // JSON 형식으로 묶어서 반환
        Map<String, Object> result = new HashMap<>();
        result.put("lostItems", lostItems);
        result.put("foundItems", foundItems);
        result.put("policeItems", policeItems);

        return result; // => JSON으로 변환되어 반환
    }
}