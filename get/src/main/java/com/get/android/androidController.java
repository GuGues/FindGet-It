package com.get.android;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletionService;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.get.android.member.Member;
import com.get.android.member.MemberMapper;
import com.get.chat.Chat;
import com.get.chat.ChatMapper;
import com.get.chat.ChatRoom;
import com.get.chat.ChatService;
import com.get.faq.FaqMapper;
import com.get.faq.csVo;
import com.get.found.FoundMapper;
import com.get.found.foundCustomVo;
import com.get.foundview.FoundItemVO;
import com.get.foundview.FoundViewMapper;
import com.get.lost.lostCustomVo;
import com.get.lostview.LostItemVO;
import com.get.lostview.LostViewMapper;
import com.get.notice.NoticeMapper;
import com.get.notice.noticeVo;
import com.get.police.PoliceMapper;
import com.get.police.PoliceVo;
import com.get.search.FoundItemVo;
import com.get.search.LostItemVo;
import com.get.search.PoliceFoundVo;
import com.get.vo.faqVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import com.get.lost.LostMapper;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class androidController {

    @Autowired
    private LostMapper lostMapper;
    @Autowired
    private FoundMapper foundMapper;
    @Autowired
    private ChatMapper chatMapper;
    @Autowired
    private ChatService chatService;
    @Autowired
    private FaqMapper faqMapper;
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private LostViewMapper lostViewMapper;
    @Autowired
    private FlutterMapper flutterMapper;

    @Value("${server.img.url}")
    private String serverUrl;

    @Autowired
    private FoundViewMapper foundViewMapper;
    @Autowired
    private PoliceMapper policeMapper;

    private static final int PAGE_SIZE = 5;

    @GetMapping("/app/lostList")
    public ResponseEntity<Map<String, Object>> appLostList(@RequestParam(value = "page", defaultValue = "1") int page) {
        int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산

        //분실물 전체 리스트
        List<lostCustomVo> lostList = lostMapper.getLostList(arg0, recordsPerPage);
        int lostTotal = lostMapper.getTotalLostCount();
        int pageCnt = lostTotal / recordsPerPage;
        if (lostTotal % recordsPerPage != 0) {
            pageCnt += 1;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("lostList", lostList);
        result.put("pageCnt", pageCnt);
        return ResponseEntity.ok(result);
    }

    @GetMapping("/app/chatting-roomList/{email}")
    public ResponseEntity<Map<String, Object>> appChatList(@PathVariable("email") String email) {
        Map<String, Object> map = chatService.findRoomByEmail(email);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/app/roomInfo/{chatting_no}")
    public ResponseEntity<Map<String, Object>> getInitInfo(@PathVariable("chatting_no") String chatting_no) {
        Map<String, Object> map = new HashMap<>();
        ChatRoom room = chatService.findRoomByIdx(chatting_no);
        map.put("chatting_no", chatting_no);
        map.put("room", room);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/app/get-chatting/{chatting_no}")
    public ResponseEntity<List<Chat>> getChattingInfo(@PathVariable("chatting_no") String chatting_no) {
        List<Chat> chatList = chatService.findAllChatReverse(chatting_no);
        return ResponseEntity.ok(chatList);
    }

    @PostMapping("/app/chatting/update-view")
    public ResponseEntity<Map<String, Object>> updateView(@RequestBody HashMap<String, Object> params) {
        System.out.println("updateVIew!!!!!!!!!");
        String chatting_no = String.valueOf(params.get("chatting_no"));
        String email = String.valueOf(params.get("email"));
        chatService.updateMessageViewed(chatting_no, email);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/app/chatting/update-location")
    public ResponseEntity<Map<String, Object>> updateLocation(@RequestBody HashMap<String, Object> params) {
        String open_member_permission = String.valueOf(params.get("open_member_permission"));
        System.out.println(open_member_permission);
        if (open_member_permission != "null") {
            String open_member = String.valueOf(params.get("open_member"));
            String chatting_no = String.valueOf(params.get("chatting_no"));
            Double open_member_lat = Double.parseDouble(String.valueOf(params.get("open_member_lat")));
            Double open_member_lng = Double.parseDouble(String.valueOf(params.get("open_member_lng")));
            chatMapper.updateOpenerLocation(open_member, open_member_permission, open_member_lat, open_member_lng, chatting_no);
        } else {
            String participant = String.valueOf(params.get("participant"));
            String chatting_no = String.valueOf(params.get("chatting_no"));
            String participant_permission = String.valueOf(params.get("participant_permission"));
            Double participant_lat = Double.parseDouble(String.valueOf(params.get("participant_lat")));
            Double participant_lng = Double.parseDouble(String.valueOf(params.get("participant_lng")));
            chatMapper.updateParticipantLocation(participant, participant_permission, participant_lat, participant_lng, chatting_no);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/app/chatting/get-location")
    public ResponseEntity<Map<String, Double>> getLocation(@RequestBody HashMap<String, Object> params) {
        String email = String.valueOf(params.get("email"));
        String chatting_no = String.valueOf(params.get("chatting_no"));
        Map<String, Double> result = chatService.getLocation(email, chatting_no);
        System.out.println(result);
        return ResponseEntity.ok().body(result);
    }


    @GetMapping("/app/faqList")
    public ResponseEntity<List<faqVo>> appFaqList() {
        List<faqVo> faqList = faqMapper.getFaqList();
        return ResponseEntity.ok(faqList);
    }

    @GetMapping("/app/noticeList")
    public ResponseEntity<List<noticeVo>> appNoticeList() {
        List<noticeVo> noticeList = noticeMapper.getAllNoticeList();
        return ResponseEntity.ok(noticeList);
    }

    @GetMapping("/app/getLostSearch")
    public ResponseEntity<Map<String,Object>> getLostSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page) {
        System.out.println("searchLost map : " + map);
        int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        map.put("arg0", String.valueOf(arg0));
        map.put("arg1", String.valueOf(recordsPerPage));
        System.out.println(map);
        //{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
        List<lostCustomVo> searchLost = lostMapper.getSearchLost(map);
        Map<String,Object> result = new HashMap<>();
        int foundTotal = lostMapper.getTotalSearchLostCount(map);
        int pageCnt = foundTotal / recordsPerPage;
        if (foundTotal % recordsPerPage != 0) {
            pageCnt += 1;
        }

        result.put("searchLost",searchLost);
        result.put("pageCnt",pageCnt);
        return ResponseEntity.ok(result);
    }


    @GetMapping("/app/lostInsert/{email}")
    public ResponseEntity<Member> appLostInsert(@PathVariable(name = "email") String email) {
        Member member = memberMapper.findByEmail(email);
        System.out.println("==============" + member);
        return ResponseEntity.ok(member);
    }

    @GetMapping("/app/foundInsert/{email}")
    public ResponseEntity<Member> appFoundInsert(@PathVariable(name = "email") String email) {
        Member member = memberMapper.findByEmail(email);
        System.out.println("==============" + member);
        return ResponseEntity.ok(member);
    }


    @PostMapping("/app/lostInsert/insert")
    public ResponseEntity<LostItemVO> appLostInsertPost(@RequestParam Map<String, String> map, @RequestParam(value = "image", required = false) MultipartFile[] image) throws IOException {
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        if (image != null) {
            ByteArrayResource contentsAsResource = new ByteArrayResource(image[0].getBytes()) {
                @Override
                public String getFilename() {
                    return image[0].getOriginalFilename();
                }
            };
            body.add("uploadFile", contentsAsResource);
        }
        map.forEach(body::add);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        try {
            restTemplate.postForEntity(serverUrl + "/lost/insert", requestEntity, Void.class);
        } catch (Exception e) {
            System.out.println(e);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/app/foundInsert/insert")
    public ResponseEntity<FoundItemVO> appFoundInsertPost(@RequestParam Map<String, String> map, @RequestParam(value = "image", required = false) MultipartFile[] image) throws IOException {
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        if (image != null) {
            ByteArrayResource contentsAsResource = new ByteArrayResource(image[0].getBytes()) {
                @Override
                public String getFilename() {
                    return image[0].getOriginalFilename();
                }
            };
            body.add("uploadFile", contentsAsResource);
        }
        map.forEach(body::add);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        try {
            restTemplate.postForEntity(serverUrl + "/found/insert", requestEntity, Void.class);
        } catch (Exception e) {
            System.out.println(e);
        }
        return ResponseEntity.ok().build();
    }


    @GetMapping("/app/lostUpdate/{email}")
    public ResponseEntity<Member> appLostUpdate(@PathVariable(name = "email") String email) {
        Member member = memberMapper.findByEmail(email);
        System.out.println("==============" + member);
        return ResponseEntity.ok(member);
    }

    @GetMapping("/app/lostUpdate/get-lost/{lostIdx}")
    public ResponseEntity<Map<String, Object>> appLostGetUpdate(@PathVariable(name = "lostIdx") String lostIdx) {
        Map<String, Object> map = flutterMapper.selectLostItem(lostIdx);
        System.out.println("==============" + map);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/app/foundUpdate/{email}")
    public ResponseEntity<Member> appFoundUpdate(@PathVariable(name = "email") String email) {
        Member member = memberMapper.findByEmail(email);
        System.out.println("==============" + member);
        return ResponseEntity.ok(member);
    }

    @GetMapping("/app/foundUpdate/get-found/{foundIdx}")
    public ResponseEntity<Map<String, Object>> appFoundGetUpdate(@PathVariable(name = "foundIdx") String foundIdx) {
        Map<String, Object> map = flutterMapper.selectFoundItem(foundIdx);
        System.out.println("==============" + map);
        return ResponseEntity.ok(map);
    }


    @PostMapping("/app/lostUpdate/update")
    public ResponseEntity<LostItemVO> appLostUpdatePost(@RequestParam Map<String, String> map, @RequestParam(value = "image", required = false) MultipartFile[] image) throws IOException {
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        if (image != null) {
            ByteArrayResource contentsAsResource = new ByteArrayResource(image[0].getBytes()) {
                @Override
                public String getFilename() {
                    return image[0].getOriginalFilename();
                }
            };
            body.add("uploadFile", contentsAsResource);
        }
        map.forEach(body::add);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        try {
            restTemplate.postForEntity(serverUrl + "/lost/update", requestEntity, Void.class);
        } catch (Exception e) {
            System.out.println(e);
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/app/foundUpdate/update")
    public ResponseEntity<LostItemVO> appFoundUpdatePost(@RequestParam Map<String, String> map, @RequestParam(value = "image", required = false) MultipartFile[] image) throws IOException {
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        if (image != null) {
            ByteArrayResource contentsAsResource = new ByteArrayResource(image[0].getBytes()) {
                @Override
                public String getFilename() {
                    return image[0].getOriginalFilename();
                }
            };
            body.add("uploadFile", contentsAsResource);
        }
        map.forEach(body::add);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
        System.out.println(map);
        RestTemplate restTemplate = new RestTemplate();
        try {
            restTemplate.postForEntity(serverUrl + "/found/update", requestEntity, Void.class);
        } catch (Exception e) {
            System.out.println(e);
        }
        return ResponseEntity.ok().build();
    }

    /**
     * (1) 분실물 상세 조회
     *  GET /app/getLostItem/{lostIdx}
     */
    @GetMapping("/app/getLostItem/{lostIdx}")
    public ResponseEntity<Map<String, Object>> getLostItem(@PathVariable("lostIdx") String lostIdx) {

        // (a) DB에서 filePath 가져오기 (분실물 이미지 경로 등)
        String filePath = lostViewMapper.getFilePath(lostIdx);
        String finalPath = "";
        if (filePath != null && !filePath.isEmpty()) {
            // Windows 경로라면 역슬래시(\) → 슬래시(/)
            filePath = filePath.replace("\\", "/");
            // 만약 Desktop/ 라는 경로가 포함되어 있다면 이후 부분만 자르기
            if (filePath.contains("Desktop/")) {
                // 예: C:/Users/xxx/Desktop/upload/myImage.jpg
                filePath = filePath.split("Desktop/")[1];
                // 결과: upload/myImage.jpg
            }
            finalPath = filePath;
        }

        // (b) 분실물 상세 정보 얻기
        LostItemVO vo = lostViewMapper.selectLostItemDetail(lostIdx);
        if (vo == null) {
            return ResponseEntity.notFound().build();
        }

        // (c) 결과 Map 구성
        //     → JSON 응답 시 { "lostItem": {...}, "filePath": "...", "serverUrl": "..." }
        Map<String, Object> result = new HashMap<>();
        result.put("lostItem", vo);        // 실제 분실물 VO
        result.put("filePath", finalPath); // 최종 파일 경로
        result.put("serverUrl", serverUrl); // 서버의 이미지 경로 prefix (ex: http://192.168.0.214:9090)

        return ResponseEntity.ok(result);
    }

    /**
     * (2) 습득물 상세 조회
     * 예) GET /app/getFoundItem/{foundIdx}
     */
    @GetMapping("/app/getFoundItem/{foundIdx}")
    public ResponseEntity<Map<String, Object>> getFoundItem(@PathVariable("foundIdx") String foundIdx) {


        // (a) DB에서 filePath 가져오기 (분실물 이미지 경로 등)
        String filePath = foundViewMapper.getFoundFilePath(foundIdx);
        String finalPath = "";
        if (filePath != null && !filePath.isEmpty()) {
            // Windows 경로라면 역슬래시(\) → 슬래시(/)
            filePath = filePath.replace("\\", "/");
            // 만약 Desktop/ 라는 경로가 포함되어 있다면 이후 부분만 자르기
            if (filePath.contains("Desktop/")) {
                // 예: C:/Users/xxx/Desktop/upload/myImage.jpg
                filePath = filePath.split("Desktop/")[1];
                // 결과: upload/myImage.jpg
            }
            finalPath = filePath;
        }


        FoundItemVO vo = foundViewMapper.selectFoundItemDetail(foundIdx);
        if (vo == null) {
            return ResponseEntity.notFound().build();
        }

        Map<String, Object> result = new HashMap<>();
        result.put("foundItem", vo);        // 실제 분실물 VO
        result.put("filePath", finalPath); // 최종 파일 경로
        result.put("serverUrl", serverUrl); // 서버의 이미지 경로 prefix (ex: http://192.168.0.214:9090)

        return ResponseEntity.ok(result);
    }

    /**
     * (3) 경찰 습득물 상세 조회
     * 예) GET /app/getPoliceItem/{atcId}
     */
    @GetMapping("/app/getPoliceItem/{atcId}/{fdsn}")
    public ResponseEntity<PoliceVo> getPoliceItem(
            @PathVariable("atcId") String atcId,
            @PathVariable("fdsn") String fdsn
    ) {
        PoliceVo param = new PoliceVo();
        param.setAtcid(atcId);
        param.setFdsn(fdsn);

        PoliceVo vo = policeMapper.selectView(param);
        if (vo == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(vo);
    }


    @GetMapping("/app/foundList")
    public ResponseEntity<Map<String, Object>> appFoundList(@RequestParam(value = "page", defaultValue = "1") int page) {
        int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산

        //분실물 전체 리스트
        List<foundCustomVo> foundList = foundMapper.getFoundList(arg0, recordsPerPage);
        int foundTotal = foundMapper.getTotalFoundCount();
        int pageCnt = foundTotal / recordsPerPage;
        if (foundTotal % recordsPerPage != 0) {
            pageCnt += 1;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("foundList", foundList);
        result.put("pageCnt", pageCnt);
        return ResponseEntity.ok(result);
    }

    @GetMapping("/app/getFoundSearch")
    public ResponseEntity<Map<String, Object>> getFoundSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page) {
        System.out.println("searchLost map : " + map);

        int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        map.put("arg0", String.valueOf(arg0));
        map.put("arg1", String.valueOf(recordsPerPage));

        //{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
        List<foundCustomVo> searchFound = foundMapper.getSearchFound(map);
        int foundTotal = foundMapper.getTotalSearchFoundCount(map);
        int pageCnt = foundTotal / recordsPerPage;
        if (foundTotal % recordsPerPage != 0) {
            pageCnt += 1;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("searchFound", searchFound);
        result.put("pageCnt", pageCnt);
        return ResponseEntity.ok(result);
    }

    //==============================MYPAGE=======================
    @GetMapping("/app/myFound")
    public Map<String, Object> getMyFound(
            @RequestParam("email") String email,
            @RequestParam(value = "findingPage", defaultValue = "1") int findingPage,
            @RequestParam(value = "foundPage", defaultValue = "1") int foundPage,
            @RequestParam(value = "reportPage", defaultValue = "1") int reportPage
    ) {
        // ------ 찾는중 ------
        int findingTotal = flutterMapper.countMyFindingFoundItems(email);
        int findingTotalPages = (int) Math.ceil((double) findingTotal / PAGE_SIZE);
        int findingOffset = (findingPage - 1) * PAGE_SIZE;
        List<FoundItemVo> findingItems = flutterMapper.selectMyFindingFoundItems(email, findingOffset, PAGE_SIZE);

        // ------ FOUND! ------
        int foundTotal = flutterMapper.countMyFoundItems(email);
        int foundTotalPages = (int) Math.ceil((double) foundTotal / PAGE_SIZE);
        int foundOffset = (foundPage - 1) * PAGE_SIZE;
        List<FoundItemVo> foundItems = flutterMapper.selectMyFoundItems(email, foundOffset, PAGE_SIZE);

        // ------ 신고글 ------
        int reportTotal = flutterMapper.countMyFoundReportItems(email);
        int reportTotalPages = (int) Math.ceil((double) reportTotal / PAGE_SIZE);
        int reportOffset = (reportPage - 1) * PAGE_SIZE;
        List<FoundItemVo> reportItems = flutterMapper.selectMyFoundReportItems(email, reportOffset, PAGE_SIZE);

        // JSON으로 반환할 최상위 Map
        Map<String, Object> result = new HashMap<>();

        // (1) 찾는중
        Map<String, Object> findingData = new HashMap<>();
        findingData.put("items", findingItems);
        findingData.put("currentPage", findingPage);
        findingData.put("totalPages", findingTotalPages);
        findingData.put("totalRecords", findingTotal);
        result.put("findingPageData", findingData);

        // (2) FOUND!
        Map<String, Object> foundData = new HashMap<>();
        foundData.put("items", foundItems);
        foundData.put("currentPage", foundPage);
        foundData.put("totalPages", foundTotalPages);
        foundData.put("totalRecords", foundTotal);
        result.put("foundPageData", foundData);

        // (3) 신고글
        Map<String, Object> reportData = new HashMap<>();
        reportData.put("items", reportItems);
        reportData.put("currentPage", reportPage);
        reportData.put("totalPages", reportTotalPages);
        reportData.put("totalRecords", reportTotal);
        result.put("reportPageData", reportData);
        System.out.println(reportItems);
        System.out.println(foundItems);
        System.out.println(findingItems);
        return result;
    }


    @GetMapping("/app/myLost")
    public Map<String, Object> getMyLost(
            @RequestParam("email") String email,
            @RequestParam(value = "findingPage", defaultValue = "1") int findingPage,
            @RequestParam(value = "getPage", defaultValue = "1") int getPage,
            @RequestParam(value = "reportPage", defaultValue = "1") int reportPage
    ) {
        // ------ 찾는중 ------
        int findingTotal = flutterMapper.countMyFindingLostItems(email);
        int findingTotalPages = (int) Math.ceil((double) findingTotal / PAGE_SIZE);
        int findingOffset = (findingPage - 1) * PAGE_SIZE;
        List<LostItemVo> findingItems = flutterMapper.selectMyFindingLostItems(email, findingOffset, PAGE_SIZE);

        // ------ FOUND! ------
        int getTotal = flutterMapper.countMyGetItems(email);
        int getTotalPages = (int) Math.ceil((double) getTotal / PAGE_SIZE);
        int getOffset = (getPage - 1) * PAGE_SIZE;
        List<LostItemVo> getItems = flutterMapper.selectMyGetItems(email, getOffset, PAGE_SIZE);

        // ------ 신고글 ------
        int reportTotal = flutterMapper.countMyLostReportItems(email);
        int reportTotalPages = (int) Math.ceil((double) reportTotal / PAGE_SIZE);
        int reportOffset = (reportPage - 1) * PAGE_SIZE;
        List<LostItemVo> reportItems = flutterMapper.selectMyLostReportItems(email, reportOffset, PAGE_SIZE);

        // JSON으로 반환할 최상위 Map
        Map<String, Object> result = new HashMap<>();

        // (1) 찾는중
        Map<String, Object> findingData = new HashMap<>();
        findingData.put("items", findingItems);
        findingData.put("currentPage", findingPage);
        findingData.put("totalPages", findingTotalPages);
        findingData.put("totalRecords", findingTotal);
        result.put("findingPageData", findingData);

        // (2) FOUND!
        Map<String, Object> getData = new HashMap<>();
        getData.put("items", getItems);
        getData.put("currentPage", getPage);
        getData.put("totalPages", getTotalPages);
        getData.put("totalRecords", getTotal);
        result.put("getPageData", getData);

        // (3) 신고글
        Map<String, Object> reportData = new HashMap<>();
        reportData.put("items", reportItems);
        reportData.put("currentPage", reportPage);
        reportData.put("totalPages", reportTotalPages);
        reportData.put("totalRecords", reportTotal);
        result.put("reportPageData", reportData);

        return result;
    }

    @GetMapping("/app/myCs/{email}")
    public List<csVo> getMyCs(@PathVariable("email") String email) {
        List<csVo> csList = flutterMapper.getMyCs(email);
        System.out.println(csList);
        return csList;
    }

    @PostMapping("/app/chatting/open")
    public String roomOpen(@RequestBody Map<String,Object> map) {
        String openerEmail = String.valueOf(map.get("open_member"));
        String email = String.valueOf(map.get("participant"));
        return chatService.appCreateRoom(openerEmail, email);
    }


}