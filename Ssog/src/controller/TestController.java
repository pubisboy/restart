package controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.ModelTestDao;
import paging.Paging;

@Controller
@RequestMapping("/test")
public class TestController {
	
	@Autowired
	Paging paging;
	
	@Autowired
	ModelTestDao mtd;

	@RequestMapping({"/","/index"})
	public String test(Map<String, Object> map){
		int i = mtd.testSelect();
		map = paging.calcPaging(6, i);
		System.out.println(paging.toString());
		return "/test";
	}
	
	@RequestMapping("/test2.j")
	public ModelAndView test2(){
		// 기본 설정
		// 1. 한 페이지에 몇 개의 data를 출력할 것인지
		// 2. 화면에 표시할 page 개수
		paging.setDefaultSetting(3, 4);
		
		// data의 전체 count 필요
		// 실제 사용 때는 DB에서 추출
		// int i = mtd.testSelect();
		int i = 31;
		
		// 현재 page와 data의 전체 count 전달
		Map<String, Object> map = paging.calcPaging(5, i);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging", map);
		mav.setViewName("/test");
		System.out.println(paging.toString());
		return mav;
	}
	
	@RequestMapping("/test3.j")
	public ModelAndView test3(){
		paging.setDefaultSetting(3, 4);
		int i = mtd.testSelect();
		Map<String, Object> map = paging.calcPaging(3, i);
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging", map);
		mav.setViewName("/test");
		System.out.println(paging.toString());
		return mav;
	}
}