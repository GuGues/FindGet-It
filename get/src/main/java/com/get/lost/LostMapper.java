package com.get.lost;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.get.vo.colorVo;
import com.get.vo.itemVo;
import com.get.vo.locationVo;

@Mapper
public interface LostMapper {

	List<lostCustomVo> getLostList(int arg0, int arg1);

	List<itemVo> getBigItems();

	List<itemVo> getItems(int code);

	List<colorVo> getColors();

	List<locationVo> getLocationBig();

	List<locationVo> getLocationMiddle(int location_code);

	List<lostCustomVo> getSearchLost(Map<String, String> map);

	int getTotalLostCount();

	int getTotalSearchLostCount(Map<String, String> map);

	List<lostVo> getAppLostList();


}
