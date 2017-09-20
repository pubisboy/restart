package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SellerOrderDao {
	@Autowired
	SqlSessionFactory factory;
	
	
	public List<Map<String,Object>> orderList(Map map){
		SqlSession session = factory.openSession();
		try {
			List<Map<String,Object>> list =  session.selectList("seller.order_list", map);
			session.commit();
			return list;
		} catch(Exception e){
			e.printStackTrace();
			session.rollback();
			return null;
		} finally{
			session.close();
		}
	}
	
	//글이 총 몇개인지
	public int orderTotal(Map map){
		SqlSession session = factory.openSession();
		try{
			int r = session.selectOne("seller.order_total", map);
			return r;
		} catch(Exception e){
			e.printStackTrace();
			session.rollback();
			return 0;
		} finally{
			session.close();
		}
	}
	
	public boolean updateSate(Map map) {
		SqlSession session = factory.openSession();
		try{
			session.update("seller.order_updateState", map);
			return true;
		} catch(Exception e){
			e.printStackTrace();
			session.rollback();
			return false;
		} finally{
			session.close();
		}
	}
	
	//========================================================
	public List<Map<String,Object>> salesList(Map map){
		SqlSession session = factory.openSession();
		try {
			List<Map<String,Object>> list =  session.selectList("seller.sales_list", map);
			session.commit();
			return list;
		} catch(Exception e){
			e.printStackTrace();
			session.rollback();
			return null;
		} finally{
			session.close();
		}
	}
	
	//글이 총 몇개인지
	public int salesTotal(Map map){
		SqlSession session = factory.openSession();
		try{
			int r = session.selectOne("seller.sales_total", map);
			return r;
		} catch(Exception e){
			e.printStackTrace();
			session.rollback();
			return 0;
		} finally{
			session.close();
		}
	}
}
