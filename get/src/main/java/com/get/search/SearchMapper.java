package com.get.search;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SearchMapper {

    // LOST_ITEMS 총 개수
    int countLostItems(@Param("keyword") String keyword);

    // LOST_ITEMS 검색
    List<LostItemVo> searchLostItems(@Param("keyword") String keyword,
                                     @Param("offset") int offset,
                                     @Param("limit") int limit);

    // FOUND 총 개수
    int countFoundItems(@Param("keyword") String keyword);

    // FOUND 검색
    List<FoundItemVo> searchFoundItems(@Param("keyword") String keyword,
                                       @Param("offset") int offset,
                                       @Param("limit") int limit);

    // ================== 경찰 습득물(PoliceFound) 추가 부분 ================== //

    // POLICE_FOUND 총 개수
    int countPoliceFoundItems(@Param("keyword") String keyword);

    // POLICE_FOUND 검색
    List<PoliceFoundVo> searchPoliceFoundItems(@Param("keyword") String keyword,
                                               @Param("offset") int offset,
                                               @Param("limit") int limit);
}