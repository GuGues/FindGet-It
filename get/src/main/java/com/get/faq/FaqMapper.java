package com.get.faq;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.get.vo.faqVo;

@Mapper
public interface FaqMapper {

	List<faqVo> getFaqList();

	void updateFaq(Map<String, String> map);

	void delFaq(String faq_idx);

	void insertFaq(Map<String, String> map);

}
