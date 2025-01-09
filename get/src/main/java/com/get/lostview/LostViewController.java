package com.get.lostview;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;


@Controller
@RequestMapping("/lost")
public class LostViewController {

    @Autowired
    private LostViewMapper lostViewMapper;
    
    @Value("${server.img.url}")
    private String severUrl;


    @GetMapping("/view")
    public String lostView(@RequestParam("lostIdx") String lostIdx, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = null;

        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                email = ((UserDetails) principal).getUsername(); // 이메일 또는 사용자 ID
            } else if (principal instanceof String) {
                email = (String) principal;
            }
        }
        
        String filePath = lostViewMapper.getFilePath(lostIdx);
        if( filePath != null) {
        	filePath = filePath.replace("\\", "/");
        	filePath = filePath.split("Desktop/")[1];
        	
        	model.addAttribute("filePath", filePath);
            model.addAttribute("severUrl", severUrl);
        }

        LostItemVO item = lostViewMapper.selectLostItemDetail(lostIdx);

        model.addAttribute("item", item);
        model.addAttribute("loginEmail", email);
        System.out.println(filePath);
        // =============== 조회수 증가 로직 추가 ===============
        // 로그인한 사용자인 경우 && 중복조회 방지
        if (email != null && !email.equals("anonymousUser")) {
            @SuppressWarnings("unchecked")
            Set<String> viewedLostSet = (Set<String>) session.getAttribute("alreadyViewedLost");
            if (viewedLostSet == null) {
                viewedLostSet = new HashSet<>();
            }
            // 만약 현재 lostIdx가 세션에 없다면
            if (!viewedLostSet.contains(lostIdx)) {
                // DB 조회수 + 1
                lostViewMapper.updateLostViews(lostIdx);
                // 세션 Set에 추가
                viewedLostSet.add(lostIdx);
                session.setAttribute("alreadyViewedLost", viewedLostSet);

                // 최신 조회수 반영 위해 다시 select (선택사항)
                // LostItemVO updatedItem = lostViewMapper.selectLostItemDetail(lostIdx);
                // model.addAttribute("item", updatedItem);
            }
        }





        return "lost/view";
        // 예: /WEB-INF/views/lost/view.jsp (View Resolver 설정에 따라 달라질 수 있음)
    }

    @GetMapping("/write")
    public String lostWriteForm(Model model, Principal principal) {
        // 1) 지역, 색상, 물품 목록 조회
        List<Map<String, Object>> locations = lostViewMapper.selectLocations();
        List<Map<String, Object>> colors = lostViewMapper.selectColors();
        List<Map<String, Object>> items = lostViewMapper.selectItems();

        model.addAttribute("locations", locations);
        model.addAttribute("colors", colors);
        model.addAttribute("items", items);

        // 2) 현재 로그인된 사용자의 email 구하기 (없으면 guest@example.com)
        String email = (principal != null) ? principal.getName() : "guest@example.com";

        // 3) DB에서 해당 email로 회원정보(닉네임) 조회
        Map<String, Object> memberInfo = lostViewMapper.selectMemberByEmail(email);

        // 닉네임이 있으면 사용, 없으면 GUEST
        String nickname = "GUEST";
        if (memberInfo != null && memberInfo.get("NICKNAME") != null) {
            nickname = memberInfo.get("NICKNAME").toString();
        }

        // 4) JSP에서 읽기 전용으로 보여줄 닉네임, 실제 DB 저장에 사용할 이메일
        model.addAttribute("userEmail", email);
        model.addAttribute("userNickname", nickname);

        return "lost/write";
        // 예: /WEB-INF/views/lost/write.jsp
    }


    @PostMapping("/write")
    @Transactional
    public String lostWriteSubmit(LostItemVO vo) {
        // 기본값 설정 (분실물 상태 등)
        vo.setLostState(2);

        // DB 등록
        lostViewMapper.insertLostItem(vo);

        // 등록 후 목록 페이지로 이동
        return "redirect:/lost";
    }


    @GetMapping("/list")
    public String lostList() {
        // 분실물 목록 페이지 로직 (생략)
        return "lost/list";
        // 예: /WEB-INF/views/lost/list.jsp
    }

    @GetMapping("/update")
    public String lostUpdateForm(@RequestParam("lostIdx") String lostIdx,
                                  Model model,
                                  Principal principal) {
        // 1) DB에서 기존 데이터 조회
        LostItemVO item = lostViewMapper.selectLostItemDetail(lostIdx);
        if (item == null) {
            // 예외 처리 또는 목록으로 리다이렉트
            return "redirect:/lost";
        }

        // 2) 본인 작성글인지 체크
        String loginEmail = (principal != null) ? principal.getName() : null;
        if (loginEmail == null || !loginEmail.equals(item.getEmail())) {
            // 작성자와 로그인 사용자가 다르면 수정 불가 -> 에러 페이지 or 목록 이동
            return "redirect:/lost";
        }

        // 3) 지역, 색상, 물품 목록 조회(수정화면 select 박스에 필요)
        List<Map<String, Object>> locations = lostViewMapper.selectLocations();
        List<Map<String, Object>> colors = lostViewMapper.selectColors();
        List<Map<String, Object>> items = lostViewMapper.selectItems();

        model.addAttribute("locations", locations);
        model.addAttribute("colors", colors);
        model.addAttribute("items", items);

        // 4) 수정 화면에 보여줄 원본 데이터
        model.addAttribute("item", item);

        // 수정 화면
        return "lost/update";
    }


    // 찾음 버튼
    @PostMapping("/complete")
    @Transactional
    public String markAsFound(@RequestParam("lostIdx") String lostIdx, @RequestParam("email") String email, HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginEmail = null;

        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                loginEmail = ((UserDetails) principal).getUsername();
            } else if (principal instanceof String) {
                loginEmail = (String) principal;
            }
        }

        if (loginEmail != null && loginEmail.equals(email)) {
            lostViewMapper.updateLostState(lostIdx, 1); // 상태를 1로 변경
        }
        return "redirect:/lost/view?lostIdx=" + lostIdx;
    }

    // 찾음 취소
    @PostMapping("/cancel")
    @Transactional
    public String cancelFound(@RequestParam("lostIdx") String lostIdx, @RequestParam("email") String email) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginEmail = null;

        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                loginEmail = ((UserDetails) principal).getUsername();
            } else if (principal instanceof String) {
                loginEmail = (String) principal;
            }
        }

        if (loginEmail != null && loginEmail.equals(email)) {
            lostViewMapper.updateLostState(lostIdx, 2); // 상태를 "찾는 중(2)"으로 변경
        }
        return "redirect:/lost/view?lostIdx=" + lostIdx;
    }




    @PostMapping("/update")
    @Transactional
    public String lostUpdateSubmit(LostItemVO vo, Principal principal) {
        // DB에서 기존 데이터 다시 조회(본인글인지 최종 체크)
        LostItemVO dbItem = lostViewMapper.selectLostItemDetail(vo.getLostIdx());
        if (dbItem == null) {
            return "redirect:/lost"; // or 에러 처리
        }

        // 로그인 사용자와 작성자 동일해야
        String loginEmail = (principal != null) ? principal.getName() : null;
        if (loginEmail == null || !loginEmail.equals(dbItem.getEmail())) {
            return "redirect:/lost"; // 수정 권한 없음
        }

        // vo에는 JSP에서 넘겨준 수정 데이터들이 들어있음
        // DB update
        lostViewMapper.updateLostItem(vo);

        // 수정 후 상세보기 페이지로 이동
        return "redirect:/lost/view?lostIdx=" + vo.getLostIdx();
    }


    // 분실물 처리 절차
    @GetMapping("/process")
    public String lostProcess() {
        // 뷰(JSP) 파일: src/main/webapp/WEB-INF/views/lost/process.jsp 로 이동
        return "lost/process";
    }





}