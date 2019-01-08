package board.controller;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import board.bean.BoardDTO;

public class BoardValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return BoardDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		BoardDTO boardDTO = (BoardDTO)target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "b_subject", "required", "필수입력 사항입니다.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "b_contents", "required", "필수입력 사항입니다.");
		if(boardDTO.getB_subject().length() < 4) {
			errors.rejectValue("b_subject", "lengthsize", "제목은 4글자 이상 가능합니다");
		}else if(boardDTO.getB_subject().length() > 21) {
			errors.rejectValue("b_subject", "lengthsize", "제목은 20글자 이하만 가능합니다");
		}
	}
	
}
