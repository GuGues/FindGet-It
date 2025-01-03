package com.get.android;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.get.lost.LostMapper;
import com.get.lost.lostCustomVo;

@RestController
public class androidController {

    @Autowired
    private LostMapper lostMapper;

    @GetMapping("/app/lostList")
    public ResponseEntity<List<lostCustomVo>> appLostList(@RequestParam(value = "page", defaultValue = "1") int page){
    	int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        
		//분실물 전체 리스트
		List<lostCustomVo> lostList = lostMapper.getLostList(arg0, recordsPerPage);
		
        return ResponseEntity.ok(lostList);
    }
}