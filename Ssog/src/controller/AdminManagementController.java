package controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.AdminDao;
import paging.Paging;
import paging.Title;

@Controller
@RequestMapping("/admin/management")
public class AdminManagementController {
	
	@Autowired
	AdminDao ad;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	Paging pg;
	
	@Autowired
	Title tt;

	@RequestMapping("/notice/notice_list.ja")
	public String notice_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
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
		
		pg.setDefaultSetting(10, 10);
		int rows = ad.getCount_notice(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		Map bt = pg.calcBetween(p);
		params.put("start", bt.get("start"));
		params.put("end", bt.get("end"));
		
		List<Map> rst = ad.getValues("admin.getList_notice", params);
		for(int i = 0; i < rst.size(); i++){
			Map m = (Map)rst.get(i);
			String s = (String)m.get("TITLE");
			if(s.length() > 20){
				s = s.substring(0, 17);
				StringBuilder sb = new StringBuilder(s);
				sb.append("...");
				s = sb.toString();
				System.out.println("잘린 제목 : "+s);
			}
			((Map)rst.get(i)).put("TITLE", s);
		}
		
		System.out.println("params의 값은 "+params);
		List state = ad.getTarget_notice();
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", rst);
		map.put("target", state);
		map.put("paging", paging);
		params.put("value", val);
		map.put("params", params);
		map.put("section", "/management/notice/notice_list");
		return "ad_management";
	}
	
	@RequestMapping("/notice/notice_detail.ja")
	public String notice_detail(@RequestParam(name="num") Integer num, @RequestParam Map params, Map map){
		Map rst = ad.getValues("admin.getDetail_notice", num);
		map.put("list", rst);
		map.put("params", params);
		map.put("section", "/management/notice/notice_detail");
		return "ad_management";
	}
	
	@RequestMapping("/notice/notice_write.ja")
	public String notice_write(Map map){
		List<Map> rst = ad.getValues("admin.getValues_All", "target");
		map.put("list", rst);
		map.put("section", "/management/notice/notice_write");
		return "ad_management";
	}
	
	@RequestMapping("/notice/notice_writeExec.ja")
	@ResponseBody
	public Map notice_writeExec(@RequestParam Map params){
		Map map = new HashMap<>();
		boolean b = ad.putValues("admin.put_notice", params);
		map.put("text", b);
		if(b){
			System.out.println(params.get("content"));
			String con = (String)params.get("content");
			if(con.contains("src")){
				String[] cons = con.split("\"");
				List list = new ArrayList<>(); 
				for(String c : cons){
					if(c.contains("/admin/resources")){
						System.out.println("src : "+c);
						String[] srcs = c.split("/");
						Map m = new HashMap<>();
						m.put("src", srcs[srcs.length-1]);
						list.add(m);
					}
				}
				boolean bb = ad.putImages(list);
				map.put("img", bb);
				if(bb){
					del_tempImg();
				}
			}
		}
		return map;
	}
	
	public void del_tempImg(){
		List li = ad.getUuid_notice_img();
		/*List srcs = new ArrayList<>();
		Iterator<String> it = li.iterator();
		int i = 0;
		while(it.hasNext()){
			String[] s = it.next().split("/");
			String rst = s[s.length-1];
			srcs.add(rst);
		}*/
		System.out.println(li);
		String path = application.getRealPath("/admin/resources");
		File dir = new File(path);
		if(dir.exists()){
			String[] tmp = dir.list();
			System.out.println(Arrays.toString(tmp));
			for(String s : tmp){
				if(!li.contains(s)){
					File file = new File(String.format("%s/%s", path, s));
					file.delete();
				}
			}
		}
	}
	
	@RequestMapping("/notice/notice_modify.ja")
	public String notice_modify(@RequestParam(name="num") Integer num, Map map){
		List<Map> list = ad.getDetatil_notice(num);
		List<Map> target = ad.getValues("admin.getValues_All", "target");
		map.put("list", list);
		map.put("target", target);
		map.put("section", "/management/notice/notice_modify");
		return "ad_management";
	}
	
