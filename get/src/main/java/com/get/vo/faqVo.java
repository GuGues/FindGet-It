package com.get.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class faqVo {
	private String faq_idx;
	private String faq_question;
	private String faq_answer;
	private String faq_reg_date;
}
