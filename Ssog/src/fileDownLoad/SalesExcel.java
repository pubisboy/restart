package fileDownLoad;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsView;

@Component
public class SalesExcel extends AbstractXlsView{

	@Override
	protected void buildExcelDocument(Map<String, Object> map, Workbook wb, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		List<Map> list = (List)map.get("list");
		System.out.println("넘어온 data : "+list);
		String begin = (String)map.get("begin");
		begin = begin.replace("/", "-");
		System.out.println("begin : "+begin);
		String end = (String)map.get("end");
		end = end.replace("/", "-");
		System.out.println("end : "+end);
		Sheet sheet = wb.createSheet(String.format("%s ~ %s", begin, end));
		Row title = sheet.createRow(0);
		Cell cell = title.createCell(0);
		cell.setCellValue("기간 매출");
		
		Row etc = sheet.createRow(1);
		etc.createCell(0).setCellValue("##구매확정만 집계 한 자료입니다.##");
		
		Row cate = sheet.createRow(3);
		cate.createCell(0).setCellValue("날짜");
		cate.createCell(1).setCellValue("매출");
		cate.createCell(2).setCellValue("배송비");
		cate.createCell(3).setCellValue("실매출");
		cate.createCell(4).setCellValue("주문건수");
		
		int row = 4;
		for(Map m : list){
			Row input = sheet.createRow(row++);
			input.createCell(0).setCellValue((String)m.get("PAY_DATE"));
			BigDecimal price = (BigDecimal)m.get("PRICE");
			input.createCell(1).setCellValue(price.toString());
			BigDecimal charge = (BigDecimal)m.get("CHARGE");
			input.createCell(2).setCellValue(price.toString());
			int tmp = price.intValue() - charge.intValue();
			input.createCell(3).setCellValue(tmp);
			BigDecimal count = (BigDecimal)m.get("COUNT");
			input.createCell(4).setCellValue(count.toString());
		}
		String fileName = String.format("(sales)%s~%s.xls", begin, end);
		resp.setContentType("application/unknown");
		resp.setHeader("Content-Disposition", String.format("fileName=\"%s\"", fileName));
	}
}
