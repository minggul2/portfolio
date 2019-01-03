package member.dao;

import member.bean.MemberDTO;

public interface MemberDAO {

	void join(MemberDTO memberDTO);

	boolean login(MemberDTO memberDTO);
	
}
