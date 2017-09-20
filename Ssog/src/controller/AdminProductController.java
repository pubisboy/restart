package controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.AdminProductDao;
import paging.Paging;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping("/admin/sales/product")
public class AdminProductController {

	@Autowired
	AdminProductDao apd;
	
	@Autowired
	Paging pg;
	
	@RequestMapping("/product_list.ja")
	public String product_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		System.out.println("params : "+params);
		
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
		pg.setDefaultSetting(10, 5);
		int rows = apd.product_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = apd.product_list(params);
		System.out.println("상품 리스트"+list);
		for(int i = 0; i < list.size(); i++){
			Map m = (Map)list.get(i);
			String s = (String)m.get("PRO_NAME");
			if(s.length() > 10){
				s = s.substring(0, 7);
				StringBuilder sb = new StringBuilder(s);
				sb.append("...");
				s = sb.toString();
				System.out.println("잘린 이름 : "+s);
			}
			((Map)list.get(i)).put("PRO_NAME", s);
		}
		
		
		// 이건 ajax로 data를 보낼 때 사용해야 한다.
		/*List lc = apd.get_catefory_l();
		List sc = apd.get_catefory_s();
		map.put("lc", lc);
		map.put("sc", sc);*/
		
		String[] stateNum = "b_cate,cate".split(",");
		String[] stateKo = "대분류,소분류".split(",");
		map.put("stateNum", stateNum);
		map.put("stateKo", stateKo);
		
		String[] typesEn = "pro_num,pro_name,seller_id".split(",");
		String[] typesKo = "상품 번호,상품 이름,판매자".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		
		map.put("list", list);
		map.put("paging", paging);
		map.put("section", "/product/product_list");
		params.put("value", val);
		map.put("params", params);
		return "ad_sales";
	}
	
	@RequestMapping("/product_second.ja")
	@ResponseBody
	public Map product_second(@RequestParam Map params){
		List list = null;
		String first = (String)params.get("first");
		String name = null;
		String val = "NAME";
		if(first.equalsIgnoreCase("b_cate")){
			list = apd.get_catefory_l();
			name = "B_CATE";
		}else{
			list = apd.get_catefory_s();
			name = "S_CATE";
		}
		System.out.println("넘어오는 값 : "+params);
		System.out.println("list : "+list);
		System.out.println("name : "+name);
		
		String html = "<optgroup label='상세분류'>";
		for(Object o : list){
			Map m = (Map)o;
			BigDecimal tmp = (BigDecimal)m.get(name);
			int cate = tmp.intValue();
			String s = String.format("<option id='%ss' class='s_cate' value='%s'>%s</option>", cate, cate, (String)m.get(val));
			html += s;
		}
		html += "</optgroup>";
		
		Map map = new HashMap<>();
		map.put("html", html);
		return map;
	}
	
	@RequestMapping("/product_detail.ja")
	public String product_detail(@RequestParam Map params, Map map){
		List liInfo = apd.product_detail(params);
		int saleQty = apd.get_saleQty(params);
		int saleSum = apd.get_saleSum(params);
		int rate = apd.get_rate(params);
		System.out.println("rate : "+rate);
		Map m = (Map)liInfo.get(0);
		BigDecimal i = (BigDecimal)m.get("PRICE");
		
		if(rate > 0){
			int rateMoney = (int)(i.intValue() * (rate/100.0));
			System.out.println("rateMoney : "+rateMoney);
			int ratePrice = i.intValue() - rateMoney;
			System.out.println("ratePrice : "+ratePrice);
			map.put("rateMoney", rateMoney);
			map.put("ratePrice", ratePrice);
		}
		int cnt = apd.get_star_cnt(params);
		double s = apd.get_star(params);
		DecimalFormat df = new DecimalFormat("#.##");
		String star = df.format(s);
		/*String star = String.format("%.2f", s);*/

		List gr = apd.get_grade(i.intValue());
		Map lm = (Map)gr.get(0);
		String grade = (String)lm.get("GRADE");
		map.put("grade", grade);
		
		if(liInfo.size() > 0){
			System.out.println("liInfo : "+liInfo);
			System.out.println("qty : "+saleQty);
			System.out.println("saleSum : "+saleSum);
			System.out.println("star : "+star);
		}
		map.put("list", liInfo);
		map.put("rate", rate);
		map.put("qty", saleQty);
		map.put("sum", saleSum);
		map.put("star", star);
		map.put("cnt", cnt);
		map.put("params", params);
		map.put("section", "/product/product_detail");
		return "ad_sales";
	}
	
	@RequestMapping("/product_modify.ja")
	@ResponseBody
	public Map product_modify(@RequestParam Map params){
		String htmls = "<select id='sts'>";
		System.out.println("넘어온 거 : "+params);
		List lists = apd.get_catefory_s();
		String names = "S_CATE";
		
		int nows = Integer.parseInt((String)params.get("nows"));
		
		for(int i = 0; i < lists.size(); i++){
			Map m = (Map)lists.get(i);
			String s = null;
			String name = (String)m.get("NAME");
			BigDecimal bd = (BigDecimal)m.get(names);
			int num = bd.intValue();
			if(nows == num){
				s = String.format("<option value='%s' id='%s' selected>%s</option>",num,num,name);
			}else{
				s = String.format("<option value='%s' id='%s'>%s</option>",num,num,name);
			}
			htmls += s;
		}
		htmls+="</select>";
		
		System.out.println("만들어진 : "+htmls);
		Map map = new HashedMap();
		map.put("htmls", htmls);
		return map;
	}
	
	@RequestMapping("/product_modifyExec.ja")
	@ResponseBody
	public boolean product_modifyExec(@RequestParam Map params){
		System.out.println("넘어온 거 : "+params);
		boolean b = apd.update_product(params);
		return b;
	}
	
	@RequestMapping("/product_del.ja")
	public String product_del(@RequestParam Map params, Map map){
		int num = Integer.parseInt((String)params.get("num"));
		boolean b = apd.del_product(num);
		map.put("rst", b);
		map.put("t", "/sales/product/product_list.ja");
		map.put("f", "/sales/product/product_detail.ja?num="+num);
		return "/admin/result";
	}
}
