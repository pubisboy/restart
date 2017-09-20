package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminMemberDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List<Map> user_list(Map map){
		SqlSession session = factory.openSession();
		List<Map> rst = null;
		try{
			rst = session.selectList("admin_member.user_list", map);
		}catch(Exception e){
			System.out.println("error.user_list"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int user_list_count(Map map){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_member.user_list_count", map);
		}catch(Exception e){
			System.out.println("error.user_list_count"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List user_detail_info(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.user_detail_info", id);
		}catch(Exception e){
			System.out.println("error.user_detail_info"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List user_detail_grade(int buy_total){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.user_detail_grade", buy_total);
		}catch(Exception e){
			System.out.println("error.user_detail_grade"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List user_detail_order_top9(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.user_detail_order_top9", id);
		}catch(Exception e){
			System.out.println("error.user_detail_order_top9"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List user_detail_counsel_top9(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.user_detail_counsel_top9", id);
		}catch(Exception e){
			System.out.println("error.user_detail_counsel_top9"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public boolean user_detail_memo_update(Map memos){
		SqlSession session = factory.openSession();
		boolean rst = false;
		try{
			int r = session.update("admin_member.user_detail_memo_update", memos);
			if(r > 0){
				rst = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.user_detail_memo_update"+e.toString());
			session.rollback();
			rst = false;
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int user_detail_buyCount(String id){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_member.user_detail_buyCount", id);
		}catch(Exception e){
			System.out.println("error.user_detail_buyCount"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List<Map> seller_list(Map map){
		SqlSession session = factory.openSession();
		List<Map> rst = null;
		try{
			rst = session.selectList("admin_member.seller_list", map);
		}catch(Exception e){
			System.out.println("error.seller_list"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int seller_list_count(Map map){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_member.seller_list_count", map);
		}catch(Exception e){
			System.out.println("error.seller_list_count"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List seller_detail_info(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.seller_detail_info", id);
		}catch(Exception e){
			System.out.println("error.seller_detail_info"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List seller_detail_grade(int buy_total){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.seller_detail_grade", buy_total);
		}catch(Exception e){
			System.out.println("error.seller_detail_grade"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List seller_detail_product_top9(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.seller_detail_product_top9", id);
		}catch(Exception e){
			System.out.println("error.seller_detail_product_top9"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List seller_detail_counsel_top9(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.seller_detail_counsel_top9", id);
		}catch(Exception e){
			System.out.println("error.seller_detail_counsel_top9"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public boolean seller_detail_memo_update(Map memos){
		SqlSession session = factory.openSession();
		boolean rst = false;
		try{
			int r = session.update("admin_member.seller_detail_memo_update", memos);
			if(r > 0){
				rst = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.seller_detail_memo_update"+e.toString());
			session.rollback();
			rst = false;
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int seller_detail_buyCount(String id){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_member.seller_detail_buyCount", id);
		}catch(Exception e){
			System.out.println("error.seller_detail_buyCount"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List seller_detail_star(String id){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_member.seller_detail_star", id);
		}catch(Exception e){
			System.out.println("error.seller_detail_star"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
}
