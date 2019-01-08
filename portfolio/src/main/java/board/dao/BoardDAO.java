package board.dao;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;

public interface BoardDAO {

	void board_insert(BoardDTO boardDTO);

	List<Map<String, String>> getBoardList(Map<String, Integer> map);

	int getboardCount();

	BoardDTO getBoardOne(int b_no);

}
