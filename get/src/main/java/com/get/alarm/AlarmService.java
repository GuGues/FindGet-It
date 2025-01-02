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
    @Autowired
    private FoundViewMapper foundViewMapper;

    public void updateView(String alarm_idx){
        alarmMapper.updateView(alarm_idx);
    }
    public void updateOpen(String member_idx){
        alarmMapper.updateOpen(member_idx);
    }

    public void saveFoundAlarm(FoundItemVO vo) {
        //itemCode가 일치하는 lostUser 구함
        List<lostVo> lostUserList = alarmMapper.findFoundList(vo);
        System.out.println("lostUserList = " + lostUserList);

        //itemName 구하기
        List<Map<String, Object>> items = foundViewMapper.selectItems();
        System.out.println("items = " + items);
        String itemName = "";
        for (Map<String, Object> item : items) {
            if(vo.getItemCode()==item.get("item_code")){
                itemName = item.get("item_name").toString();
                break;
            }
        }

        //알람 List추가함
        List<AlarmVo> alarmList = new ArrayList<>();
        for(lostVo lost : lostUserList){
            AlarmVo alarm = new AlarmVo();
            alarm.setMember_idx(lost.getEmail());
            alarm.setAlarm_content(itemName+"의 새로운 습득물 게시글이 올라왔습니다. 확인해보세요!");
            alarm.setAlarm_link("/found/view?foundIdx="+vo.getFoundIdx());
            alarmList.add(alarm);
        }
        System.out.println("alarmList = " + alarmList);
        alarmMapper.saveAlarm(alarmList);
    }
}
