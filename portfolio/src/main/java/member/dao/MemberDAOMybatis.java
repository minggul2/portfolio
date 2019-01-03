package member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import member.bean.MemberDTO;

@Component
public class MemberDAOMybatis implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void join(MemberDTO memberDTO) {
		sqlSession.insert("memberSQL.join", memberDTO);
	}

	@Override
	public boolean login(MemberDTO memberDTO) {
		return sqlSession.selectOne("memberSQL.login", memberDTO);
	}

}
