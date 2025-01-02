package com.get.alarm;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/alarm")
public class AlarmController {

    @Autowired
    private final AlarmMapper alarmMapper;

    public AlarmController(AlarmMapper alarmMapper) {
        this.alarmMapper = alarmMapper;
    }

    @GetMapping("/get-info")
    public ResponseEntity<List<AlarmVo>> getInfo(HttpServletRequest request){
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<AlarmVo> AlarmList = alarmMapper.getAlarmList(email);
        return ResponseEntity.ok(AlarmList);
    }

    @GetMapping("/delete/{alarm_idx}")
    public String deleteAlarm(@PathVariable String alarm_idx){
        int count = alarmMapper.deleteAlarm(alarm_idx);
        if(count > 0){
            return "OK";
        }
        return "ERROR";
    }

    @GetMapping("/viewed/{alarm_idx}")
    public String viewedAlarm(@PathVariable String alarm_idx){
        int count = alarmMapper.updateView(alarm_idx);
        if(count > 0){
            return "OK";
        }
        return "ERROR";
    }

    @GetMapping("/open/{email}")
    public String openedAlarm(@PathVariable String email){
        int count = alarmMapper.updateOpen(email);
        return "OK";
    }
}
