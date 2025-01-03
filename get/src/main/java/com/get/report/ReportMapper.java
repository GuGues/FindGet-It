package com.get.report;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReportMapper {


    void insertReport(ReportVO vo);

    String selectMemIdxByEmail(@Param("email") String email);

}