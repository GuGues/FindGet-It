package com.get.mypage;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class MypageController {

    @Autowired
    private MypageMapper mypageMapper;

    @GetMapping("/api/example")
    public ResponseEntity<String> example() {
        return ResponseEntity.ok("Success");
    }
   
    
   
    
}