	@RequestMapping("/notice/notice_modifyExec.ja")
	@ResponseBody
	public Map notice_modifyExec(@RequestParam Map params){
		System.out.println("notice 수정 : "+params);
		Map map = new HashMap<>();
		boolean b = ad.putValues("admin.updateNotice", params);
		map.put("text", b);
		if(b){
			int num = Integer.parseInt((String)params.get("num"));
			System.out.println("notice num : "+num);
			ad.delNotice_img(num);
			// System.out.println(params.get("content"));
			String con = (String)params.get("content");
			if(con.contains("src")){
				String[] cons = con.split("\"");
				List list = new ArrayList<>(); 
				for(String c : cons){
					if(c.contains("/admin/resources")){
						System.out.println("src : "+c);
						String[] srcs = c.split("/");
						Map m = new HashMap<>();
						m.put("src", srcs[srcs.length-1]);
						list.add(m);
					}
				}
				System.out.println("update list : "+list);
				Map m = new HashMap<>();
				m.put("list", list);
				m.put("num", num);
				boolean bb = ad.updateImage_notice(m);
				map.put("img", bb);
				if(bb){
					del_tempImg();
				}
			}
		}
		return map;
	}
	
	@RequestMapping("/notice/upload.j")
	public ModelAndView upload(@RequestParam(name="upload") MultipartFile f, @RequestParam Map param) throws IllegalStateException, IOException{
		ModelAndView mav = new ModelAndView("/admin/management/notice/notice_img_result");
		System.out.println(param);
		System.out.println(f.getContentType());
		System.out.println(f.getName());
		System.out.println(f.getOriginalFilename());
		System.out.println(f.isEmpty());
		
		String ofn = f.getOriginalFilename();
		
		// 저장경로 필요
		if(!f.isEmpty() && f.getContentType().startsWith("image")){
			File dir = new File(application.getRealPath("/admin/resources"));
			System.out.println(dir.getPath());
			if(!dir.exists()){
				dir.mkdirs();
			}
			String uuid = UUID.randomUUID().toString();
			String fileName = uuid+"."+(ofn.substring(ofn.lastIndexOf(".")+1));
			
			File file = new File(dir, fileName);
			f.transferTo(file);
			mav.addObject("result", true);
			mav.addObject("imageUrl", "/admin/resources/"+fileName);
			mav.addObject("funcNum", param.get("CKEditorFuncNum")); // 반드시 필요하다. 정해진 규칙이다.
		}else{
			mav.addObject("result", false);
		}
		return mav;
	}
	
	@RequestMapping("/information/company.ja")
	public String infomation_company(Map map){
		map.put("list", ad.getInfo_company());
 		map.put("section", "/management/information/company");
		return "ad_management";
	}
	
	@RequestMapping("/information/companyModify.ja")
	public String information_companyModify(Map map){
		map.put("list", ad.getInfo_company());
		map.put("section", "/management/information/company_modify");
		return "ad_management";
	}
	
	@RequestMapping("/information/companyModifyExec.ja")
	public String information_companyModifyExec(@RequestParam Map params, Map map, @RequestParam(name="names", required=false) String[] names,
			@RequestParam(name="nums", required=false) Integer[] nums, @RequestParam(name="names_origin", required=false) String[] names_origin){
		if(params.size() > 0){
			System.out.println("params : "+params.toString());
			System.out.println(Arrays.toString(names));
			System.out.println(Arrays.toString(names_origin));
			System.out.println(Arrays.toString(nums));
	
			List list = new ArrayList<>();
			for(int i = 0; i < names.length; i ++){
				Map m = new HashMap<>();
				m.put("num", nums[i]);
				m.put("name", names[i]);
				m.put("val", params.get(names_origin[i]));
				System.out.println("num : "+m.get("num"));
				System.out.println("name : "+names[i]);
				System.out.println("val : "+params.get(names_origin[i]));
				list.add(m);
			}
			System.out.println("list : "+list);
			boolean b = ad.updateValues_info_company(list);
		}
		return "redirect:/admin/management/information/company.ja";
	}
	
	@RequestMapping("/information/delInfoCompany.ja")
	@ResponseBody
	public boolean delInfoCompany(@RequestParam(name="del") String name){
		boolean b = ad.delInfo_company(name);
		return b;
	}
	
