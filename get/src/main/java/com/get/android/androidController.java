package com.get.android;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.get.chat.Chat;
import com.get.chat.ChatMapper;
import com.get.chat.ChatRoom;
import com.get.chat.ChatService;
import com.get.faq.FaqMapper;
import com.get.foundview.FoundItemVO;
import com.get.foundview.FoundViewMapper;
import com.get.lost.lostCustomVo;
import com.get.lostview.LostItemVO;
import com.get.lostview.LostViewMapper;
import com.get.notice.NoticeMapper;
import com.get.notice.noticeVo;
import com.get.police.PoliceMapper;
import com.get.police.PoliceVo;
import com.get.search.SearchMapper;
import com.get.vo.faqVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.get.lost.LostMapper;

@RestController
public class androidController {

    @Autowired
    private SearchMapper searchMapper;
    @Autowired
    private FoundViewMapper foundViewMapper;
    @Autowired
    private PoliceMapper policeMapper;
    @Autowired
    private LostMapper lostMapper;
    @Autowired
    private ChatMapper chatMapper;
    @Autowired
    private ChatService chatService;
    @Autowired
    private FaqMapper faqMapper;
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private LostViewMapper lostViewMapper;

    @Value("${server.img.url}")
    private String severUrl;



    @GetMapping("/app/lostList")
        public ResponseEntity<List<lostCustomVo>> appLostList(@RequestParam(value = "page", defaultValue = "1") int page){
        	int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
            int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산

    		//분실물 전체 리스트
    		List<lostCustomVo> lostList = lostMapper.getLostList(arg0, recordsPerPage);

            return ResponseEntity.ok(lostList);
        }

    @GetMapping("/app/chatting-roomList/{email}")
    public ResponseEntity<Map<String, Object>> appChatList(@PathVariable("email") String email) {
        Map<String, Object> map = chatService.findRoomByEmail(email);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/app/chatting/{chatting_no}")
    public ResponseEntity<Map<String, Object>> room(@PathVariable("chatting_no") String chatting_no) {
        Map<String, Object> map = new HashMap<>();
        ChatRoom room = chatService.findRoomByIdx(chatting_no);
        List<Chat> chatList = chatService.findAllChatReverse(chatting_no);
        map.put("chatting_no", chatting_no);
        map.put("room", room);
        map.put("chatList", chatList);
        return ResponseEntity.ok(map);
    }

    @PostMapping("/app/chatting/update-view")
    public ResponseEntity<Map<String, Object>> updateView(@RequestBody HashMap<String, Object> params) {
        String chatting_no = String.valueOf(params.get("chatting_no"));
        String email = String.valueOf(params.get("email"));
        chatService.updateMessageViewed(chatting_no, email);
        return ResponseEntity.ok().build();
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
    	public ResponseEntity<List<lostCustomVo>> getLostSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page){
    		System.out.println("searchLost map : "+map);
    		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
            int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
    		map.put("arg0", String.valueOf(arg0));
    		map.put("arg1", String.valueOf(recordsPerPage));
    		System.out.println(map);
    		//{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
    		List<lostCustomVo> searchLost = lostMapper.getSearchLost(map);

    		return ResponseEntity.ok(searchLost);
    	}
//    @GetMapping("/app/getLostItem/{lostIdx}")
//    public ResponseEntity<LostItemVO> getLostSearch(@PathVariable("lostIdx")String lostIdx) {
//
//        //{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
//        LostItemVO item = lostViewMapper.selectLostItemDetail(lostIdx);
//        return ResponseEntity.ok(item);
//    }

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
        //     → JSON 응답 시 { "lostItem": {...}, "filePath": "...", "severUrl": "..." }
        Map<String, Object> result = new HashMap<>();
        result.put("lostItem", vo);        // 실제 분실물 VO
        result.put("filePath", finalPath); // 최종 파일 경로
        result.put("serverUrl", severUrl); // 서버의 이미지 경로 prefix (ex: http://192.168.0.214:9090)

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
        result.put("serverUrl", severUrl); // 서버의 이미지 경로 prefix (ex: http://192.168.0.214:9090)

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
}