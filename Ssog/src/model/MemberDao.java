package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberDao {
	@Autowired
	DataSource ds;
	
	@Autowired
	SqlSessionFactory factory;
	
	public boolean join(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.insert("member.join",map);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		}finally {
			session.close();
		}
	}
	public boolean alarm(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.insert("member.alarmck",map);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		}finally {
			session.close();
		}
	}
	public boolean user_info(String id) {
		SqlSession session = factory.openSession();
		try {
			session.insert("member.user_info", id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
	
	public boolean login(Map map) {
		SqlSession session = factory.openSession();
		System.out.println("dao map : "+map);
		try {
			HashMap rst = session.selectOne("member.login", map);
			System.out.println("memberdao rst"+rst);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
	public Map id_check_repetition(String id) {
		SqlSession session = factory.openSession();
		HashMap rst = null;
		try {
			rst = session.selectOne("member.id_check", id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return rst;
	}
	public boolean email_check_repetition(String email) {
		SqlSession session = factory.openSession();
		try {
			HashMap rst = session.selectOne("member.email_check", email);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
	public boolean passrevise(String pass) {
		SqlSession session = factory.openSession();
		try {
			List rst = session.selectList("member.pass_check", pass);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
	public List<Map> leavereason(){
		SqlSession session = factory.openSession();
		List<Map>list = new ArrayList<>();
		try {
			list = session.selectList("member.reave_reason");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public boolean leavewrite(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.insert("member.reave_write", map);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		}finally {
			session.close();
		}
	}
	public boolean leavemember(String id) {
		SqlSession session = factory.openSession();
		try {
			session.delete("member.deletmember",id);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		}finally {
			session.close();
		}
	}
}
