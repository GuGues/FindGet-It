package com.get.alarm;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AlarmVo {
    private String alarm_idx;
    private String email;
    private String alarm_title;
    private String alarm_content;
    private String alarm_state;
    private String alarm_link;
    private String alarm_viewed;

    @Builder
    public AlarmVo(String alarm_idx,String email,String alarm_title,String alarm_content,String alarm_state,String alarm_link,String alarm_viewed){
        this.alarm_idx=alarm_idx;
        this.email=email;
        this.alarm_title=alarm_title;
        this.alarm_content=alarm_content;
        this.alarm_state=alarm_state;
        this.alarm_link=alarm_link;
        this.alarm_viewed=alarm_viewed;
    }

    public static AlarmVo createAlarm(String alarm_idx,String email,String alarm_title,String alarm_content,String alarm_state,String alarm_link,String alarm_viewed){
       return AlarmVo.builder()
                .alarm_idx(alarm_idx)
                .email(email)
                .alarm_title(alarm_title)
                .alarm_content(alarm_content)
                .alarm_state(alarm_state)
                .alarm_link(alarm_link)
                .alarm_viewed(alarm_viewed).build();
    }
}
