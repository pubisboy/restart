package model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ModelTestDao {

	@Autowired
	SqlSessionFactory factory;
	
	public int testSelect(){
		SqlSession session = factory.openSession();
		int i = 0;
		try{
			i = session.selectOne("selectTest.countAll", "2@naver.com");
		}catch(Exception e){
			System.out.println(e.toString());
		}finally{
			session.close();
		}
		return i;
	}
}