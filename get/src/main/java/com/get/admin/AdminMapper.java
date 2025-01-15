package com.get.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

	List<membersVo> getMembers(int arg0, int arg1);

	int getTotalMembersCount();

	List<membersVo> getBanMembers(int arg0, int arg1);

	int getTotalBanMemberCount();

	membersVo getUser(String mem_idx);

	void userBan(String mem_idx);

	void userBanClear(String mem_idx);

	List<reportVo> adminPostList(int arg0, int arg1);

	int getTotaladminPostCount();

	List<reportVo> getReport(String resiver_idx);

	void postBan(Map<String, String> map);

	List<reportVo> adminBanPostList(int offset, int recordsPerPage);

	void postBanClear(Map<String, String> map);

	List<membersVo> getReportMembers(int offset, int recordsPerPage);

	int getTotalReportMembersCount();

	List<chatReportVo> getReportUser(String email);

	List<messageVo> getChatting(int chatting_no);

}
