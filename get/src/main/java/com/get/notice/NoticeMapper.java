package com.get.notice;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {

	List<noticeVo> getNoticeList(int arg0, int arg1);

	noticeVo getNotice(String notice_idx);

	void upNoticeView(String notice_idx);

	int getTotalNoticeCount();

	void updateNotice(Map<String, String> map);

	void insertNotice(Map<String, String> map);

	void deleteNotice(String notice_idx);


	List<noticeVo> getAllNoticeList();
}
