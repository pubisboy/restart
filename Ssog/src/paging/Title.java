package paging;

import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class Title {
	
	public void subTitle(List list, String taget, int max){
		for(int i = 0; i < list.size(); i++){
			Map m = (Map)list.get(i);
			String s = (String)m.get(taget);
			if(s.length() > max){
				int ms = max -3;
				s = s.substring(0, ms);
				StringBuilder sb = new StringBuilder(s);
				sb.append("...");
				s = sb.toString();
				System.out.println("잘린 제목 : "+s);
			}
			((Map)list.get(i)).put(taget, s);
		}
	}
}
