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
}