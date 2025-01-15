package com.get.android;


import com.get.faq.csVo;
import com.get.search.FoundItemVo;
import com.get.search.LostItemVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FlutterMapper {

    Map<String, Object> selectLostItem(String lostIdx);

    Map<String, Object> selectFoundItem(String foundIdx);

    int countMyFindingFoundItems(String email);

    List<FoundItemVo> selectMyFindingFoundItems(String email, int offset, int limit);

    int countMyFoundItems(String email);

    List<FoundItemVo> selectMyFoundItems(String email, int offset, int limit);

    int countMyFoundReportItems(String email);

    List<FoundItemVo> selectMyFoundReportItems(String email, int offset, int limit);

    int countMyFindingLostItems(String email);

    List<LostItemVo> selectMyFindingLostItems(String email, int offset, int limit);

    int countMyGetItems(String email);

    List<LostItemVo> selectMyGetItems(String email, int offset, int limit);

    int countMyLostReportItems(String email);

    List<LostItemVo> selectMyLostReportItems(String email, int offset, int limit);

    List<csVo> getMyCs(String email);
}
