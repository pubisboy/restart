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
public class MyinfoDao{
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionFactory factory;
	
	public Map usergrade(String id) {
		SqlSession session = factory.openSession();
		HashMap rst = null;
		try {
			 rst = session.selectOne("myinfo.usergrade", id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return rst;
	}
	public List<Map> orderlist(String id){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.orderlist", id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public List<Map> qanda(String id){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.qanda", id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public List<Map> qnaAll(String id){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.qnaAll", id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public int qna_cnt(String id) {
		SqlSession session = factory.openSession();
		try {
			int cnt = session.selectOne("myinfo.qna_count",id);
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			session.close();
		}
	}
	public List<Map> qnapage(Map map){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.qna_page", map);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public List<Map> counsel(String id){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.counsel", id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public int counsel_cnt(String id) {
		SqlSession session = factory.openSession();
		try {
			int cnt = session.selectOne("myinfo.counsel_count",id);
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			session.close();
		}
	}
	public List<Map> counselpage(Map map){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.counsel_page", map);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public List<Map> counselAll(String id){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.counselAll", id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public List<Map> counselcate(){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.counselcate");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public int counselup(Map map) {
		SqlSession session = factory.openSession();
		try {
			return session.insert("myinfo.counselup",map);
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return -1;
		}finally {
			session.close();
		}
	}
	public boolean userpassrevise(Map map) {
		SqlSession session = factory.openSession();
			try {
				List<Object> step1 = session.selectList("myinfo.pass_confirm", map);
				if(step1 !=null ) 
				session.update("myinfo.pass_revise", map);
				session.commit();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				session.rollback();
				return false;				
			}finally {
				
			}
	}
	public boolean info_revise(Map map) {
		SqlSession session = factory.openSession();
		int rst = 0;
		try {
			rst = session.update("member.info_revise", map);
			if(rst==1) { 
			rst = session.update("member.join_service", map);
			System.out.println(rst); 
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			rst = 0;
			session.rollback();
		}finally {
			session.close();
		}
		return rst ==1;
	}
	
	public Map service_ck(String id) {
		SqlSession session = factory.openSession();
		HashMap rst = null;
		try {
			rst = session.selectOne("member.service_ck",id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return rst;
	}
	public boolean set(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.update("myinfo.setorder", map);
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
	public List<Map> state(String id){
		List<Map> list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.state", id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	public int state_cnt(String id) {
		SqlSession session = factory.openSession();
		try {
			int cnt = session.selectOne("myinfo.state_count",id);
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			session.close();
		}
	}
	public List<Map> statepage(Map map){
		List<Map>list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("myinfo.state_page", map);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public Map oneorder(Map map) {
		SqlSession session = factory.openSession();
		Map hmap = new HashMap<>();
		try {
			hmap = session.selectOne("myinfo.One_order", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return hmap; 
	}
	public boolean orderrevise(Map map) {
		SqlSession session = factory.openSession();
		boolean bl = false;
		try {
			session.update("myinfo.order_revise", map);
			session.commit();
			bl = true;
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		}finally {
			session.close();
		}
		return bl;
	}
	public int ordertup(Map map) {
		SqlSession session = factory.openSession();
		try {
			int cnt = session.update("myinfo.order_update", map);
			session.commit();
			return cnt;
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
			return -1;
		}finally {
			session.close();
		}
	}
}
