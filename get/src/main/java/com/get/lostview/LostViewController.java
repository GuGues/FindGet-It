package com.get.lostview;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class LostViewController {

    @Autowired
    private LostViewMapper lostViewMapper;

    @GetMapping("/lost/view")
    public String lostView(@RequestParam("lostIdx") String lostIdx, Model model) {
        LostItemVO item = lostViewMapper.selectLostItemDetail(lostIdx);
        model.addAttribute("item", item);
        return "lost/view";
    }

    @GetMapping("/lost/write")
    public String lostWriteForm(Model model) {
        // 지역, 색상 목록 조회
        List<Map<String, Object>> locations = lostViewMapper.selectLocations();
        List<Map<String, Object>> colors = lostViewMapper.selectColors();
        List<Map<String, Object>> items = lostViewMapper.selectItems();

        model.addAttribute("locations", locations);
        model.addAttribute("colors", colors);
        model.addAttribute("items", items);

        return "lost/write"; // WEB-INF/views/lost/write.jsp
    }

    @PostMapping("/lost/write")
    public String lostWriteSubmit(LostItemVO vo, Principal principal) {
        // 로그인한 이메일 정보를 vo에 셋팅 (실제 구현시 SecurityContextHolder 등에서 가져올 수 있음)
        String userEmail = (principal != null) ? principal.getName() : "guest@example.com";
        vo.setEmail(userEmail);
        vo.setLostState(2); // 기본값

        lostViewMapper.insertLostItem(vo);
        return "redirect:/lost/list";
    }

    // AJAX로 대분류 카테고리 반환
    //@GetMapping("/getBigCate")
    //@ResponseBody
    //public List<Map<String, Object>> getBigCate(){
    //   return lostViewMapper.getBigItems();
    //}

    // AJAX로 선택한 대분류 코드 기반 소분류 반환
    //@GetMapping("/getCate")
    //@ResponseBody
    //public List<Map<String, Object>> getCate(@RequestParam("item_code") String code){
    //    return lostViewMapper.getItems(code);
    //}
}