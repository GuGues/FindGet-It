package com.get.admin;

import java.util.List;

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

	void postBan(String resiver_idx);

	List<reportVo> adminBanPostList(int offset, int recordsPerPage);

	void postBanClear(String resiver_idx);

}
