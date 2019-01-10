package board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import board.bean.BoardDTO;
import board.bean.CommentDTO;

@Component
public class BoardDAOMybatis implements BoardDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertBoard(BoardDTO boardDTO) {
		sqlSession.insert("boardSQL.board_insert", boardDTO);
	}

	@Override
	public List<Map<String, String>> getBoardList(Map<String, Integer> map) {
		return sqlSession.selectList("boardSQL.getBoardList", map);
	}

	@Override
	public int getBoardCount() {
		return sqlSession.selectOne("boardSQL.getBoardCount");
	}

	@Override
	public BoardDTO getBoardOne(int b_no) {
		return sqlSession.selectOne("boardSQL.getBoardOne", b_no);
	}

	@Override
	public void updateStep(BoardDTO pbDTO) {
		sqlSession.update("boardSQL.updateStep", pbDTO);
	}

	@Override
	public void insertReply(BoardDTO boardDTO) {
		sqlSession.insert("boardSQL.insertReply", boardDTO);
	}

	@Override
	public void insertCmt(CommentDTO commentDTO) {
		sqlSession.insert("boardSQL.insertCmt", commentDTO);
	}

	@Override
	public List<CommentDTO> getCmtList(int b_no) {
		return sqlSession.selectList("boardSQL.getCmtList", b_no);
	}
	
	
	
	
}
