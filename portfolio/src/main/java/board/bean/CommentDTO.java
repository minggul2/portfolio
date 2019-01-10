package board.bean;

import java.util.Date;

import lombok.Data;

@Data
public class CommentDTO {
    // 게시글번호 
    private int b_no;

    // 댓글번호 
    private int c_no;

    // 작성자 
    private String m_id;

    // 내용 
    private String c_contents;

    // 그룹 번호 
    private int c_ref;

    // 단계 
    private int c_lev;

    // 순서 
    private int c_step;

    // 작성일자 
    private Date c_logtime;
}
