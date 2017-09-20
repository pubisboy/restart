package controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.AdminMemberDao;
import paging.Paging;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	AdminMemberDao amd;
	
	@Autowired
	Paging pg;

	@RequestMapping("/member_user/user_list.ja")
	public String user_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
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
		int rows = amd.user_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = amd.user_list(params);
		
		String[] typesEn = "id,name,email,phone".split(",");
		String[] typesKo = "아이디,이름,이메일,연락처".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", list);
		map.put("paging", paging);
		map.put("section", "/member_user/user_list");
		params.put("value", val);
		map.put("params", params);
		
		return "ad_member";
	}
	
	@RequestMapping("/member_user/user_detail.ja")
	public String user_detail(@RequestParam Map params, @RequestParam(name="id") String id, Map map, HttpSession session){
		map.put("params", params);
		List liInfo = amd.user_detail_info(id);
		if(liInfo.size() > 0){
			Map tmp = (Map)liInfo.get(0);
			System.out.println("tml : "+tmp.hashCode());
			System.out.println("(Map)liInfo.get(0) : "+((Map)liInfo.get(0)).hashCode());
			String[] addr = ((String)tmp.get("ADDRESS")).split("!");
			tmp.put("ADDRESS", addr);
			String[] birth = ((String)tmp.get("BIRTH")).split("/");
			tmp.put("BIRTH", birth);
			String gender = (((String)tmp.get("GENDER")).equals("M") ? "남자" : "여자");
			tmp.put("GENDER", gender);
			BigDecimal b = (BigDecimal)(tmp.get("BUY_TOTAL") == null ? BigDecimal.valueOf(0) : tmp.get("BUY_TOTAL"));
			int buy_total = b.intValue();
			tmp.put("BUY_TOTAL", buy_total);
			
			List liGrade = amd.user_detail_grade(buy_total);
			List liOrder9 = amd.user_detail_order_top9(id);
			if(liOrder9.size() > 0){
				tmp = (Map)liOrder9.get(0);
				b = (BigDecimal)(tmp.get("CUPON_TYPE") == null ? BigDecimal.valueOf(0) : tmp.get("CUPON_TYPE"));
				int cupon_rate = b.intValue();
				tmp.put("CUPON_TYPE", cupon_rate);
			}
			System.out.println("liInfo : "+liInfo);
			System.out.println("liGrade : "+liGrade);
			System.out.println("liOrder9 : "+liOrder9);
			int buyc = amd.user_detail_buyCount(id);
			System.out.println("buyc : "+buyc);
			map.put("info", liInfo);
			map.put("grade", liGrade);
			map.put("order9", liOrder9);
			map.put("buyCount", buyc);
			
			List liCounsel9 = amd.user_detail_counsel_top9(id);
			for(int i = 0; i < liCounsel9.size(); i++){
				Map m = (Map)liCounsel9.get(i);
				String s = (String)m.get("TITLE");
				if(s.length() > 20){
					s = s.substring(0, 17);
					StringBuilder sb = new StringBuilder(s);
					sb.append("...");
					s = sb.toString();
					System.out.println("잘린 제목 : "+s);
				}
				((Map)liCounsel9.get(i)).put("TITLE", s);
			}
			map.put("counsel9", liCounsel9);
			map.put("section", "member_user/user_detail");
		}
		return "ad_member";
	}
	
	@RequestMapping("/member_user/user_detail_memo_update.ja")
	@ResponseBody
	public Map user_detail_memo_update(@RequestParam Map memos){
		Map map = new HashMap<>();
		boolean b = amd.user_detail_memo_update(memos);
		map.put("rst", b);
		return map;
	}
	
	@RequestMapping("/member_seller/seller_list.ja")
	public String seller_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
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
		
		// seller로 수정
		int rows = amd.seller_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = amd.seller_list(params);
		
		String[] typesEn = "id,name,brand,phone".split(",");
		String[] typesKo = "아이디,이름,브랜드,연락처".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", list);
		map.put("paging", paging);
		params.put("value", val);
		map.put("params", params);
		map.put("section", "/member_seller/seller_list");
		return "ad_member";
	}
	
	@RequestMapping("/member_seller/seller_detail.ja")
	public String seller_detail(@RequestParam Map params, @RequestParam(name="id") String id, Map map, HttpSession session){
		map.put("params", params);
		List liInfo = amd.seller_detail_info(id);
		if(liInfo.size() > 0){
			Map tmp = (Map)liInfo.get(0);
			System.out.println("tml : "+tmp.hashCode());
			System.out.println("(Map)liInfo.get(0) : "+((Map)liInfo.get(0)).hashCode());
			System.out.println("seller_liInfo : "+liInfo);
			BigDecimal b = (BigDecimal)(tmp.get("PRICE_TOTAL") == null ? BigDecimal.valueOf(0) : tmp.get("PRICE_TOTAL"));
			int buy_total = b.intValue();
			tmp.put("BUY_TOTAL", buy_total);
			
			List liGrade = amd.seller_detail_grade(buy_total);
			List liProduct9 = amd.seller_detail_product_top9(id);
			for(int i = 0; i < liProduct9.size(); i++){
				Map m = (Map)liProduct9.get(i);
				String s = (String)m.get("PRO_NAME");
				if(s.length() > 10){
					s = s.substring(0, 7);
					StringBuilder sb = new StringBuilder(s);
					sb.append("...");
					s = sb.toString();
					System.out.println("잘린 제목 : "+s);
				}
				((Map)liProduct9.get(i)).put("PRO_NAME", s);
			}
			
			System.out.println("liInfo : "+liInfo);
			System.out.println("liGrade : "+liGrade);
			System.out.println("liProduct9 : "+liProduct9);
			int buyc = amd.seller_detail_buyCount(id);
			System.out.println("buyc : "+buyc);
			map.put("info", liInfo);
			map.put("grade", liGrade);
			map.put("product9", liProduct9);
			map.put("buyCount", buyc);
			List listar = amd.seller_detail_star(id);
			Map tt =  (Map)listar.get(0);
			map.put("star",tt.get("STAR"));
			map.put("cnt",tt.get("CNT"));
			List liCounsel9 = amd.seller_detail_counsel_top9(id);
			for(int i = 0; i < liCounsel9.size(); i++){
				Map m = (Map)liCounsel9.get(i);
				String s = (String)m.get("TITLE");
				if(s.length() > 20){
					s = s.substring(0, 17);
					StringBuilder sb = new StringBuilder(s);
					sb.append("...");
					s = sb.toString();
					System.out.println("잘린 제목 : "+s);
				}
				((Map)liCounsel9.get(i)).put("TITLE", s);
			}
			map.put("counsel9", liCounsel9);
			map.put("section", "member_seller/seller_detail");
		}
		return "ad_member";
	}
	
	@RequestMapping("/member_seller/seller_detail_memo_update.ja")
	@ResponseBody
	public Map seller_detail_memo_update(@RequestParam Map memos){
		Map map = new HashMap<>();
		boolean b = amd.seller_detail_memo_update(memos);
		map.put("rst", b);
		return map;
	}
}