	@RequestMapping("/information/plusInfoCompany.ja")
	@ResponseBody
	public int plusInfoCompany(@RequestParam(name="plus") String name){
		int rst = ad.plusInfo_company(name);
		return rst;
	}
	
	@RequestMapping("/information/terms.ja")
	public String terms(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		pg.setDefaultSetting(10, 5);
		
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
		int rows = ad.getCount_terms(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = ad.getTerms(params);
		if(list != null){
			tt.subTitle(list, "TITLE", 20);
		}
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		
		map.put("list", list);
		map.put("paging", paging);
		map.put("section", "/management/information/terms");
		params.put("value", val);
		map.put("params", params);
		
		return "ad_management";
	}
	
	@RequestMapping("/information/terms_detail.ja")
	public String terms_detail(@RequestParam(name="num") Integer num, Map map){
		System.out.println("num : "+num);
		List list = ad.getDetail_terms(num);
		map.put("list", list);
		// System.out.println(list);
		map.put("section", "/management/information/terms_detail");
		return "ad_management";
	}
	
	@RequestMapping("/information/terms_modify.ja")
	public String terms_modify(@RequestParam(name="num") Integer num, Map map){
		List list = ad.getDetail_terms(num);
		map.put("list", list);
		map.put("section", "/management/information/terms_modify");
		return "ad_management";
	}
	
	@RequestMapping("/information/terms_modifyExec.ja")
	public String terms_modifyExec(@RequestParam Map params, Map map){
		System.out.println("params : "+params);
		boolean b = ad.updateValues_terms(params);
		map.put("rst", b);
		map.put("num", params.get("num"));
		map.put("t", "/management/information/terms_detail.ja?num="+params.get("num"));
		map.put("f", "/management//information/terms_modify.ja?num="+params.get("num"));
		return "/admin/result";
	}
	
	@RequestMapping("/information/terms_plus.ja")
	public String terms_plus(Map map){
		map.put("section", "/management/information/terms_plus");
		return "ad_management";
	}
	
	@RequestMapping("/information/terms_plusExec.ja")
	public String terms_plusExec(@RequestParam Map params, Map map){
		System.out.println("params : "+params);
		boolean b = ad.plusTerms(params);
		map.put("rst", b);
		map.put("t", "/management/information/terms.ja");
		map.put("f", "/management/information/terms_plus.ja");
		return "/admin/result";
	}
	
	@RequestMapping("/information/terms_del.ja")
	public String terms_del(@RequestParam(name="num") Integer num, Map map){
		boolean b = ad.delTerms(num);
		map.put("rst", b);
		map.put("t", "/management/information/terms.ja");
		map.put("f", "/management/information/terms_detail.ja?num"+num);
		return "/admin/result";
	}
	
	@RequestMapping("/notice/notice_del.ja")
	public String notice_del(@RequestParam(name="num") Integer num, Map map){
		boolean b = ad.delNotice(num);
		// if(b){
			// b = ad.delNotice_img(num);
			if(b){
				del_tempImg();
			}
		// }
		map.put("rst", b);
		map.put("t", "/management/notice/notice_list.ja");
		map.put("f", "/management/notice/notice_detail.ja?num"+num);
		return "/admin/result";
	}
	
	@RequestMapping("/counsel/counsel_user_list.ja")
	public String counsel_user_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map, HttpSession session){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		if(session.getAttribute("pre") != null){
			System.out.println("pre가 있다.");
			Map pa = (Map)session.getAttribute("pre");
			System.out.println("pre : "+pa);
			if(Integer.toString(p) == pa.get("p")){
				System.out.println("p : "+p+" / "+"pa.get : "+pa.get("p"));
				params = pa; 
			}
			session.removeAttribute("pre");
		}
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
		if(params.get("reply") != null){
			if(params.get("reply") instanceof Integer){
				int i = Integer.parseInt((String)params.get("reply"));
				params.put("reply", i);
			}
		}
		
		pg.setDefaultSetting(10, 10);
		int rows = ad.getCount_counsel_user(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		Map bt = pg.calcBetween(p);
		params.put("start", bt.get("start"));
		params.put("end", bt.get("end"));
		
		// System.out.println("params의 값은 "+params);
		List<Map> rst = ad.getList_counsel_user(params);
		if(rst != null){
			tt.subTitle(rst, "TITLE", 20);
		}
		// System.out.println("검색 결과는 : "+rst);
		List state = ad.getCounsel_category();
		
		String[] typesEn = "user_id,title".split(",");
		String[] typesKo = "아이디,제목".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", rst);
		map.put("state", state);
		map.put("paging", paging);
		params.put("value", val);
		map.put("params", params);
		map.put("section", "/management/counsel/counsel_user_list");
		
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_user_detail.ja")
	public String counsel_user_detail(@RequestParam Map params, @RequestParam(name="num") Integer num, Map map, HttpSession session){
		List list = ad.getCounsel_user_detail(num);
		Map li = (Map)list.get(0);
		String uuid = (String)li.get("IMAGE_UUID");
		// System.out.println("uuid : "+uuid);
		// System.out.println("params : "+params);
		session.setAttribute("pre", params);
		map.put("params", params);
		map.put("list", list);
		// System.out.println("list : "+list);
		map.put("section", "/management/counsel/counsel_user_detail");
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_user_modify.ja")
	public String counsel_user_modify(@RequestParam(name="num") Integer num, Map map, HttpSession session){
		List list = ad.getCounsel_user_detail(num);
		Map li = (Map)list.get(0);
		BigDecimal bd = (BigDecimal)li.get("REPLY");
		int r = bd.intValue();
		String content = null;
		if(r == 0){
			content = (String)li.get("CONTENT");
			content += "<hr style='border: dotted 2px red;'><br/>";
		}else{
			content = (String)li.get("CONTENT");
		}
		map.put("params", session.getAttribute("pre"));
		map.put("list", list);
		map.put("content", content);
		map.put("section", "/management/counsel/counsel_user_modify");
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_user_modifyExec.ja")
	public String counsel_user_modifyExec(@RequestParam Map params, Map map, HttpSession session){
		// System.out.println("params : "+params);
		boolean b = ad.updateCounsel_user_detail(params);
		// System.out.println("b : "+b);
		Map pa = (Map)session.getAttribute("pre");
		map.put("params", pa);
		if(b){
			return "redirect:/admin/management/counsel/counsel_user_list.ja?p="+pa.get("p");
		}else{
			return "redirect:/admin/management/counsel/counsel_user_detail.ja?num="+params.get("num");
		}
	}
	
	@RequestMapping("/counsel/counsel_user_del.ja")
	public String counsel_user_del(@RequestParam Map params, Map map){
		boolean b = ad.delCounsel_user(params);
		map.put("rst", b);
		map.put("t", "/management/counsel/counsel_user_list.ja");
		map.put("f", "/management/counsel/counsel_user_detail.ja");
		return "/admin/result";
	}
	
	
	
	@RequestMapping("/counsel/counsel_seller_list.ja")
	public String counsel_seller_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map, HttpSession session){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		if(session.getAttribute("pre") != null){
			System.out.println("pre가 있다.");
			Map pa = (Map)session.getAttribute("pre");
			System.out.println("pre : "+pa);
			if(Integer.toString(p) == pa.get("p")){
				System.out.println("p : "+p+" / "+"pa.get : "+pa.get("p"));
				params = pa; 
			}
			session.removeAttribute("pre");
		}
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
		if(params.get("reply") != null){
			if(params.get("reply") instanceof Integer){
				int i = Integer.parseInt((String)params.get("reply"));
				params.put("reply", i);
			}
		}
		
		pg.setDefaultSetting(10, 10);
		int rows = ad.getCount_counsel_seller(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		Map bt = pg.calcBetween(p);
		params.put("start", bt.get("start"));
		params.put("end", bt.get("end"));
		
		System.out.println("params의 값은 "+params);
		List<Map> rst = ad.getList_counsel_seller(params);
		if(rst != null){
			tt.subTitle(rst, "TITLE", 20);
		}
		System.out.println("검색 결과는 : "+rst);
		List state = ad.getCounsel_seller_category();
		
		String[] typesEn = "user_id,title".split(",");
		String[] typesKo = "아이디,제목".split(",");
		map.put("typesEn", typesEn);
		map.put("typesKo", typesKo);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", rst);
		map.put("state", state);
		map.put("paging", paging);
		params.put("value", val);
		map.put("params", params);
		map.put("section", "/management/counsel/counsel_seller_list");
		
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_seller_detail.ja")
	public String counsel_seller_detail(@RequestParam Map params, @RequestParam(name="num") Integer num, Map map, HttpSession session){
		List list = ad.getCounsel_seller_detail(num);
		Map li = (Map)list.get(0);
		String uuid = (String)li.get("IMAGE_UUID");
		System.out.println("uuid : "+uuid);
		System.out.println("params : "+params);
		session.setAttribute("pre", params);
		
		map.put("list", list);
		map.put("params", params);
		
		System.out.println("list : "+list);
		map.put("section", "/management/counsel/counsel_seller_detail");
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_seller_modify.ja")
	public String counsel_seller_modify(@RequestParam(name="num") Integer num, Map map, HttpSession session){
		List list = ad.getCounsel_seller_detail(num);
		Map li = (Map)list.get(0);
		BigDecimal bd = (BigDecimal)li.get("REPLY");
		int r = bd.intValue();
		String content = null;
		if(r == 0){
			content = (String)li.get("CONTENT");
			content += "<hr style='border: dotted 2px red;'><br/>";
		}else{
			content = (String)li.get("CONTENT");
		}
		map.put("params", session.getAttribute("pre"));
		map.put("list", list);
		map.put("content", content);
		map.put("section", "/management/counsel/counsel_seller_modify");
		return "ad_management";
	}
	
	@RequestMapping("/counsel/counsel_seller_modifyExec.ja")
	public String counsel_seller_modifyExec(@RequestParam Map params, Map map, HttpSession session){
		System.out.println("params : "+params);
		boolean b = ad.updateCounsel_seller_detail(params);
		System.out.println("b : "+b);
		Map pa = (Map)session.getAttribute("pre");
		map.put("params", pa);
		if(b){
			return "redirect:/admin/management/counsel/counsel_seller_list.ja?p="+pa.get("p");
		}else{
			return "redirect:/admin/management/counsel/counsel_seller_detail.ja?num="+params.get("num");
		}
	}
	
	@RequestMapping("/counsel/counsel_seller_del.ja")
	public String counsel_seller_del(@RequestParam Map params, Map map){
		boolean b = ad.delCounsel_seller(params);
		map.put("rst", b);
		map.put("t", "/management/counsel/counsel_seller_list.ja");
		map.put("f", "/management/counsel/counsel_seller_detail.ja");
		return "/admin/result";
	}
	
	@RequestMapping("/popup/popup_list.ja")
	public String popup_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
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
		
		pg.setDefaultSetting(10, 10);
		int rows = ad.getPopup_list_Count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		Map bt = pg.calcBetween(p);
		params.put("start", bt.get("start"));
		params.put("end", bt.get("end"));
		
		List<Map> rst = ad.getPopup_list(params);
		if(rst != null){
			tt.subTitle(rst, "TITLE", 20);
		}
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", rst);
		map.put("paging", paging);
		params.put("value", val);
		
		map.put("params", params);
		map.put("section", "/management/popup/popup_list");
		return "ad_management";
	}
	
	@RequestMapping("/popup/popup_switch.ja")
	@ResponseBody
	public Map popup_switch(@RequestParam Map params){
		String of = (String)params.get("of");
		System.out.println("of : "+of);
		String rst = null;
		Map map = new HashMap<>();
		if(of.equals("on")){
			params.put("of", 0);
			rst = "<b style='color: black;'>off</b>";
		}else{
			params.put("of", 1);
			rst = "<b style='color: red;'>on</b>";
		}
		boolean b = ad.updatePopup_onoff(params);
		System.out.println("b : "+b);
		System.out.println("rst : "+rst);
		map.put("b", b);
		map.put("rst", rst);
		return map;
	}
	
	@RequestMapping("/popup/popup_write.ja")
	public String popup_write(@RequestParam Map params, Map map){
		
		List clist = ad.getCupon_list();
		map.put("cupon", clist);
		map.put("section", "/management/popup/popup_write");
		return "ad_management";
	}
	
	@RequestMapping("/popup/popup_writeExec.ja")
	public ModelAndView popup_writeExec(@RequestParam Map params, @RequestParam(name="f") MultipartFile f) throws IllegalStateException, IOException{
		System.out.println("params : "+params);
		System.out.println("f : "+f.isEmpty());
		String filename = f.getOriginalFilename();
		String uuid = UUID.randomUUID().toString();
		String dirs = application.getRealPath("/admin/popupImg");
		
		File dir = new File(dirs);
		if(!dir.exists()){
			dir.mkdirs();
		}
		
		if(!f.isEmpty()){
			File file = new File(dirs, uuid);
			if (!file.exists()) {
				f.transferTo(file);
				params.put("uuid", uuid);
			}
		}
		
		boolean b = ad.putPopup(params);
		System.out.println("성공 : "+b);
		ModelAndView mv = new ModelAndView();
		if(b){
			mv.setViewName("redirect:/admin/management/popup/popup_list.ja");
		}else{
			mv.setViewName("redirect:/admin/management/popup/popup_write.ja");
		}
		return mv;
	}
	
	@RequestMapping("/popup/popup_detail.ja")
	public ModelAndView popup_detail(@RequestParam Map params){
		System.out.println("params : "+params);
		ModelAndView mv = new ModelAndView("ad_management");
		List li = ad.getPopup_detail(params);
		System.out.println("list는 "+li);
		mv.addObject("list", li);
		mv.addObject("params", params);
		mv.addObject("section", "/management/popup/popup_detail");
		return mv;
	}
	
	@RequestMapping("/popup/popup_modify.ja")
	public ModelAndView popup_modify(@RequestParam Map params){
		System.out.println("modify params : "+params);
		ModelAndView mv = new ModelAndView("ad_management");
		List li = ad.getPopup_detail(params);
		System.out.println("li : "+li);
		List clist = ad.getCupon_list();
		mv.addObject("cupon", clist);
		mv.addObject("list", li);
		mv.addObject("params", params);
		mv.addObject("section", "/management/popup/popup_modify");
		return mv;
	}
	
	@RequestMapping("/popup/popup_modifyExec.ja")
	public ModelAndView popup_modifyExec(@RequestParam Map params, @RequestParam(name="f") MultipartFile f) throws IllegalStateException, IOException{
		
		if(!f.isEmpty()){
			String filename = f.getOriginalFilename();
			String uuid = null;
			
			String tmp = ad.checkPopup_img_uuid(params);
			
			System.out.println("tmp : "+tmp);
			
			if(tmp == null){
				uuid = UUID.randomUUID().toString();
			}else{
				uuid = tmp;
			}
			
			String dirs = application.getRealPath("/admin/popupImg");
			
			File dir = new File(dirs);
			if(!dir.exists()){
				dir.mkdirs();
			}
			
			File file = new File(dirs, uuid);
			if (!file.exists() || tmp != null) {
				f.transferTo(file);
				params.put("uuid", uuid);
			}
		}
		
		System.out.println("modifyExec params : "+params);
		boolean b = ad.updatePopup(params);
		System.out.println("popup update : "+b);
		ModelAndView mv = new ModelAndView("redirect:/admin/management/popup/popup_list.ja");
		return mv;
	}
	
	@RequestMapping("/popup/popup_del.ja")
	public String popup_del(@RequestParam Map params, Map map){
		boolean b = ad.delPopup(params);
		map.put("rst", b);
		map.put("t", "/management/popup/popup_list.ja");
		map.put("f", "/management/popup/popup_write.ja");
		return "/admin/result";
	}
	
	@RequestMapping("/cupon/cupon_list.ja")
	public ModelAndView cupon_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp){
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		ModelAndView mv = new ModelAndView("ad_management");
		System.out.println("params : "+params);
		pg.setDefaultSetting(10, 5);
		
		int rows = ad.getCupon_base_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		
		List list = ad.getCupon_base_list(params);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		mv.addObject("total", total);
		
		mv.addObject("list", list);
		mv.addObject("paging", paging);
		mv.addObject("params", params);
		mv.addObject("section", "/management/cupon/cupon_list");
		return mv;
	}
	
	@RequestMapping("/cupon/cupon_modify.ja")
	@ResponseBody
	public Map cupon_modify(@RequestParam Map params){
		Map map = null;
		System.out.println("ajax params : "+params);
		boolean b = ad.updateCupon_base(params);
		System.out.println("성공 ? "+b);
		if(b){
			List li = ad.getCupon_base_one(params);
			System.out.println(li);
			map = (Map)li.get(0);
		}
		return map;
	}
	
	@RequestMapping("/cupon/cupon_del.ja")
	@ResponseBody
	public Map cupon_del(@RequestParam Map params){
		System.out.println("ajax params : "+params);
		boolean b = ad.delCupon_base(params);
		System.out.println("성공 ? "+b);
		Map map = new HashMap<>();
		map.put("b", b);
		return map;
	}
	
	@RequestMapping("/cupon/cupon_delCom.ja")
	public String cupon_delCom(Map map){
		map.put("title", "쿠폰삭제");
		map.put("section", "/management/cupon/cupon_delCom");
		return "ad_popup";
	}
	
	@RequestMapping("/cupon/cupon_delComExec.ja")
	public String cupon_delComExec(@RequestParam Map params, Map map){
		boolean b = ad.delCupon_base(params);
		map.put("rst", b);
		map.put("t", "/management/cupon/cupon_list.ja");
		map.put("f", "/management/cupon/cupon_list.ja");
		return "/admin/resultPopup";
	}
	
	@RequestMapping("/cupon/cupon_write.ja")
	public String cupon_write(Map map){
		List list = ad.getCupon_type_list();
		Calendar c = Calendar.getInstance();
		int now = c.get(Calendar.YEAR);
		map.put("list", list);
		map.put("year", now);
		map.put("section", "/management/cupon/cupon_write");
		return "ad_management";
	}
	
	@RequestMapping("/cupon/calc_day.ja")
	@ResponseBody
	public List calc_day(@RequestParam Map params){
		System.out.println("날짜 ajax : "+params);
		Calendar c = Calendar.getInstance();
		int y = Integer.parseInt((String)params.get("y"));
		int m = Integer.parseInt((String)params.get("m"));
		int d = Integer.parseInt((String)params.get("d"));
		c.set(y, m-1, d);
		int day = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		List days = new ArrayList<>();
		for(int i = 1; i <= day; i++){
			String s = String.format("<option value='%d'>%d</option>", i, i);
			System.out.println("s : "+s);
			days.add(s);
		}
		System.out.println("days : "+days);
		
		return days;
	}
	
	@RequestMapping("/cupon/cupon_writeExec.ja")
	public String cupon_writeExec(@RequestParam Map params, Map map){
		System.out.println("params : "+params);
		String y = (String)params.get("year");
		String m = (String)params.get("month");
		String d = (String)params.get("day");
		String date = String.format("%s-%s-%s", y, m, d);
		params.put("date", date);
		System.out.println("params2 : "+params);
		boolean b = ad.putCupon_base(params);
		map.put("rst", b);
		map.put("t", "/management/cupon/cupon_list.ja");
		map.put("f", "/management/cupon/cupon_write.ja");
		return "/admin/result";
	}
	
	@RequestMapping("/etc/etc.ja")
	public String etc(Map map){
		int dhl = ad.getDhl();
		int rate = ad.getPoint();
		map.put("dhl", dhl);
		map.put("rate", rate);
		map.put("section", "/management/etc/etc");
		return "ad_management";
	}
	
	@RequestMapping("/etc/updateEtc.ja")
	@ResponseBody
	public Map updateEtc(@RequestParam Map params){
		System.out.println(params);
		String type = (String)params.get("type");
		int val = Integer.parseInt((String)params.get("val"));
		boolean b = false;
		Map map = new HashMap<>();
		if(type.equals("charge")){
			b = ad.updateDhl(val);
			int r = ad.getDhl();
			DecimalFormat df = new DecimalFormat("#,###");
			String rst = df.format(r);
			map.put("rst", rst);
		}else{
			b = ad.updatePoint(val);
			int rst = ad.getPoint();
			map.put("rst", rst);
		}
		map.put("b", b);
		return map;
	}
}
