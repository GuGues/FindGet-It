package com.get.alarm;

import com.get.foundview.FoundItemVO;
import com.get.lost.lostVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AlarmMapper {
    int updateView(String idx);

    int updateOpen(String email);

    List<lostVo> findFoundList(FoundItemVO vo);

    void saveAlarm(AlarmVo alarm);

    List<AlarmVo> getAlarmList(String email);

    int deleteAlarm(String alarmIdx);

    int getChatAlarmCount(String email);

    void deleteMessageAlarm(String email);
}
