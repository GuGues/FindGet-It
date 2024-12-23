package com.get.foundview;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FoundViewController {

    @Autowired
    private FoundViewMapper foundViewMapper;

    @GetMapping("/found/view")
    public String foundView(@RequestParam("foundIdx") String foundIdx, Model model) {
        FoundItemVO item = foundViewMapper.selectFoundItemDetail(foundIdx);
        model.addAttribute("item", item);
        return "found/view";
    }
}