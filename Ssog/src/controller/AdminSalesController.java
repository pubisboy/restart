package controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.AdminSalesDao;
import paging.Paging;
import paging.Title;

@Controller
@RequestMapping("/admin/sales")
public class AdminSalesController {
	
	@Autowired
	Paging pg;
	
	@Autowired
	Title tt;
	
	@Autowired
	AdminSalesDao asd;

	@RequestMapping("/sales/sales_list.ja")
	public String getSales_list(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map) throws ParseException{
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		params.put("p", p);
		System.out.println("params의 value : "+params.get("value"));
		System.out.println("진입 시의 params : "+params);
		
		String bTime = null;
		String fTime = null;
		
		Calendar c = GregorianCalendar.getInstance();
		
		String term = (String)params.get("term");
		
		if(params.get("term") == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			String f = sdf.format(c.getTime());
			c.add(Calendar.DATE, -6);
			String b = sdf.format(c.getTime());
			bTime = b;
			fTime = f;
			params.put("term", "yy/MM/dd");
			params.put("begin", b);
			params.put("final", f);
		}else{
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			System.out.println("term : "+term);
			String by = (String)params.get("by");
			String bm = (String)params.get("bm");
			bm = bm.equals("none") ? "1" :  bm;
			String bd = (String)params.get("bd");
			bd = bd.equals("none") ? "1" :  bd;
			String ey = (String)params.get("ey");
			String em = (String)params.get("em");
			em = em.equals("none") ? "1" :  em;
			String ed = (String)params.get("ed");
			ed = ed.equals("none") ? "1" :  ed;
			

			System.out.println(String.format("by : %s / bm : %s / bd : %s / ey : %s / em : %s / ed : %s", by,bm,bd,ey,em,ed));
			String tmp = String.format("%s/%s/%s", by,bm,bd);
			System.out.println("tmp : "+tmp);
			Date tes = sdf.parse(tmp);
			Date begind = new Date();
			if(tes.getTime() > begind.getTime()){
				tes = begind;
				by = Integer.toString(c.get(Calendar.YEAR));
				bm = Integer.toString(c.get(Calendar.MONTH)+1);
				bd = Integer.toString(c.get(Calendar.DATE) - 6);
				System.out.println("변경 된 ed : "+ed);
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", bd);
			}
			bTime = sdf.format(tes);
			tmp = String.format("%s/%s/%s", ey,em,ed);
			System.out.println("tmp : "+tmp);
			tes = sdf.parse(tmp);
			Date endd = new Date();
			if(tes.getTime() > endd.getTime()){
				tes = endd;
				ey = Integer.toString(c.get(Calendar.YEAR));
				em = Integer.toString(c.get(Calendar.MONTH)+1);
				ed = Integer.toString(c.get(Calendar.DATE));
				System.out.println("변경 된 ed : "+ed);
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", ed);
			}
			fTime = sdf.format(tes);
			
			System.out.println("시작 : "+bTime);
			System.out.println("끝 : "+fTime);
			c.setTime(sdf.parse(bTime));
			params.put("begin", bTime);
			params.put("final", fTime);
		}
		
		pg.setDefaultSetting(10, 10);
		int rows = asd.getSales_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		System.out.println("params : "+params);
		List list = asd.getSales_list(params);
		System.out.println("매출액 : "+list);
		Calendar cal = Calendar.getInstance();
		int y = cal.get(Calendar.YEAR);
		int year = y;
		List li = new ArrayList<>();
		for(int i = 0; i < 10; i++){
			li.add(year-i);
		}
		
		// 수정 필요 시작 부분
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		List lis = asd.getSales_excel(params);
		List days = new ArrayList<>();
		String tmp = bTime;
		
		while(true){
			System.out.println("tmp : "+tmp);
			System.out.println("fTime : "+fTime);
			Map mtmp = new HashedMap();
			tmp = sdf.format(c.getTime());
			boolean bb = false;
			for(Object o : lis){
				Map m = (Map)o;
				String t = (String)m.get("PAY_DATE");
				if(t.equals(tmp)){
					BigDecimal bd = (BigDecimal)m.get("PRICE");
					mtmp.put("day", tmp);
					mtmp.put("price", bd.intValue());
					bd = (BigDecimal)m.get("COUNT");
					mtmp.put("order", bd.intValue());
					bb = true;
					break;
				}
			}
			if(!bb){
				mtmp.put("day", tmp);
				mtmp.put("price", 0);
				mtmp.put("order", 0);
			}
			days.add(mtmp);
			System.out.println("날짜 : "+tmp);
			if(tmp.equals(fTime)){
				break;
			}
			c.add(Calendar.DATE, 1);
		}
		
		System.out.println("days : "+days);
		// 수정 필요 끝 부분
		map.put("days", days);
		map.put("years", li);
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		
		map.put("total", total);
		map.put("list", list);
		map.put("paging", paging);
		if(params.get("term") != null){
			map.put("params", params);
		}
		map.put("section", "/sales/sales_list");
		return "ad_sales";
	}
	
