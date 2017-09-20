package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List<Map> pro_list(Map map){
		List<Map> list = new ArrayList<>();
		SqlSession session=factory.openSession();
		try {
		System.out.println(map);
		list=session.selectList("product.pro_list", map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
		session.close();
		}		
		return list;
	}
	
	public int paging(Map map) {
		int n=0;
		SqlSession session=factory.openSession();
		try {
			n=session.selectOne("list_count", map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return n;
	}
	public List<Map> Totalsearch(Map map) {
		List<Map> list = new ArrayList<>();
		SqlSession session=factory.openSession();
		try {
			list=session.selectList("product.totalsearch", map);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
			session.close();
			}		
			return list;
	}
	public int searchpaging(Map map) {
		int r=0;
		SqlSession session=factory.openSession();
		try {
			r=session.selectOne("totalsearch_count", map);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return r;
	}
	public List<Map> originlist(){
		List<Map> list=new ArrayList<>();
		SqlSession session=factory.openSession();
		try {
			list=session.selectList("originlist");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return list;
	}
	
	public Map pro_detail(String num){
		Map map=new HashMap<>();
		SqlSession session=factory.openSession();
		try {
			map=session.selectOne("productdetail", num);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return map;
	}
	
	public List largecate() {
		List<Map> list=new ArrayList<>();
		SqlSession session=factory.openSession();
		try {
			list=session.selectList("large_cate");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return list;
	}
	
	public List smallcate(String num) {
		List<Map> list=new ArrayList<>();
		SqlSession session=factory.openSession();
		try {
			list=session.selectList("product.small_cate",num);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return list;
	}
	public Map cart(String num){
		Map map=new HashMap<>();
		SqlSession session = factory.openSession();
		try {
			map = session.selectOne("product.cart",num);
		} catch (Exception e) { 
			e.printStackTrace();
		}finally {
			session.close();
		}
		return map;
	}
	
	public boolean productReg(Map map) {
		boolean br=false;
		SqlSession session = factory.openSession();
		try {
			int r = session.insert("productReg", map);
			int r1=session.insert("sell_qty");
			System.out.println(r1);
			if(r==1) {
				br=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	
	public boolean productUpdate(Map map) {
		boolean br=false;
		SqlSession session = factory.openSession();
		try {
			int r = session.insert("productUpdate", map);
			
			if(r==1) {
				br=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public List<Map> eventList(){
		SqlSession session=factory.openSession();
		List<Map> list=new ArrayList<>();
		try {
			list=session.selectList("couponList");
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return list;
	}
	public boolean useEvent(Map map) {
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.insert("useEvent",map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public Map EventETC(Map map) { 
		SqlSession session=factory.openSession();
		Map map1=new HashMap<>();
		try {
			map1=session.selectOne("EventETC", map);
			System.out.println("map1 은 뭘까"+map1);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return map1;
	}
	public boolean EndEvent(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.delete("EndEvent", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public boolean EventReg(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.delete("EventReg", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public boolean EventUpdate(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.delete("EventUpdate", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	
	public boolean sellUpdate0(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.delete("update0", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public boolean sellUpdate1(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.delete("update1", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	
	public boolean reviewReg(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.insert("reviewReg", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	public List reviewList(Map map) {
		SqlSession session=factory.openSession();
		List<Map> list=new ArrayList<>();
				try {
					list=session.selectList("reviewList", map);
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					session.close();
				}
				return list;
	}
	public int reviewCount(String m) {
		SqlSession session=factory.openSession();
		int r=0;
		try {
			r=session.selectOne("reviewCount", m);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return r;
	}
	
	public Map event_list(String num){
		Map map = new HashMap<>();
		SqlSession session = factory.openSession();
		try {
			map = session.selectOne("product.event_list",num);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return map;
	}
	
	public boolean QnAReg(Map map) { 
		SqlSession session=factory.openSession();
		boolean br=false;
		try {
			int r=session.insert("QnAReg", map);
			if(r==1) {
				br=true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
	
	public boolean findOrder(String m) {
		SqlSession session=factory.openSession();
		boolean br=true;
		List<Map> list=new ArrayList<>();
		try {
			list=session.selectList("findOrder", m);
			if(list.size()==0) {
				br=false;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return br;
	}
}