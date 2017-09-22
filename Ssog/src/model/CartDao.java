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
public class CartDao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionFactory factory;
	
	public boolean order(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.insert("cart.order",map);
			session.update("updateSell_qty", map);
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
	public Map dhl() {
		Map map = new HashMap<>();
		SqlSession session = factory.openSession();
		try {
			map = session.selectOne("cart.dhlprice");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return map;
	}
	public Map pd_ascertain(Map map) {
		Map nmap = new HashMap<>();
		SqlSession session = factory.openSession();
		try {
			nmap = session.selectOne("cart.pd_ascertain", map);
			System.out.println("dao nmap : "+nmap); 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return nmap;
	}
	
	public void orderupdate(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.update("cart.orderupdate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
	}
	public List<Map> couponlist(String id){
		List<Map> list = new ArrayList<>();
		SqlSession session = factory.openSession();
		try {
			list = session.selectList("cart.coupon",id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	
	
	public Map point(String id) {
		Map map = new HashMap<>();
		SqlSession session = factory.openSession();
		try {
			map = session.selectOne("cart.point", id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return map;
	}
	public void userpoint(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.update("cart.consume", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
	}	
	public boolean coupondel(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.delete("cart.coupoindel", map);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
	public boolean user_recordupdate1(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.update("cart.point_plus", map);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
	public boolean user_recordupdate2(Map map) {
		SqlSession session = factory.openSession();
		try {
			session.update("cart.point_minuse", map);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			session.close();
		}
	}
}
