package com.get.lost;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LostMapper {

	List<lostVo> getLostList(int arg0, int recordsPerPage);

	List<itemVo> getBigItems();

	List<itemVo> getItems(int code);

	List<colorVo> getColors();

	List<locationVo> getLocationBig();

	List<locationVo> getLocationMiddle(int location_code);

	List<lostVo> getSearchLost(Map<String, String> map);

	int getTotalLostCount();

	int getTotalSearchLostCount(Map<String, String> map);

}
