package com.get.mypage;

import java.util.List;
import java.util.Map;

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

	List<MypageVo> getHistoryList(MypageVo user);

	List<MypageVo> getPostCount(MypageVo user);

	List<MypageVo> getAllLocation();

	List<MypageVo> getAllItem();

	MypageVo getArhieve(String email);

	MypageVo getCountWrite(String email);

	MypageVo getMyFind(MypageVo user);

	List<MypageVo> getNotFind(String email);


	int updateMyFind(Map<String, Object> requestData);

	int updateUser(Map<String, Object> requestData);


}