	@RequestMapping("/sales/calc_day.ja")
	@ResponseBody
	public String calc_day(@RequestParam Map params){
		Map map = new HashedMap();
		System.out.println("날짜 ajax : "+params);
		Calendar c = Calendar.getInstance();
		String ys = (String)params.get("y");
		String ms = (String)params.get("m");
		String ds = (String)params.get("d");
		int y = c.get(Calendar.YEAR);
		if(!ys.equals("none")){
			y = Integer.parseInt(ys);
		}
		int m = Integer.parseInt((String)params.get("m"));
		int d = Integer.parseInt((String)params.get("d"));
		c.set(y, m-1, d);
		int day = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		String be = (String)params.get("be");
		String target = null;
		if(be.equals("b")){
			target = "bd";
		}else{
			target = "ed";
		}
		
		String rst = "<option value='none'>--</option>";
		for(int i = 1; i <= day; i++){
			rst += String.format("<option value='%d' id='%d%s'>%d</option>", i, i, target, i);
		}
		return rst;
	}
	
	@RequestMapping("/sales/sales_excel.ja")
	public String sales_excel(@RequestParam Map params, Map map) throws ParseException{
		
		String bTime = null;
		String fTime = null;
		
		Calendar c = GregorianCalendar.getInstance();
		
		String term = (String)params.get("term");
		
		if(params.get("by") == "" && params.get("ey") == ""){
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			String f = sdf.format(c.getTime());
			c.add(Calendar.DATE, -7);
			String b = sdf.format(c.getTime());
			params.put("term", "yy/MM/dd");
			bTime = b;
			fTime = f;
			params.put("begin", b);
			params.put("final", f);
		}else{
			System.out.println("term : "+term);
			String by = (String)params.get("by");
			String bm = (String)params.get("bm");
			bm = bm.equals("none") ? "1" :  bm;
			String bd = (String)params.get("bd");
			bd = bd.equals("none") ? "1" :  bd;
			String ey = (String)params.get("ey");
			String em = (String)params.get("em");
			em = em.equals("none") ? "1" :  em;
			String ed = (String)params.get("ed");
			ed = ed.equals("none") ? "1" :  ed;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");

			System.out.println(String.format("by : %s / bm : %s / bd : %s / ey : %s / em : %s / ed : %s", by,bm,bd,ey,em,ed));
			String tmp = String.format("%s/%s/%s", by,bm,bd);
			System.out.println("tmp : "+tmp);
			Date tes = sdf.parse(tmp);
			bTime = sdf.format(tes);
			tmp = String.format("%s/%s/%s", ey,em,ed);
			System.out.println("tmp : "+tmp);
			tes = sdf.parse(tmp);
			fTime = sdf.format(tes);
			
			System.out.println("시작 : "+bTime);
			System.out.println("끝 : "+fTime);
			params.put("begin", bTime);
			params.put("final", fTime);
		}
		System.out.println("bTime : "+bTime);
		System.out.println("fTime : "+fTime);
		map.put("begin", bTime);
		map.put("end", fTime);
		List list = asd.getSales_excel(params);
		System.out.println("Excel용 list : "+list);
		map.put("list", list);
		return "salesExcel";
	}
	
