package com.get.foundview;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.get.alarm.AlarmService;
import com.get.alarm.AlarmVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



import java.security.Principal;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/found")
public class FoundViewController {


    @Autowired
    private FoundViewMapper foundViewMapper;
    @Autowired
    private AlarmService alarmService;

    @Value("${server.img.url}")
    private String severUrl;

    /**
     * 습득물 상세 보기
     */
    @GetMapping("/view")
    public String foundView(@RequestParam("foundIdx") String foundIdx, Model model, HttpServletRequest request) {
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
        
        String filePath = foundViewMapper.getFoundFilePath(foundIdx);
        if( filePath != null) {
        	filePath = filePath.replace("\\", "/");
        	filePath = filePath.split("Desktop/")[1];
        	
        	model.addAttribute("filePath", filePath);
            model.addAttribute("severUrl", severUrl);
        }


        FoundItemVO item = foundViewMapper.selectFoundItemDetail(foundIdx);
        model.addAttribute("item", item);


        // ☆ 이 부분이 중요: 현재 로그인 이메일을 model에 추가
        model.addAttribute("loginEmail", email);


        // =============== 조회수 증가 로직 추가 ===============
        // 로그인한 사용자인 경우 && 중복조회 방지
        if (email != null && !email.equals("anonymousUser")) {
            // 세션에서 alreadyViewedFound 라는 Set<String> 가져옴
            @SuppressWarnings("unchecked")
            Set<String> viewedFoundSet = (Set<String>) session.getAttribute("alreadyViewedFound");
            if (viewedFoundSet == null) {
                viewedFoundSet = new HashSet<>();
            }

            // 만약 현재 foundIdx가 세션에 없다면
            if (!viewedFoundSet.contains(foundIdx)) {
                // DB 조회수 + 1
                foundViewMapper.updateFoundViews(foundIdx);
                // 세션 Set에 추가
                viewedFoundSet.add(foundIdx);
                session.setAttribute("alreadyViewedFound", viewedFoundSet);

                // 최신 조회수 반영 위해 다시 select (선택사항)
                // FoundItemVO updatedItem = foundViewMapper.selectFoundItemDetail(foundIdx);
                // model.addAttribute("item", updatedItem);
            }
        }
        // ===============================================





        return "found/view";
    }

    /**
     * 습득물 작성 폼
     */
    @GetMapping("/write")
    public String foundWriteForm(Model model, Principal principal) {
        // 지역, 색상, 물품 목록 조회
        List<Map<String, Object>> locations = foundViewMapper.selectLocations();
        List<Map<String, Object>> colors = foundViewMapper.selectColors();
        List<Map<String, Object>> items = foundViewMapper.selectItems();

        model.addAttribute("locations", locations);
        model.addAttribute("colors", colors);
        model.addAttribute("items", items);

        // 로그인 정보
        String email = (principal != null) ? principal.getName() : "guest@example.com";

        // 닉네임 조회
        Map<String, Object> memberInfo = foundViewMapper.selectMemberByEmail(email);
        String nickname = "GUEST";
        if (memberInfo != null && memberInfo.get("NICKNAME") != null) {
            nickname = memberInfo.get("NICKNAME").toString();
        }




        model.addAttribute("userEmail", email);
        model.addAttribute("userNickname", nickname);

        return "found/write";
    }

    /**
     * 습득물 등록 처리
     */
    @PostMapping("/write")
    @Transactional
    public String foundWriteSubmit(FoundItemVO vo) {
        // 기본값 설정
        vo.setFoundState(2);
        // DB 등록
        foundViewMapper.insertFoundItem(vo);
        alarmService.saveFoundAlarm(vo);
        // 목록 페이지로 이동(예: /found)
        return "redirect:/found";
    }

    /**
     * 습득물 수정 폼 (본인 작성글인지 체크)
     */
    @GetMapping("/update")
    public String foundUpdateForm(@RequestParam("foundIdx") String foundIdx,
                                  Model model,
                                  Principal principal) {
        // 1) DB에서 기존 데이터 조회
        FoundItemVO item = foundViewMapper.selectFoundItemDetail(foundIdx);
        if (item == null) {
            // 예외 처리 또는 목록으로 리다이렉트
            return "redirect:/found";
        }

        // 2) 본인 작성글인지 체크
        String loginEmail = (principal != null) ? principal.getName() : null;
        if (loginEmail == null || !loginEmail.equals(item.getEmail())) {
            // 작성자와 로그인 사용자가 다르면 수정 불가 -> 에러 페이지 or 목록 이동
            return "redirect:/found";
        }

        // 3) 지역, 색상, 물품 목록 조회(수정화면 select 박스에 필요)
        List<Map<String, Object>> locations = foundViewMapper.selectLocations();
        List<Map<String, Object>> colors = foundViewMapper.selectColors();
        List<Map<String, Object>> items = foundViewMapper.selectItems();

        model.addAttribute("locations", locations);
        model.addAttribute("colors", colors);
        model.addAttribute("items", items);

        // 4) 수정 화면에 보여줄 원본 데이터
        model.addAttribute("item", item);

        // 수정 화면
        return "found/update";
    }

    /**
     * 습득물 수정 처리
     */
    @PostMapping("/update")
    @Transactional
    public String foundUpdateSubmit(FoundItemVO vo, Principal principal) {
        // DB에서 기존 데이터 다시 조회(본인글인지 최종 체크)
        FoundItemVO dbItem = foundViewMapper.selectFoundItemDetail(vo.getFoundIdx());
        if (dbItem == null) {
            return "redirect:/found"; // or 에러 처리
        }

        // 로그인 사용자와 작성자 동일해야
        String loginEmail = (principal != null) ? principal.getName() : null;
        if (loginEmail == null || !loginEmail.equals(dbItem.getEmail())) {
            return "redirect:/found"; // 수정 권한 없음
        }

        // vo에는 JSP에서 넘겨준 수정 데이터들이 들어있음
        // DB update
        foundViewMapper.updateFoundItem(vo);

        // 수정 후 상세보기 페이지로 이동
        return "redirect:/found/view?foundIdx=" + vo.getFoundIdx();
    }

}