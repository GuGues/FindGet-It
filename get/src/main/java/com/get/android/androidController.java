package com.get.android;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.get.lost.LostMapper;
import com.get.lost.lostVo;

@RestController
public class androidController {

    @Autowired
    private LostMapper lostMapper;

    @GetMapping("/app/lostList")
    public ResponseEntity<List<lostVo>> appLostList(){
        System.out.println("hi");
        List<lostVo> lostList = lostMapper.getAppLostList();
        return ResponseEntity.ok(lostList);
    }
}