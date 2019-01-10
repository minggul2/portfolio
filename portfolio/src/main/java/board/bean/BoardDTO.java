package board.bean;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class BoardDTO {
    // 글번호 
    private int b_no;

    // 작성자 
    private String b_id;

    // 제목 
    private String b_subject;

    // 내용 
    private String b_contents;

    // 그룹 번호 
    private int b_ref;

    // 글 레벨 
    private int b_lev;

    // 글 깊이 
    private int b_step;

    // 부모 번호 
    private int b_pno;

    // 조회수 
    private int b_hit;

    // 작성일자 
    private Date b_logtime;

}
