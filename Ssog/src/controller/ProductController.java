package controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.AdminProductDao;
import model.ProductDao;
import paging.Paging;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	ProductDao pdao;

	@Autowired
	Paging pg;
	
	@Autowired
	AdminProductDao apd;

	@RequestMapping("/list.j")
	public ModelAndView pro_list(@RequestParam Map param,
			@RequestParam(name = "origin_group", required = false) String[] arr) {
		if (param.get("page") == null) {
			param.put("page", "1");
		}
		if(param.get("min") == null || param.get("min").equals("")) {
			param.put("min", 0);
		}
		if(param.get("max")==null || param.get("max").equals("")) {
			param.put("max", 99999999);
		}
		System.out.println("오리진 그룹" + Arrays.toString(arr));

		param.put("origin_group", arr);
		pg.setDefaultSetting(8, 5);
		if (param.get("search") != null && !param.get("search").equals("")) {
			String search = (String) param.get("search");
			search = "%" + search + "%";
			param.put("search", search); 
		}
		System.out.println("넘어온 파라미터" + param);
		String category = (String) param.get("category");
		ModelAndView mav = new ModelAndView("t_base");
		mav.addObject("section", "product/list");
		List<Map> list = new ArrayList<>();

		int r = pdao.paging(param);
		int page = Integer.parseInt((String) param.get("page"));
		Map m = pg.calcBetween(page);
		param.put("start", m.get("start"));
		param.put("end", m.get("end"));
		System.out.println(m);
		mav.addObject("total", r);
		List<Map> list1 = new ArrayList<>();
		list1 = pdao.originlist();
		pg.setNumberOfRecords(r);
		Map mm = pg.calcPaging(page, r);
		System.out.println("파람 ============= "+ param);
		list = pdao.pro_list(param);
		mav.addObject("list", list);
		mav.addObject("paging", mm);
		mav.addObject("originlist", list1);
		String ori = "";
		if (arr != null) {
			for (String s : arr) {
				ori += "&origin_group=" + s;
			}
			mav.addObject("origin", ori);
			System.out.println(ori);
		}
		
		return mav;
		
	}
		

	@RequestMapping("/detail.j")
	public ModelAndView productdetail(@RequestParam(name = "productNumber") String num,@RequestParam(name ="page",required=false)String paging,HttpSession session) {
		if(paging==null) {
			paging="1";
		}
		
		int page=Integer.parseInt(paging);
		Map m = pg.calcBetween(page);
		ModelAndView mav = new ModelAndView("t_base");
		Map map=new HashMap<>(); 
		Map elist = pdao.event_list(num);
		if(elist != null) {
			mav.addObject("elist", elist);
		}
		System.out.println("elist : "+elist);
		map=pdao.pro_detail(num);
		int r=pdao.reviewCount(num);
		pg.setDefaultSetting(8, 5);
		System.out.println(r);
		mav.addObject("section", "product/productdetail");
		mav.addObject("map", map);
		List<Map> list=new ArrayList<>();
		Map map1=new HashMap<>();
		map1.put("num", num);
		map1.put("start", m.get("start"));
		map1.put("end", m.get("end"));
		list=pdao.reviewList(map1);
		System.out.println(list);
		Map page1=pg.calcPaging(page, r);
		mav.addObject("paging", page1);
		mav.addObject("list",list);
		return mav; 
	}
	
	@RequestMapping("/review.j")
	public String ssibal() {
		System.out.println("아아아");
		return "/product/review";
	}
	
	@RequestMapping("/reviewExec.j")
	public Map ssipal(@RequestParam Map map,HttpSession ssesion) {
		String user_id=(String)ssesion.getAttribute("auth");
		map.put("userid", user_id);
		System.out.println(map);
		boolean br=pdao.reviewReg(map);
		System.out.println(br);
		map.put("result", br);
		return map;
	}
	@RequestMapping("/QnA.j")
	@ResponseBody
	public Map QnA(@RequestParam Map param,HttpSession session) {
		System.out.println("넘어온 파라미터 =="+param);
		param.put("userid", session.getAttribute("auth"));
		boolean br=pdao.QnAReg(param);
		Map map=new HashMap<>();
		map.put("result", br); 
		return map;		
	}
 
	@RequestMapping("/listAd.j")
	public ModelAndView listAd(@RequestParam(name="page") Integer page) {
		ModelAndView mav = new ModelAndView("t_base");
		List<Map> list = new ArrayList<>();
		if(page == 1){
			list = apd.top10_yesterday_qty();
		}else{
			list = apd.top10_review();
		}
		mav.addObject("section", "product/listAd");
		mav.addObject("page", page);
		mav.addObject("list", list);
		return mav;
	}

}