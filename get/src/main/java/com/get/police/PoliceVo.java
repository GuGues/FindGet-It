package com.get.police;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PoliceVo {
    
    private String atcid;
    private String depplace;
    private String fdfilepathimg;
    private String fdprdtnm;
    private String fdsbjt;
    private String fdsn;
    private String fdymd;
    private String prdtclnm;
    private String rnum;
    private String reg_date;
    private String clrnm;
}
