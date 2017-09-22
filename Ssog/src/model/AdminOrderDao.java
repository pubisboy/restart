package model;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminOrderDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List order_list(Map map){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_order.order_list", map);
		}catch(Exception e){
			System.out.println("error.order_list"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int order_list_count(Map map){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_order.order_list_count", map);
		}catch(Exception e){
			System.out.println("error.order_list_count"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List order_detail(int num){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_order.order_detail", num);
		}catch(Exception e){
			System.out.println("error.order_detail"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public boolean del_order(int num){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int r = session.delete("admin_order.del_order", num);
			if(r > 0){
				b = true;
			}
			session.commit();
		}catch(Exception e){
			System.out.println("error.del_order"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_order(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.update_order", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_order"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_order_user_record(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.update_order_user_record", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_order_user_record"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_order_seller_record(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.update_order_seller_record", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_order_seller_record"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_order_sell_qty(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.update_order_sell_qty", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_order_sell_qty"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_product_qty(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.update_product_qty", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_product_qty"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean updateDelivery(){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_order.updateDelivery");
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.updateDelivery"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public int getDelivery(){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_order.getDelivery");
		}catch(Exception e){
			System.out.println("error.getDelivery"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List updateDelivery_ready(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_order.updateDelivery_ready");
		}catch(Exception e){
			System.out.println("error.updateDelivery_ready"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public boolean updateDelivery2(List<Map> list){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = 0;
			for(Map m : list){
				BigDecimal n = (BigDecimal)m.get("ORDER_NUM");
				Map p = new HashedMap<>();
				p.put("num", n.intValue());
				System.out.println("num : "+n.intValue());
				rst = session.update("admin_order.update_order_sell_qty", p);
				if(rst > 0){
					System.out.println("rst : "+rst);
					b = true;
					session.commit();
				}else{
					session.rollback();
				}
			}
		}catch(Exception e){
			System.out.println("error.updateDelivery"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
}