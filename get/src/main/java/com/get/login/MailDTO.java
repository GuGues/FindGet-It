package com.get.login;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailDTO {
	
	@NotBlank(message = "필수입력값입니다.")
	@Email(message = "올바른 이메일 값이 아닙니다.")
    private String email; // 이메일 주소
	
}
