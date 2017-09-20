package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.SellerInfoDao;
import model.SellerOrderDao;


@Controller
@RequestMapping("/seller")
public class SellerInfoController {
	@Autowired
	SellerInfoDao sdao;
	
	@Autowired
	SellerOrderDao sodao;
	
	
	@RequestMapping("/test.j")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView("t_el_seller");
		mav.addObject("section", "seller/test");
		return mav;
	}
	
	@RequestMapping("/main.j")
	public ModelAndView toIndex() {
		ModelAndView mav = new ModelAndView("t_el_seller");
		mav.addObject("section", "seller/main");
		return mav;
	}

	@RequestMapping("/info/join.j")
	public ModelAndView join(@RequestParam Map map) {
		ModelAndView mav = new ModelAndView("t_el_seller");
		mav.addObject("section", "seller/info/join");
		return mav;
	}
	
	//회원가입에서 ID, 계좌번호 중복체크
	@RequestMapping("/info/joinAjax.j")
	@ResponseBody
	public Map joinajax(@RequestParam(name = "type") String type, @RequestParam(name = "val") String val) {
		boolean flag = false;
		if (type.equals("id")) {
			flag = (sdao.overlapChk(val, "id")==null)? true : false;
		} else {
			flag = (sdao.overlapChk(val, "account")==null)? true : false;
		}
		Map map = new HashMap<>();
		map.put("join_check", flag);
		return map;
	}
	
	
	@RequestMapping("/alert/join_rst.j")
	public ModelAndView join_rst(@RequestParam Map param, HttpSession session) {
		ModelAndView mav = new ModelAndView("t_el_seller");
		boolean b = sdao.join(param);
		if(b) {
			session.setAttribute("seller_id", (String)param.get("id"));
		} 
		mav.addObject("rst", b);
		mav.addObject("section", "seller/alert/join_rst");
		return mav;
	}
	
	@RequestMapping("/alert/login_rst.j")
	public ModelAndView login_rst(@RequestParam Map param, @RequestParam(name = "keep", required = false) String keep,
			HttpSession session, HttpServletResponse resp) {
		ModelAndView mav = new ModelAndView("t_el_seller");
		System.out.println(param);
		boolean rst = sdao.login(param);
		System.out.println(rst);
			
		if(rst == true){
			System.out.println("로그인성공");
			session.setAttribute("seller_id", (String) param.get("id"));
			
			String id = (String)session.getAttribute("seller_id");
			//등급
			int sum_price = sodao.sumPrice(id);
			Map grade_map = sodao.sellerGrade(sum_price);
			String grade = (String) grade_map.get("GRADE");
			session.setAttribute("grade", grade);
			
			//주문현황
			
			Map<String,Object> myinfo_map = sdao.overlapChk(id, "id");
			System.out.println(">>>" + myinfo_map);
			mav.addObject("myinfo", myinfo_map);
			
			if (keep != null) {
				Cookie c = new Cookie("keep", (String) param.get("id"));
				c.setMaxAge(60 * 60 * 24 * 7);
				c.setPath("/");
				resp.addCookie(c);
			}
		}
		mav.addObject("section", "seller/main");
		mav.addObject("rst", rst);
		
		return mav;
	}
	
	
	@RequestMapping("/logout.j")
	public String logout(HttpSession session, HttpServletResponse response){
		session.invalidate();
			Cookie c = new Cookie("keep", null);
			c.setPath("/");
			c.setMaxAge(0);
			response.addCookie(c);
		return "redirect:/seller/main.j";
	}
	
	//회원탈퇴
	@RequestMapping("/delete.j")
	public String delete(HttpSession session, HttpServletResponse response){
		String id = (String)session.getAttribute("seller_id");
		boolean rst = sdao.delete(id);
		if(rst) {
			session.invalidate();
				Cookie c = new Cookie("keep", null);
				c.setPath("/");
				c.setMaxAge(0);
				response.addCookie(c);
			return "redirect:/";
		} else {
			return "회원 탈퇴 실패";
		}
	}
	
	//ID, 비밀번호 찾기
	@RequestMapping("/info/find.j")
	public ModelAndView find() {
		ModelAndView mav = new ModelAndView("t_el_seller");
		mav.addObject("section", "seller/info/find");
		return mav;
	}
	
	@RequestMapping("/info/find_ok.j")
	public ModelAndView find_ok(@RequestParam(name="account", required = false) String account) {
		ModelAndView mav = new ModelAndView("t_el_seller");
			Map map = sdao.overlapChk(account, "account");
				String id =  sdao.change((String)map.get("ID"));
				String pwd = sdao.change((String)map.get("PASS"));
		mav.addObject("id", id);
		mav.addObject("pwd", pwd);
		mav.addObject("section", "seller/info/find_ok");
		return mav;
	}
	
	//비밀번호 입력
	@RequestMapping("/info/pass.j")
	public ModelAndView pass() {
		ModelAndView mav = new ModelAndView("t_el_seller");
		mav.addObject("section", "seller/info/pass");
		return mav;
	}
	
	//정보보기
	@RequestMapping("/info/info.j")
	public ModelAndView info(HttpSession session) {
		ModelAndView mav = new ModelAndView("t_el_seller");
			String id = (String)session.getAttribute("seller_id");
			Map<String,Object> map = sdao.overlapChk(id, "id");
			map.put("id", id);
		mav.addObject("map", map);
		mav.addObject("section", "seller/info/info"); 
		return mav;
	}
	
	//정보 수정 폼
	@RequestMapping("/info/info_edit.j")
	public ModelAndView editInfo(HttpSession session) {
		ModelAndView mav = new ModelAndView("t_el_seller");
		String id = (String)session.getAttribute("seller_id");
		Map<String,Object> map = sdao.overlapChk(id, "id");
			map.put("id", id);
		mav.addObject("map", map);
		mav.addObject("section", "seller/info/info_edit");
		return mav;
	}
	 
	 @RequestMapping("/info/info_edit_ok.j")
		public ModelAndView editInfoRst(@RequestParam Map map, HttpSession session) {
			ModelAndView mav = new ModelAndView("t_el_seller");
			String id = (String)session.getAttribute("seller_id");
			
			map.put("id", id);
			boolean b = sdao.editInfo(map);
			if(b) {
				mav.addObject("rst", b);
			}
			
			mav.addObject("section", "seller/alert/edit_rst");
			return mav;
		}
	
	 
	 //비밀번호 변경 폼
	@RequestMapping("/info/pass_edit.j")
	public ModelAndView editPass(@RequestParam Map map, HttpSession session) {
		ModelAndView mav = new ModelAndView("t_el_seller");
		String id = (String)session.getAttribute("seller_id");
		map.put("id", id);
		mav.addObject("section", "seller/info/pass_edit");
		return mav;
	}
	
	//비밀번호 변경 폼에서 이전 비번 가져오기
		@RequestMapping("/info/passAjax.j")
		@ResponseBody
		public Map passajax(@RequestParam Map param, HttpSession session){
			String id = (String)session.getAttribute("seller_id");
			String pass = (String) param.get("pass");
			
			boolean flag = false;
			Map m = sdao.overlapChk(id, "id");
			String db_pass = (String) m.get("PASS");
			if (pass.equals(db_pass)) {
				param.put("id", id);
				boolean rst = sdao.editPass(param);
				if(rst)	flag = true;
			} else {
				flag = false;
			}
			Map map = new HashMap<>();
			map.put("pre_check", flag);
			return map;
		}
}
