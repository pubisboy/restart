package controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.servlet.ModelAndView;

import model.AdminDao;
import model.AdminProductDao;
import model.MemberDao;
import model.ProductDao;

@Controller
public class MemberController {
	@Autowired
	MemberDao mdao;
	@Autowired
	ProductDao pdao;
	@Autowired
	JavaMailSender sender;
	@Autowired
	AdminDao ad;
	@Autowired
	AdminProductDao apd;

	@RequestMapping({ "/", "/index.j" })
	public ModelAndView toIndex(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("t_base");
		Cookie[] cs = req.getCookies();
		List denys = null;
		if(cs != null){
			denys = new ArrayList<>();
			for(Cookie c : cs){
				if(c.getName().startsWith("deny")){
					String d = c.getValue();
					
					denys.add(d);
				}
			}
		}
		System.out.println("denys : "+denys);
		List list = ad.getPopup_target(denys);
		mav.addObject("list", list);
		mav.addObject("denys", denys);
		System.out.println("list : "+list);
		mav.addObject("section", "/main");
		return mav;
	}
	
	@RequestMapping("/getInfoCompany.j")
	@ResponseBody
	public List getInfoCompany(){
		List list = ad.getInfo_company();
		return list;
	}
	
	@RequestMapping("/popup.j")
	public String popup(@RequestParam Map params, Map map){
		System.out.println("popup params : "+params);
		List list = ad.getPopup_target_detail(params);
		Date date = ad.getCupon_date(params);
		if(date != null){
			Date now = new Date();
			long d = date.getTime();
			long n = now.getTime();
			if(d - n > 1000 * 60 * 60){
				map.put("enable", true);
			}else{
				map.put("enable", false);
			}
		}else{
			map.put("enable", false);
		}
		System.out.println("list : "+list);
		Map tmp = (Map)list.get(0);
		map.put("title", tmp.get("TITLE"));
		map.put("section", "/popup");
		map.put("params", list);
		return "main_popup";
	}
	@RequestMapping("member/check.j")
	public ModelAndView check() {
		ModelAndView mav = new ModelAndView();
		List<Map> list = mdao.terms();
		mav.addObject("list", list);
		System.out.println(list);
		
		return mav; 
	}
	
	@RequestMapping("/member/join.j")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView("tw_member/join");
		return mav;
	}
	@RequestMapping("/member/joinajax.j")
	public void joinajax(@RequestParam(name = "type") String type, @RequestParam(name = "val") String val, Map map) {
		Map rst = mdao.id_check_repetition(val);
		boolean b = false;
		if(rst != null) {
			b = true;
		}
		if (type.equals("id")) {
			map.put("cid", b);
		} else {
			map.put("cid", b);
		}
	}
	@RequestMapping("/member/join_rst.j")
	public ModelAndView join_rst(@RequestParam Map param, HttpSession session) {
		ModelAndView mav = new ModelAndView("/member/join_rst");
		String address = String.format("%s!%s!%s", param.get("postcode"),param.get("address1"),param.get("address2"));
		String phone = String.format("%s-%s-%s", param.get("phone").toString().substring(0, 3),param.get("phone").toString().substring(3, 7),param.get("phone").toString().substring(7, 11));
		String birth = String.format("%s/%s/%s", param.get("birth").toString().substring(0, 4),param.get("birth").toString().substring(4, 6),param.get("birth").toString().substring(6, 8));
		param.put("address", address);
		param.put("phone", phone);
		param.put("birth", birth);
		System.out.println(param);
		boolean r;
		if (session.getAttribute("suckey").equals("TT")) {
			r = mdao.join(param);
			boolean bl = mdao.alarm(param);
			if (r == true) {
				session.setAttribute("auth", param.get("id"));
			}
		} else {
			r = false;
		}
		mav.addObject("rst",r);
		return mav;
		
	}
	@RequestMapping("/member/emailaccredit.j")
	@ResponseBody
	public ModelAndView emailaccredit(HttpSession session, @RequestParam Map param) {
		ModelAndView mav = new ModelAndView("member/result");
		MimeMessage msg = sender.createMimeMessage();
		String fu = UUID.randomUUID().toString();
		String sfu = fu.substring(0, 8);
		System.out.println(sfu);
		session.setAttribute("uuid", sfu);
		try {
			InternetAddress from = new InternetAddress("admin");
			msg.setSender(from);
			InternetAddress to = new InternetAddress((String) param.get("email"));
			msg.setRecipient(RecipientType.TO, to);
			msg.setSubject("�솚�쁺�빀�땲�떎");
			String text = "<h1>�븞�뀞�븯�꽭�슂</h1>";
			text += "媛��엯�쓣 �솚�쁺�빀�땲�떎.";
			text += "�씤利앸쾲�샇�뒗 : " + sfu + " �엯�땲�떎.";
			msg.setText(text, "UTF-8", "html");
			sender.send(msg);
			mav.addObject("rst", true);
		} catch (MessagingException e) {
			mav.addObject("rst", false);
			e.printStackTrace();
		}

		return mav;
	}
	@RequestMapping("/member/result.j")
	public ModelAndView join_02(HttpSession session, @RequestParam Map param) {
		ModelAndView mav = new ModelAndView("/member/result");
		String uuid = (String) session.getAttribute("uuid");
		System.out.println("session �뿉 �엳�뜕uuid : " + uuid);
		if (uuid.equals(param.get("contxt"))) {
			mav.addObject("rst", true);
			session.setAttribute("suckey", "TT");
		} else {
			mav.addObject("rst", false);
			session.setAttribute("suckey", "FF");
		}
		return mav;
	}
	
	@RequestMapping("/member/login_rst.j")
	public ModelAndView login_rst(@RequestParam Map param, @RequestParam(name = "keep", required = false) String keep,
			HttpSession session, HttpServletResponse resp) {
		boolean bl = mdao.login(param);
		if (keep != null) {
			Cookie c = new Cookie("keep", (String) param.get("id"));
			c.setMaxAge(60 * 60 * 24 * 7);
			c.setPath("/");
			resp.addCookie(c);
		}
		if (bl == true) {
			session.setAttribute("auth", (String) param.get("id"));
		}
		ModelAndView mav = new ModelAndView("tw_member/login_rst");
		mav.addObject("bl", bl);
		return mav;
	}
	@RequestMapping("/member/logout.j")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/createCupon.j")
	@ResponseBody
	public Map createCupon(@RequestParam Map params, HttpSession session){
		System.out.println("auth : "+session.getAttribute("auth"));
		System.out.println("params : "+params);
		Map map = new HashMap<>();
		if(session.getAttribute("auth") == null){
			System.out.println("auth 없다. return null");
			map.put("auth", false);
		}else{
			System.out.println("auth 있다.");
			map.put("auth", true);
			String auth = (String)session.getAttribute("auth");
			params.put("id", auth);
			boolean b = ad.createCupon(params);
			System.out.println("결과 : "+b);
			map.put("b", b);
		}
		return map;
	} 
	
	@RequestMapping("/deny_popup.j")
	@ResponseBody
	public boolean deny_popup(@RequestParam(name="num") String num, HttpServletResponse response){
		Cookie c = new Cookie("deny"+num, num);
		c.setPath("/");
		c.setMaxAge(60 * 60 * 24);
		response.addCookie(c);
		return true;
	}
}
