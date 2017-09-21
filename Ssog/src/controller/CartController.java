package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.http.HttpRequest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.CartDao;
import model.MemberDao;
import model.MyinfoDao;
import model.ProductDao;

@Controller
@RequestMapping("/cart")
public class CartController {
	@Autowired
	ProductDao pdao;
	@Autowired
	MemberDao mmdao;
	@Autowired
	MyinfoDao mdao;
	@Autowired
	CartDao cdao;
	@Autowired
	JavaMailSender sender;

	public Map init(HttpSession session) {
		String id = (String) session.getAttribute("auth");
		Map grade = mdao.usergrade(id);
		Map info = mmdao.id_check_repetition(id);
		Map map = new HashMap<>();
		map.put("id", id);
		map.put("grade", grade);
		map.put("info", info);
		return map;
	}

	@RequestMapping("/form.j")
	public ModelAndView cart(HttpServletRequest resp, HttpSession session) {
		Map init = init(session);
		ModelAndView mav = new ModelAndView("tw_cart/form");
		mav.addObject("grade", init.get("grade"));
		mav.addObject("memberinfo", init.get("info"));
		List<Map> clist = cdao.couponlist((String) init.get("id"));
		Map point = cdao.point((String) init.get("id"));
		mav.addObject("point", point);
		mav.addObject("clist", clist);
		Map dmap = cdao.dhl();
		mav.addObject("dhl", dmap);
		Cookie[] cookies = resp.getCookies();
		List<Map> list = new ArrayList<>();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getValue().startsWith("addcart")) {
					String cookiename = cookies[i].getName();
					String number = cookies[i].getValue().substring(7);
					Map map = pdao.cart(cookiename);
					Map elist = pdao.event_list(cookiename); 
					System.out.println("elist : "+elist); 
					map.put("number", number);
					list.add(map);
					System.out.println(list);
					int etc = list.size();
					mav.addObject("list", list);
					mav.addObject("etc", etc);
					mav.addObject("elist", elist);
				}
			}
		}
		return mav;
	}

	@RequestMapping("/order.j")
	public ModelAndView order(HttpServletRequest resp, HttpSession session) {
		Map init = init(session);
		Map info = mmdao.id_check_repetition((String) init.get("id"));
		ModelAndView mav = new ModelAndView("tw_cart/order");
		Map dmap = cdao.dhl();
		mav.addObject("dhl", dmap);
		String address = (String) info.get("ADDRESS");
		String phone = (String) info.get("PHONE");
		String[] spaddress = address.split("!");
		String[] phonenum = phone.split("-");
		mav.addObject("postcode", spaddress[0]);
		mav.addObject("address1", spaddress[1]);
		mav.addObject("address2", spaddress[2]);
		mav.addObject("phone1", phonenum[0]);
		mav.addObject("phone2", phonenum[1]);
		mav.addObject("phone3", phonenum[2]);
		mav.addObject("memberinfo", init.get("info"));
		List<Map> clist = cdao.couponlist((String) init.get("id"));
		Map point = cdao.point((String) init.get("id"));
		mav.addObject("point", point);
		mav.addObject("clist", clist);
		Cookie[] cookies = resp.getCookies();
		List<Map> list = new ArrayList<>();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getValue().startsWith("addcart")) {
					String cookiename = cookies[i].getName();
					String number = cookies[i].getValue().substring(7);
					Map map = pdao.cart(cookiename);
					map.put("number", number);
					list.add(map);
					mav.addObject("list", list);
				}
			}
		}
		return mav;
	}
	@RequestMapping("/orderr.j")
	public ModelAndView orderr(HttpSession session,@RequestParam Map param) {
		ModelAndView mav = new ModelAndView("tw_cart/orderr");
		Map init = init(session);
		Map dmap = cdao.dhl();
		mav.addObject("dhl", dmap);
		Map info = mmdao.id_check_repetition((String) init.get("id"));
		String address = (String) info.get("ADDRESS");
		String phone = (String) info.get("PHONE");
		String[] spaddress = address.split("!");
		String[] phonenum = phone.split("-");
		mav.addObject("postcode", spaddress[0]);
		mav.addObject("address1", spaddress[1]);
		mav.addObject("address2", spaddress[2]);
		mav.addObject("phone1", phonenum[0]);
		mav.addObject("phone2", phonenum[1]);
		mav.addObject("phone3", phonenum[2]);
		mav.addObject("memberinfo", init.get("info"));
		List<Map> clist = cdao.couponlist((String) init.get("id"));
		Map point = cdao.point((String) init.get("id"));
		mav.addObject("point", point);
		mav.addObject("clist", clist);
		Map plist = pdao.cart((String)param.get("num"));
		System.out.println(plist);
		mav.addObject("plist", plist);
		mav.addObject("param", param);
		return mav;
	}

	@RequestMapping("/order_rst.j")
	public ModelAndView order_rst(@RequestParam Map param) {
		ModelAndView mav = new ModelAndView("cart/payment");
		boolean bl = cdao.order(param);
		return mav;
	}

	@RequestMapping("/popup_couponlist.j")
	public ModelAndView popup(HttpSession session, @RequestParam(name = "price") String price) {
		ModelAndView mav = new ModelAndView("cart/popup_couponlist");
		Map init = init(session);
		List<Map> list = cdao.couponlist((String) init.get("id"));
		mav.addObject("list", list);
		mav.addObject("price", price);
		return mav;
	}

	@RequestMapping("/popup_pay.j")
	public ModelAndView pay() {
		ModelAndView mav = new ModelAndView("cart/popup_pay");
		return mav;
	}

	@RequestMapping("/emailaccredit.j")
	@ResponseBody
	public ModelAndView emailaccredit(HttpSession session, @RequestParam Map param) {
		ModelAndView mav = new ModelAndView("cart/result");
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
			String text = "<h2>인증번호입니다.</h2>";
			text += sfu;
			msg.setText(text, "UTF-8", "html");
			sender.send(msg);
			mav.addObject("rst", true);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("rst", false);
		}
		return mav;
	}

	@RequestMapping("/keyaccredit.j")
	@ResponseBody
	public boolean key(HttpSession session, @RequestParam Map param) {
		System.out.println(param);
		String uuid = (String) session.getAttribute("uuid");
		System.out.println("session uuid : " + uuid);
		if (uuid.equals((String) param.get("key"))) {
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping("/payment.j")
	public ModelAndView payment(@RequestParam Map param, HttpSession session, Map map,
			@RequestParam(name = "pd1") String[] ar1, @RequestParam(name = "pd2") String[] ar2,HttpServletRequest resp) {
		Map init = init(session);
		Map info = mmdao.id_check_repetition((String) init.get("id"));
		ModelAndView mav = new ModelAndView("tw_cart/payment");
		mav.addObject("memberinfo", init.get("info"));
		String ad1 = (String) param.get("postcode");
		String ad2 = (String) param.get("address1");
		String ad3 = (String) param.get("address2");
		String address = ad1 + "!" + ad2 + "!" + ad3;
		String address2 = ad1 + "　" + ad2 + "　" + ad3;
		param.put("address", address);
		String ph1 = (String) param.get("phone1");
		String ph2 = (String) param.get("phone2");
		String ph3 = (String) param.get("phone3");
		String phone = ph1 + "!" + ph2 + "!" + ph3;
		param.put("phone", phone); 
		if(param.get("onecoupon")!="") {
		String coupon = (String) param.get("onecoupon");
		int index = coupon.indexOf("%");
		String cupon = coupon.substring(0, index);
		param.put("cupon", cupon);
		boolean blll = cdao.coupondel(param);
		System.out.println(blll); 
		}
		param.put("id", (String) init.get("id"));
		System.out.println(param);
		map.put("ar1", ar1);
		map.put("ar2", ar2);
		String[] pd1 = (String[]) map.get("ar1");
		String[] pd2 = (String[]) map.get("ar2");
		boolean bl = false;
		for (int i = 0; i < pd1.length; i++) {
			param.put("pd1", pd1[i]);
			param.put("pd2", pd2[i]); 
			cdao.order(param); 
		}
		String totalcash = (String) param.get("totalcash");
		map.put("address", address2);
		
		mav.addObject("map", map); 
		mav.addObject("param", param);
		System.out.println(map);
		if (bl == true) {
			System.out.println("결제완료");
			cdao.userpoint(param);
		}
		for (int i = 0; i < pd1.length; i++) {
			Map data = new HashMap<>();
			data.put("pd1", pd1[i]);
			data.put("pd2", pd2[i]);
			cdao.orderupdate(data);
		}
		
		Cookie[] cookies = resp.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getValue().startsWith("addcart")) {
				String cookiename = cookies[i].getName();
				String number = cookies[i].getValue().substring(7);
			System.out.println("cookiename : "+cookiename);
			System.out.println("number : "+number); 
			}
		}
		String pt_chk = (String)param.get("chk_point");
		if(pt_chk.equals("save")) {
			boolean bool1 = cdao.user_recordupdate1(param);
			System.out.println(bool1);
		}else {
			boolean bool2 = cdao.user_recordupdate2(param);
			System.out.println(bool2); 
		}  
		return mav;
		
	}

	@RequestMapping("/ascertain.j")
	@ResponseBody
	public boolean ascertain(@RequestParam Map param) {
		System.out.println("param : " + param);
		String pd_num = (String) param.get("pd1");
		String[] sp1 = pd_num.split("!");
		String pr_num = (String) param.get("pd2");
		String[] sp2 = pr_num.split("!");
		boolean bl = true;
		for (int i = 0; i < sp1.length; i++) {
			Map data = new HashMap<>();
			data.put("pd1", sp1[i]);
			data.put("pd2", sp2[i]);
			Map pmap = cdao.pd_ascertain(data);
			System.out.println(pmap);
			if (pmap == null) {
				bl = false;
			} else {
				bl = true;
			}
		}
		return bl;
	}
}
