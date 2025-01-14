package com.get.chat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChattingReportVo {
  private String chat_report_idx;
  private String reporter_email;
  private String receiver_email;
  private String report_room;
  private String chat_report_content;
  private String reg_date;
}