	/*@RequestMapping("/sales/sales_chart.ja")
	public String getSales_chart(@RequestParam Map params, @RequestParam(name="p", defaultValue="1") String pp, Map map) throws ParseException{
		int p = 0;
		try{
			p = Integer.parseInt(pp);
		}catch(Exception e){
			System.out.println("변환 불가능");
			p = 1;
		}
		System.out.println("params의 value : "+params.get("value"));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		Calendar c = Calendar.getInstance();
		
		String now = sdf.format(c.getTime());
		Date tmp = sdf.parse(now);
		long t = tmp.getTime() - (1000 * 60 * 60 * 24);
		Date b = new Date(t);
		String begin = sdf.format(b);
		params.put("begin", begin);
		params.put("final", now);
		System.out.println("begin : "+begin + " / now : "+now);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		
		String bTime = null;
		String fTime = null;
		Calendar c = GregorianCalendar.getInstance();
		
		if(params.get("bd") == null && params.get("fd") == null){
			String f = sdf.format(c.getTime());
			c.add(Calendar.DATE, -7);
			String b = sdf.format(c.getTime());
			params.put("begin", b);
			params.put("final", f);
		}else{
			String tmp = String.format("%s/%s/%s", (String)params.get("by"), (String)params.get("bm"), (String)params.get("bd"));
			Date tes = sdf.parse(tmp);
			bTime = sdf.format(tes);
			tmp = String.format("%s/%s/%s", (String)params.get("fy"), (String)params.get("fm"), (String)params.get("fd"));
			tes = sdf.parse(tmp);
			fTime = sdf.format(tes);
			System.out.println("시작 : "+bTime);
			System.out.println("끝 : "+fTime);
			params.put("begin", bTime);
			params.put("final", fTime);
		}
		
		pg.setDefaultSetting(10, 10);
		int rows = asd.getSales_list_count(params);
		pg.setNumberOfRecords(rows);
		Map paging = pg.calcPaging(p, rows);
		// System.out.println("paging : "+paging);
		Map se = pg.calcBetween(p);
		params.put("start", se.get("start"));
		params.put("end", se.get("end"));
		System.out.println("params : "+params);
		List list = asd.getSales_list(params);
		System.out.println("매출액 : "+list);

		Date f = sdf.parse(fTime);
		Date b = sdf.parse(bTime);
		
		c.setTimeInMillis(b.getTime());
		String tmp = bTime;
		
		List days = new ArrayList<>();
		while(list != null){
			Map mtmp = new HashedMap();
			tmp = sdf.format(c.getTime());
			boolean bb = false;
			for(Object o : list){
				Map m = (Map)o;
				String t = (String)m.get("PAY_DATE");
				if(t.equals(tmp)){
					BigDecimal bd = (BigDecimal)m.get("PRICE");
					mtmp.put("day", tmp);
					mtmp.put("price", bd.intValue());
					bb = true;
					break;
				}
			}
			if(!bb){
				mtmp.put("day", tmp);
				mtmp.put("price", 0);
			}
			days.add(mtmp);
			System.out.println("날짜 : "+tmp);
			if(tmp.equals(fTime)){
				break;
			}
			c.add(Calendar.DATE, 1);
		}
		
		System.out.println("days : "+days);
		DecimalFormat df = new DecimalFormat("#,###");
		String total = df.format(rows);
		map.put("total", total);
		map.put("list", list);
		map.put("paging", paging);
		map.put("params", params);
		map.put("section", "/sales/chart");
		return "ad_sales";
	}*/
	/*
	@RequestMapping("/sales/calc_year.ja")
	@ResponseBody
	public Map calc_year(@RequestParam Map params){
		Map map = new HashedMap();
		System.out.println("날짜 ajax : "+params);
		String term = (String)params.get("term");
		
		String rstB = "<select name='by' id='by'><optgroup label='년'></optgroup>";
		String rstE = "<select name='ey' id='ey'><optgroup label='년'></optgroup>";
		Calendar c = Calendar.getInstance();
		int y = c.get(Calendar.YEAR);
		int year = y - 2000;
		
		for(int i = 0; i < 10; i++){
			rstB += String.format("<option value='%d'>%d</option>", year, year);
			rstE += String.format("<option value='%d'>%d</option>", year, year--);
		}
		rstB += "</select>";
		rstE += "</select>";
		
		String rstS = "<button id='submin'>검색</button>";
		
		if(term.equals("yy")){
			map.put("b", rstB);
			map.put("e", rstE);
			map.put("s", rstS);
			return map;
		}else if(term.equals("yy/MM")){
			rstB += "<select name='bm' id='bm'><optgroup label='월'></optgroup>";
			rstE += "<select name='em' id='em'><optgroup label='월'></optgroup>";
			for(int i = 1; i <= 12; i++){
				rstB += String.format("<option value='%d'>%d</option>", i, i);
				rstE += String.format("<option value='%d'>%d</option>", i, i);
			}
			rstB += "</select>";
			rstE += "</select>";
			map.put("b", rstB);
			map.put("e", rstE);
			map.put("s", rstS);
			return map;
		}else{
			rstB += "<select name='bm' id='bm'><optgroup label='일'></optgroup>";
			rstE += "<select name='em' id='em'><optgroup label='일'></optgroup>";
			for(int i = 1; i <= 12; i++){
				rstB += String.format("<option value='%d'>%d</option>", i, i);
				rstE += String.format("<option value='%d'>%d</option>", i, i);
			}
			rstB += "</select>";
			rstB += "<select name='bd' id='bd'><option>--</option></select>";
			
			rstE += "</select>";
			rstE += "<select name='ed' id='ed'><option>--</option></select>";
			map.put("b", rstB);
			map.put("e", rstE);
			map.put("s", rstS);
			return map;
		}
	}
	*/
	
}