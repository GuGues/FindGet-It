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

	List<csVo> getCsList(int offset, int recordsPerPage);

	void updateCs(Map<String, String> map);

	csVo getCsQuestion(String cs_idx);

	int getTotalCsCount();

	void insertCs(Map<String, Object> map);

}
