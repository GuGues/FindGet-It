package com.get.police;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.get.search.FoundItemVo;
import com.get.search.LostItemVo;
import com.get.search.PagingHelper;
import com.get.search.SearchMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

@Controller
public class PoliceController {

    @Value("${serviceKey}")
    String serviceKey;

    String apiUrl = "http://apis.data.go.kr/1320000/LosfundInfoInqireService/getLosfundDetailInfo?";

    @Autowired
    private PoliceMapper policeMapper;

    @GetMapping("/police/found/view")
    public ModelAndView view(PoliceVo vo, HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        Enumeration<String> enum_session = session.getAttributeNames();
        while(enum_session.hasMoreElements()) {
            String key = enum_session.nextElement();
            System.out.println(key + " : " + session.getAttribute(key));
        }

        ModelAndView mv = new ModelAndView("police/view");
        PoliceVo item = policeMapper.selectView(vo);

        RestTemplate restTemplate = new RestTemplate();
        String urlStr = apiUrl + "serviceKey=" + serviceKey + "&ATC_ID=" + URLEncoder.encode(item.getAtcid(), "UTF-8")
                + "&FD_SN=" + URLEncoder.encode(item.getFdsn(), "UTF-8");

        URI uri = new URI(urlStr);
        String xmlData = restTemplate.getForObject(uri, String.class);
        System.out.println("xmlData = " + xmlData);

        Map<String, Object> map = new ObjectMapper().readValue(xmlData.toString(), Map.class);
        Map<String, Object> responseMap = (Map<String, Object>) map.get("response");
        Map<String, Object> bodyMap = (Map<String, Object>) responseMap.get("body");
        Map<String, Object> itemMap = (Map<String, Object>) bodyMap.get("item");

        mv.addObject("item", itemMap);

        return mv;
    }

    @GetMapping("/police/found")
    public ModelAndView find(@RequestParam(value = "page", defaultValue = "1") int page) {
        ModelAndView mv = new ModelAndView("police/board");
        int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = policeMapper.getTotalCount();  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
        List<PoliceVo> policeList = policeMapper.selectPoliceList(arg0, recordsPerPage);

        mv.addObject("list", policeList);
        mv.addObject("pagingHelper",pagingHelper);

        return mv;
    }



}
