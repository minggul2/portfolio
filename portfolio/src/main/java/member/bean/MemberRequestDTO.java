package member.bean;

import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class MemberRequestDTO{
	@NotEmpty(message = "아이디를 입력하세요.")
	private String id;
	
	@NotEmpty(message = "이름을 입력하세요.")
	private String name;
	
	@NotEmpty(message = "비밀번호를 입력하세요.")
	@Size(min = 8, max = 20, message = "6자 이상 20자 이하로 입력해주세요.")
	private String pwd;
	
	@NotEmpty(message = "메일을 입력하세요.")
	@Email(message = "메일 양식이 아닙니다.")
	private String eamil;
}


