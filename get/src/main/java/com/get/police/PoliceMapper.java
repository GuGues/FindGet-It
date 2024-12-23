package com.get.police;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PoliceMapper {
    PoliceVo selectView(PoliceVo vo);

    List<PoliceVo> selectPoliceList(int arg0, int recordsPerPage);

    int getTotalCount();
}
