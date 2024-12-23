package com.get.found;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FoundMapper {

	int getTotalFoundCount();

	List<foundCustomVo> getFoundList(int arg0, int arg1);

	int getTotalSearchFoundCount(Map<String, String> map);

	List<foundCustomVo> getSearchFound(Map<String, String> map);
	
	

}
