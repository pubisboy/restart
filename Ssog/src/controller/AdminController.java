package controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.AdminDao;
import model.AdminOrderDao;
import paging.Paging;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminDao ad;
	
	@Autowired
	AdminOrderDao aod;
	
	@Autowired
	Paging pg;

	@RequestMapping("/login.ja")
	public String login() {
		return "/admin/login/login";
	}

	@RequestMapping("/loginExec.ja")
	public String loginExec(HttpSession session, @RequestParam Map<String, Object> params) {
		boolean b = ad.login(params);
		System.out.println("b : "+b);
		if (b) {
			session.setAttribute("admin", (String)params.get("id"));
			System.out.println("session의 admin : "+session.getAttribute("admin"));
			return "redirect:/admin/index.ja";
		} else {
			return "/admin/login/login";
		}
	}

	@RequestMapping({"/","/index.ja"})
	public String main(Map map) {
		// doc = daily order count
		map.put("doc", ad.doc());
		map.put("dpc", ad.dpc());
		map.put("duc", ad.duc());
		map.put("auc", ad.auc());
		map.put("luc", ad.luc());
		map.put("uncupon", ad.getUnableCupon());
		map.put("delivery", aod.getDelivery());
		System.out.println("main 입장");
		return "ad_main";
	}
	
	@RequestMapping("/delUnableCupon.ja")
	@ResponseBody
	public int delUnableCupon(){
		ad.delUnableCupon();
		return ad.getUnableCupon(); 
	}
	
	@RequestMapping("/management.ja")
	public String management(){
		return "redirect:/admin/management/information/company.ja";
	}
	
	@RequestMapping("/member.ja")
	public String member(){
		return "redirect:/admin/member/member_user/user_list.ja";
	}
	
	@RequestMapping("/sales.ja")
	public String sales(){
		return "redirect:/admin/sales/order/order_list.ja";
	}
	
	@RequestMapping("/admin.ja")
	public String admin(HttpSession session){
		String admin = (String)session.getAttribute("admin");
		if(admin.equals("admin")){
			return "redirect:/admin/admin/admin_list.ja";
		}else{
			return "redirect:/admin/admin/admin_modify.ja";
		}
	}
	
	@RequestMapping("/logout.ja")
	public String logout(HttpSession session){
		session.removeAttribute("admin");
		return "redirect:/admin/login.ja";
	}
	
	@RequestMapping("/admin/admin_list.ja")
	public String admin_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
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
		int rows = ad.admin_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = ad.admin_list(params);
		
		String[] typesEn = "id,owner".split(",");
		String[] typesKo = "아이디,소유자".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", list);
		map.put("paging", paging);
		map.put("section", "/admin/admin_list");
		params.put("value", val);
		map.put("params", params);
		
		return "ad_admin";
	}
	
	
	@RequestMapping("/admin/admin_modify.ja")
	public String admin_modify(Map map){
		map.put("section", "/admin/admin_modify");
		return "ad_admin";
	}
	
	@RequestMapping("/admin/admin_modifyExec.ja")
	@ResponseBody
	public boolean admin_modifyExec(@RequestParam Map params, HttpSession session){
		String id = (String)session.getAttribute("admin");
		String pass = (String)params.get("pass");
		String newpass = (String)params.get("newpass");
		params.put("id", id);
		System.out.println("params : "+params);
		boolean b = ad.admin_modify(params);
		System.out.println("결과 : "+b);
		return b;
	}
	
	@RequestMapping("/admin/admin_del.ja")
	@ResponseBody
	public boolean admin_del(@RequestParam Map params, Map map){
		boolean b = ad.admin_del(params);
		return b;
	}
	
	@RequestMapping("/admin/admin_create.ja")
	public String admin_create(Map map){
		map.put("section", "/admin/admin_create");
		return "ad_admin";
	}
	
	@RequestMapping("/admin/admin_createExec.ja")
	@ResponseBody
	public boolean admin_createExec(@RequestParam Map params){
		System.out.println("params : "+params);
		boolean b = ad.admin_create(params);
		System.out.println("결과 : "+b);
		return b;
	}
	
	@RequestMapping("/changeDelivery.ja")
	@ResponseBody
	public int changeDelivery(){
		List li = aod.updateDelivery_ready();
		System.out.println("list : "+li);
		boolean b = aod.updateDelivery2(li);
		b = aod.updateDelivery();
		return aod.getDelivery();
	}
	
	@RequestMapping("/mainAd.ja")
	public String mainAd(Map map){
		
		return "ad_admin";
	}
	
}