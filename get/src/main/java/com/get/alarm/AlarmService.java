package com.get.alarm;

import com.get.foundview.FoundItemVO;
import com.get.foundview.FoundViewMapper;
import com.get.lost.lostVo;
import com.get.lostview.LostItemVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AlarmService {
    @Autowired
    private AlarmMapper alarmMapper;


    public void updateView(String alarm_idx){
        alarmMapper.updateView(alarm_idx);
    }
    public void updateOpen(String member_idx){
        alarmMapper.updateOpen(member_idx);
    }

}
