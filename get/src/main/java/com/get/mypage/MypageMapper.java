package com.get.mypage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {

	MypageVo getEmail(String email);

	List<MypageVo> getLostList(MypageVo user);

	List<MypageVo> getCsList(MypageVo user);

	List<MypageVo> getFoundList(MypageVo user);


	void deleteCs(List<String> cs_title);

	MypageVo getFound(String found_idx);

	MypageVo getLocations(int location_code);

	MypageVo getItems(int item_code);

	MypageVo getLost(String lost_idx);

	MypageVo getMember(String email);

	MypageVo getCs(String cs_idx);

	void deleteLost(List<String> lost_idx);

	void deleteFound(List<String> found_idx);

}
