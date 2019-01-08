package board.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class BoardDTO {
	private int b_no;
	private String b_id;
	private String b_subject;
	private String b_contents;
	private String b_group;
	private String b_step;
	private String b_indept;
	private String b_inend;
	private int hit;
	private String logtime;
}
