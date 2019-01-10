package board.dao;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import board.bean.CommentDTO;

public interface BoardDAO {

	void insertBoard(BoardDTO boardDTO);

	List<Map<String, String>> getBoardList(Map<String, Integer> map);

	int getBoardCount();

	BoardDTO getBoardOne(int b_no);

	void updateStep(BoardDTO pbDTO);

	void insertReply(BoardDTO boardDTO);

	void insertCmt(CommentDTO commentDTO);

	List<CommentDTO> getCmtList(int b_no);

}
