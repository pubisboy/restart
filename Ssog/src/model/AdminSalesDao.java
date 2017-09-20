package model;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminSalesDao {

	@Autowired
	SqlSessionFactory factory;
	
	public List getSales_list(Map map){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_sales.getSales_list", map);
		}catch(Exception e){
			System.out.println("error.getSales_list"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public int getSales_list_count(Map map){
		SqlSession session = factory.openSession();
		int rst = 0;
		try{
			rst = session.selectOne("admin_sales.getSales_list_count", map);
		}catch(Exception e){
			System.out.println("error.getSales_list_count"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
	
	public List getSales_excel(Map map){
		SqlSession session = factory.openSession();
		List rst = null;
		try{
			rst = session.selectList("admin_sales.getSales_excel", map);
		}catch(Exception e){
			System.out.println("error.getSales_excel"+e.toString());
		}finally{
			session.close();
		}
		return rst;
	}
}
