package board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import board.bean.BoardDTO;

@Component
public class BoardDAOMybatis implements BoardDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void board_insert(BoardDTO boardDTO) {
		sqlSession.insert("boardSQL.board_insert", boardDTO);
	}

	@Override
	public List<Map<String, String>> getBoardList(Map<String, Integer> map) {
		return sqlSession.selectList("boardSQL.getBoardList", map);
	}

	@Override
	public int getboardCount() {
		return sqlSession.selectOne("boardSQL.getBoardCount");
	}

	@Override
	public BoardDTO getBoardOne(int b_no) {
		return sqlSession.selectOne("boardSQL.getBoardOne", b_no);
	}
	
}
