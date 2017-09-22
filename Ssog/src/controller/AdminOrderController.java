package controller;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.AdminOrderDao;
import paging.Paging;

@Controller
@RequestMapping("/admin/sales/order")
public class AdminOrderController {

	@Autowired
	AdminOrderDao aod;
	
	@Autowired
	Paging pg;
	
	@RequestMapping("/order_list.ja")
	public String order_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		System.out.println("params : "+params);
		System.out.println("state : "+params.get("state"));
		/*if(params.get("state") != null){
			String s = (String)params.get("state");
			if(s.equals("")){
				params.remove("type");
				params.remove("value");
			}
		}*/
		String val = null;
		if(params.get("value") != null){
			val = (String)params.get("value");
			if(val.length() > 0){
				String tmp = "%"+val+"%";
				params.put("value", tmp);
			}else{
				params.put("value", "%");
			}
		}
		System.out.println("params의 value : "+params.get("value"));
		pg.setDefaultSetting(10, 10);
		int rows = aod.order_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = aod.order_list(params);
		System.out.println("주문 리스트"+list);
		for(int i = 0; i < list.size(); i++){
			Map m = (Map)list.get(i);
			String s = (String)m.get("PRO_NAME");
			if(s.length() > 10){
				s = s.substring(0, 7);
				StringBuilder sb = new StringBuilder(s);
				sb.append("...");
				s = sb.toString();
				System.out.println("잘린 제목 : "+s);
			}
			((Map)list.get(i)).put("PRO_NAME", s);
		}
		System.out.println("주문 리스트"+list);
		String[] typesEn = "order_num,pro_num,pro_name,user_id,seller_id".split(",");
		String[] typesKo = "주문번호,상품번호,상품이름,구매자,판매자".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		String[] stateNum = "1,2,3,4,5,6,7,8".split(",");
		String[] stateKo = "주문,결제완료,배송중,배송완료,구매확정,교환중,반품중,구매취소".split(",");
		map.put("stateNum", stateNum);
		map.put("stateKo", stateKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		
		map.put("list", list);
		map.put("paging", paging);
		map.put("section", "/order/order_list");
		params.put("value", val);
		map.put("params", params);
		return "ad_sales";
	}
	
	@RequestMapping("/order_detail.ja")
	public String order_detail(@RequestParam Map params, @RequestParam(name="order_num") Integer num, Map map){
		
		System.out.println("num : "+num);
		List liInfo = aod.order_detail(num);
		if(liInfo.size() > 0){
			System.out.println("liInfo : "+liInfo);
		}
		map.put("list", liInfo);
		map.put("params", params);
		map.put("section", "/order/order_detail");
		return "ad_sales";
	}
	
	@RequestMapping("/order_del.ja")
	public String order_del(@RequestParam Map params, Map map){
		int num = Integer.parseInt((String)params.get("num"));
		boolean b = aod.del_order(num);
		map.put("rst", b);
		map.put("t", "/sales/order/order_list.ja");
		map.put("f", "/sales/order/order_detail.ja");
		return "/admin/result";
	}
	
	@RequestMapping("/order_modify.ja")
	@ResponseBody
	public Map order_modify(@RequestParam Map params){
		String html = "<select id='stsel'>";
		System.out.println("넘어온 거 : "+params);
		String[] stateNum = "1,2,3,4,5,6,7,8".split(",");
		String[] stateKo = "주문,결제완료,배송중,배송완료,구매확정,교환중,반품중,주문취소".split(",");
		int now = Integer.parseInt((String)params.get("now"));
		for(int i = 0; i < stateNum.length; i++){
			String s;
			if(now == Integer.parseInt(stateNum[i])){
				s = String.format("<option value='%s' id='%s' selected>%s</option>",stateNum[i],stateNum[i],stateKo[i]);
			}else{
				s = String.format("<option value='%s' id='%s'>%s</option>",stateNum[i],stateNum[i],stateKo[i]);
			}
			html += s;
		}
		html+="</select>";
		System.out.println("만들어진 : "+html);
		Map map = new HashedMap();
		map.put("html", html);
		return map;
	}
	
	@RequestMapping("/order_modifyExec.ja")
	@ResponseBody
	public boolean order_modifyExec(@RequestParam Map params){
		System.out.println("넘어온 거 : "+params);
		String state = (String)params.get("state");
		System.out.println("state : "+state);
		boolean b = aod.update_order(params);
		if(b && state.equals("5")){
			b = aod.update_order_user_record(params);
			System.out.println("구매자 레코드 : "+b);
			/*b = aod.update_order_seller_record(params);
			System.out.println("판매자 레코드 : "+b);*/
			b = aod.update_order_sell_qty(params);
			System.out.println("개수 레코드 : "+b);
		}else if(b && state.equals("8")){
			b = aod.update_product_qty(params);
		}
		return b;
	}

}
