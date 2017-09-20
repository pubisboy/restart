package model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminProductDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List product_list(Map map){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.product_list", map);
		}catch(Exception e){
			System.out.println("error.product_list"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int product_list_count(Map map){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_product.product_list_count", map);
		}catch(Exception e){
			System.out.println("error.product_list_count"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List get_catefory_s(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.get_catefory_s");
		}catch(Exception e){
			System.out.println("error.get_catefory_s"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List get_catefory_l(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.get_catefory_l");
		}catch(Exception e){
			System.out.println("error.get_catefory_l"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	
	public List product_detail(Map map){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.product_detail", map);
		}catch(Exception e){
			System.out.println("error.product_detail"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int get_saleQty(Map map){
		SqlSession session = factory.openSession();
		Integer rst = 0;
		try{
			rst = session.selectOne("admin_product.get_saleQty", map);
			if(rst == null){
				rst = 0;
			}
		}catch(Exception e){
			System.out.println("error.get_saleQty"+e.toString());
		}finally{
			session.close();
		}
		return rst.intValue();
	}
	
	public int get_saleSum(Map map){
		SqlSession session = factory.openSession();
		Integer rst = 0;
		try{
			rst = session.selectOne("admin_product.get_saleSum", map);
			if(rst == null){
				rst = 0;
			}
		}catch(Exception e){
			System.out.println("error.get_saleSum"+e.toString());
		}finally{
			session.close();
		}
		return rst.intValue();
	}
	
	public double get_star(Map map){
		SqlSession session = factory.openSession();
		Double rst = 0.0;
		try{
			rst = session.selectOne("admin_product.get_star", map);
			if(rst == null){
				rst = 0.0;
			}
		}catch(Exception e){
			System.out.println("error.get_star"+e.toString());
		}finally{
			session.close();
		}
		return rst.doubleValue();
	}
	
	public int get_star_cnt(Map map){
		SqlSession session = factory.openSession();
		Integer rst = 0;
		try{
			rst = session.selectOne("admin_product.get_star_cnt", map);
			if(rst == null){
				rst = 0;
			}
		}catch(Exception e){
			System.out.println("error.get_star_cnt"+e.toString());
		}finally{
			session.close();
		}
		return rst.intValue();
	}
	
	public int get_rate(Map map){
		SqlSession session = factory.openSession();
		Integer rst = 0;
		try{
			rst = session.selectOne("admin_product.get_rate", map);
			if(rst == null){
				rst = 0;
			}
		}catch(Exception e){
			System.out.println("error.get_rate"+e.toString());
		}finally{
			session.close();
		}
		return rst.intValue();
	}
	
	public boolean del_product(int num){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int r = session.delete("admin_product.del_product", num);
			if(r > 0){
				b = true;
			}
			session.commit();
		}catch(Exception e){
			System.out.println("error.del_product"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public boolean update_product(Map map){
		SqlSession session = factory.openSession();
		boolean b = false;
		try{
			int rst = session.insert("admin_product.update_product", map);
			if(rst > 0){
				b = true;
				session.commit();
			}
		}catch(Exception e){
			System.out.println("error.update_product"+e.toString());
			b = false;
			session.rollback();
		}finally{
			session.close();
		}
		return b;
	}
	
	public List get_grade(int buy_total){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.get_grade", buy_total);
		}catch(Exception e){
			System.out.println("error.get_grade"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List getMainAd(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.getMainAd");
		}catch(Exception e){
			System.out.println("error.getMainAd"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List getMainAd_uuid(int num){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.getMainAd_uuid", num);
		}catch(Exception e){
			System.out.println("error.getMainAd_uuid"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List top10_yesterday_qty(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.top10_yesterday_qty");
		}catch(Exception e){
			System.out.println("error.top10_yesterday_qty"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List top10_review(){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_product.top10_review");
		}catch(Exception e){
			System.out.println("error.top10_review"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
}