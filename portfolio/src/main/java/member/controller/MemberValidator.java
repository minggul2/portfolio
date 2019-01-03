package member.controller;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import member.bean.MemberDTO;

public class MemberValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberDTO memberDTO = (MemberDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "required", "필수입력 사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required", "필수입력 사항입니다.");
		//pwd에는 메세지를 안줘봤는데 이 경우 Exception 처리 된다고 함
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pwd", "required", "필수입력 사항입니다.");
		
		//길이 체크
		if(memberDTO.getPwd().length() < 6 || memberDTO.getPwd().length() > 12) {
			//Exception이 아닌 오류메시지(defaultMessage)를 띄움
			errors.rejectValue("pwd", "lengthsize", "비밀번호는 6자이상 12자 이하만 가능");
		}else if(memberDTO.getId().length() < 6 || memberDTO.getId().length() > 12) {
			errors.rejectValue("id", "lengthsize", "아이디는 6자이상 12자 이하만 가능");
		}
		
		
		
		
		
	}
	
}
