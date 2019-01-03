package member.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class MemberDTO {
	private String id;
	private String name;
	private String pwd;
}
