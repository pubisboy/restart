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

		Date bg = null;
		Date en = null;
		
		String term = (String)params.get("term");
		String bytest = (String)params.get("by");
		if(term == null || bytest.length() < 1){
			term = "yy/MM/dd";
			System.out.println("기본 진입");
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			bg = c.getTime();
			String f = sdf.format(bg);
			c.add(Calendar.DATE, -6);
			en = c.getTime();
			String b = sdf.format(en);
			bTime = b;
			fTime = f;
			params.put("term", "yy/MM/dd");
			params.put("begin", b);
			params.put("final", f);
		}else{
			System.out.println("변동 진입");
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
			
			if(term.endsWith("yy")){
				bm = "1";
				bd = "1";
				em = "12";
				ed = "31";
				
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				System.out.println("bTime : "+bTime);
				System.out.println("fTime : "+fTime);
				params.put("by", by);
				params.put("bm", "none");
				params.put("bd", "none");
				params.put("ey", ey);
				params.put("em", "none");
				params.put("ed", "none");
				c.setTime(bg);
				
			}else if(term.endsWith("yy/MM")){
				bd = "1";
				ed = "1";
				String s = String.format("%s/%s/%s", ey,em,ed);
				Date yymm = sdf.parse(s);
				Calendar cal = Calendar.getInstance();
				c.setTime(yymm);
				int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				ed = Integer.toString(day);
				
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				System.out.println("bTime : "+bTime);
				System.out.println("fTime : "+fTime);
				
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", "none");
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", "none");
				c.setTime(bg);
				
			}else if(term.endsWith("yy/MM/dd")){
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", bd);
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", ed);
				c.setTime(bg);
			}
			
			params.put("begin", bTime);
			params.put("final", fTime);
			
			System.out.println(String.format("%s / %s / %s, %s / %s / %s", by, bm, bd, ey, em, ed));
			System.out.println("begin : "+bTime);
			System.out.println("final : "+fTime);
			
			Calendar c2 = Calendar.getInstance();
			Date tes = sdf.parse(bTime);
			Date begind = c2.getTime();
			System.out.println("들어온 시간 : "+tes.getTime());
			System.out.println("지금 시간 : "+begind.getTime());
			by = Integer.toString(c2.get(Calendar.YEAR));
			bm = Integer.toString(c2.get(Calendar.MONTH)+1);
			bd = Integer.toString(c2.get(Calendar.DATE) - 6);
			System.out.println("변경 된 bd : "+bd);
			String tt = String.format("%s/%s/%s", by,bm,bd);
			System.out.println("tt : "+tt);
			tes = sdf.parse(tt);
			bTime = sdf.format(tes);
			System.out.println("bTime : "+bTime);
			
			/*Calendar c2 = Calendar.getInstance();
			Date tes = sdf.parse(bTime);
			Date begind = c2.getTime();
			if(tes.getTime() > begind.getTime()){
				by = Integer.toString(c2.get(Calendar.YEAR));
				bm = Integer.toString(c2.get(Calendar.MONTH)+1);
				bd = Integer.toString(c2.get(Calendar.DATE) - 6);
				System.out.println("변경 된 bd : "+bd);
				String tt = String.format("%s/%s/%s", by,bm,bd);
				tes = sdf.parse(tt);
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", bd);
			}
			bTime = sdf.format(tes);
			
			// System.out.println("tmp : "+tmp);
			tes = sdf.parse(fTime);
			Date endd = new Date();
			if(tes.getTime() > endd.getTime()){
				ey = Integer.toString(c2.get(Calendar.YEAR));
				em = Integer.toString(c2.get(Calendar.MONTH)+1);
				ed = Integer.toString(c2.get(Calendar.DATE));
				System.out.println("변경 된 ed : "+ed);
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", ed);
			}
			fTime = sdf.format(endd);
			
			System.out.println("시작 : "+bTime);
			System.out.println("끝 : "+fTime);
			params.put("begin", bTime);
			params.put("final", fTime);*/
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
		System.out.println("lis : "+lis);
		System.out.println("lis ? null : "+lis == null);
		System.out.println("lis size() : "+lis.size());
		List days = new ArrayList<>();
		String tmp = bTime;
		System.out.println("시작 : "+bTime);
		System.out.println("끝 :  "+fTime);
		String tmp2 = tmp;
		
		if(term.equals("yy/MM")){
			fTime = fTime.substring(0, 5);
		}else if(term.equals("yy")){
			fTime = fTime.substring(0, 2);
		}
		
		while(true){
			Map mtmp = new HashedMap();
			if(term.equals("yy/MM/dd")){
				tmp = sdf.format(c.getTime());
				tmp2 = tmp;
				System.out.println("tmp : "+tmp);
				System.out.println("tmp2 : "+tmp2);
			}else if(term.equals("yy/MM")){
				tmp = sdf.format(c.getTime());
				tmp2 = tmp.substring(0, 5);
				System.out.println("tmp : "+tmp);
				System.out.println("tmp2 : "+tmp2);
			}else if(term.equals("yy")){
				tmp = sdf.format(c.getTime());
				tmp2 = tmp.substring(0, 2);
				System.out.println("tmp : "+tmp);
				System.out.println("tmp2 : "+tmp2);
			}
			boolean bb = false;
			for(Object o : lis){
				Map m = (Map)o;
				String t = (String)m.get("PAY_DATE");
				System.out.println("t : "+t+" / tmp2 : "+tmp2);
				// System.out.println("tmp : "+tmp);
				if(t.equals(tmp2)){
					BigDecimal bd = (BigDecimal)m.get("PRICE");
					mtmp.put("day", tmp2);
					mtmp.put("price", bd.intValue());
					bd = (BigDecimal)m.get("COUNT");
					mtmp.put("order", bd.intValue());
					bb = true;
					break;
				}
			}
			if(bb == false){
				mtmp.put("day", tmp2);
				mtmp.put("price", 0);
				mtmp.put("order", 0);
			}
			days.add(mtmp); 
			// System.out.println("날짜 : "+tmp);
			
			System.out.println("tmp2 : "+tmp2+" // fTime : "+fTime);
			if(tmp2.equals(fTime)){
				break;
			}
			if(term.equals("yy/MM/dd")){
				c.add(Calendar.DATE, 1);
			}else if(term.equals("yy/MM")){
				c.add(Calendar.MONTH, 1);
			}else if(term.equals("yy")){
				c.add(Calendar.YEAR, 1);
			}
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

		Date bg = null;
		Date en = null;
		
		String term = (String)params.get("term");
		String bytest = (String)params.get("by");
		if(term == null || bytest.length() < 1){
			term = "yy/MM/dd";
			System.out.println("기본 진입");
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			bg = c.getTime();
			String f = sdf.format(bg);
			c.add(Calendar.DATE, -6);
			en = c.getTime();
			String b = sdf.format(en);
			bTime = b;
			fTime = f;
			params.put("term", "yy/MM/dd");
			params.put("begin", b);
			params.put("final", f);
		}else{
			System.out.println("변동 진입");
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
			
			if(term.endsWith("yy")){
				bm = "1";
				bd = "1";
				em = "12";
				ed = "31";
				
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				System.out.println("bTime : "+bTime);
				System.out.println("fTime : "+fTime);
				params.put("by", by);
				params.put("bm", "none");
				params.put("bd", "none");
				params.put("ey", ey);
				params.put("em", "none");
				params.put("ed", "none");
				c.setTime(bg);
				
			}else if(term.endsWith("yy/MM")){
				bd = "1";
				ed = "1";
				String s = String.format("%s/%s/%s", ey,em,ed);
				Date yymm = sdf.parse(s);
				Calendar cal = Calendar.getInstance();
				c.setTime(yymm);
				int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				ed = Integer.toString(day);
				
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				System.out.println("bTime : "+bTime);
				System.out.println("fTime : "+fTime);
				
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", "none");
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", "none");
				c.setTime(bg);
				
			}else if(term.endsWith("yy/MM/dd")){
				bg = sdf.parse(String.format("%s/%s/%s", by,bm,bd));
				en = sdf.parse(String.format("%s/%s/%s", ey,em,ed));
				bTime = String.format("%s/%s/%s", by,bm,bd);
				fTime = String.format("%s/%s/%s", ey,em,ed);
				bTime = sdf.format(sdf.parse(bTime));
				fTime = sdf.format(sdf.parse(fTime));
				
				params.put("by", by);
				params.put("bm", bm);
				params.put("bd", bd);
				params.put("ey", ey);
				params.put("em", em);
				params.put("ed", ed);
				c.setTime(bg);
			}
			
			params.put("begin", bTime);
			params.put("final", fTime);
			
			System.out.println(String.format("%s / %s / %s, %s / %s / %s", by, bm, bd, ey, em, ed));
			System.out.println("begin : "+bTime);
			System.out.println("final : "+fTime);
			
			Calendar c2 = Calendar.getInstance();
			Date tes = sdf.parse(bTime);
			Date begind = c2.getTime();
			System.out.println("들어온 시간 : "+tes.getTime());
			System.out.println("지금 시간 : "+begind.getTime());
			by = Integer.toString(c2.get(Calendar.YEAR));
			bm = Integer.toString(c2.get(Calendar.MONTH)+1);
			bd = Integer.toString(c2.get(Calendar.DATE) - 6);
			System.out.println("변경 된 bd : "+bd);
			String tt = String.format("%s/%s/%s", by,bm,bd);
			System.out.println("tt : "+tt);
			tes = sdf.parse(tt);
			bTime = sdf.format(tes);
			System.out.println("bTime : "+bTime);
			
		}
		List list = asd.getSales_excel(params);
		System.out.println("Excel용 list : "+list);
		map.put("list", list);
		map.put("begin", bTime);
		map.put("end", fTime);
		return "salesExcel";
	}
}