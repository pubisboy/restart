package paging;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class Paging {

	int recordsPerPage; // 하나의 페이지에 표시할 row
	int firstPageNo; // 가장 처음의 page
	int prevPageNo; // 현재 page의 이전 page
	int currentPageNo; // 현재 page
	int startPageNo; // 현재 paging의 시작 page
	int endPageNo; // 현재 paging의 끝 page
	int nextPageNo; // 현재 page의 다음 page
	int finalPageNo; // 가장 마지막의 page
	int numberOfRecords; // 전체 row의 길이
	int sizeOfPage; // paging 표시의 길이

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}

	public int getFirstPageNo() {
		return firstPageNo;
	}

	public void setFirstPageNo(int firstPageNo) {
		this.firstPageNo = firstPageNo;
	}

	public int getPrevPageNo() {
		return prevPageNo;
	}

	public void setPrevPageNo(int prevPageNo) {
		this.prevPageNo = prevPageNo;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getStartPageNo() {
		return startPageNo;
	}

	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}

	public int getEndPageNo() {
		return endPageNo;
	}

	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}

	public int getNextPageNo() {
		return nextPageNo;
	}

	public void setNextPageNo(int nextPageNo) {
		this.nextPageNo = nextPageNo;
	}

	public int getFinalPageNo() {
		return finalPageNo;
	}

	public void setFinalPageNo(int finalPageNo) {
		this.finalPageNo = finalPageNo;
	}

	public int getNumberOfRecords() {
		return numberOfRecords;
	}

	public void setNumberOfRecords(int numberOfRecords) {
		this.numberOfRecords = numberOfRecords;
	}

	public int getSizeOfPage() {
		return sizeOfPage;
	}

	public void setSizeOfPage(int sizeOfPage) {
		this.sizeOfPage = sizeOfPage;
	}

	public Paging() {
		this.currentPageNo = 1;
		this.recordsPerPage = 10;
		this.sizeOfPage = 5;
	}

	public void setDefaultSetting(int recordsPerPage, int sizeOfPage) {
		this.recordsPerPage = recordsPerPage;
		this.sizeOfPage = sizeOfPage;
	}

	public Map<String, Object> calcPaging(int currentPage, int numberOfRecord) {
		Map<String, Object> map = null;
		if (numberOfRecords != 0) {
			map = new HashMap<>();
		} else {
			return map;
		}

		// 매개변수명 수정
		// currentPageNo > currentPage
		// numberOfRecords > numberOfRecord

		setCurrentPageNo(currentPage);
		setNumberOfRecords(numberOfRecord);

		int finalPage = (numberOfRecords % recordsPerPage) == 0 ? (numberOfRecords / recordsPerPage)
				: (numberOfRecords / recordsPerPage) + 1;

		if (currentPageNo > finalPage) {
			setCurrentPageNo(finalPage);
		}
		if (currentPageNo < 1) {
			setCurrentPageNo(1);
		}

		int startPage = ((currentPageNo - 1) / sizeOfPage) * sizeOfPage + 1;
		int endPage = startPage + sizeOfPage - 1;

		if (endPage > finalPage){
			endPage = finalPage;
		}
		
		setPrevPageNo(((currentPageNo - 1) < 1 ? 1 : (currentPageNo - 1)));
		setNextPageNo(((currentPageNo + 1) > finalPage ? finalPage : (currentPageNo + 1)));
 
        setStartPageNo(startPage); 
        setEndPageNo(endPage);
        
        setFirstPageNo(1);
        
        setFinalPageNo(finalPage);
        
        map.put("firstPageNo", firstPageNo);
        map.put("prevPageNo", prevPageNo);
        map.put("currentPageNo", currentPageNo);
        map.put("startPageNo", startPageNo);
        map.put("endPageNo", endPageNo);
        map.put("nextPageNo", nextPageNo);
        map.put("finalPageNo", finalPageNo);

		return map;
	}
	
	public Map<String, Object> calcBetween(int currentPageNo){
		Map<String, Object> map = new HashMap<>();
		int end = currentPageNo * recordsPerPage; // DB에서 추출할 row의 끝 번호
		int start = end - (recordsPerPage - 1); // DB에서 추출할 row의 시작 번호
		map.put("start", start);
		map.put("end", end);
		return map;
	}
	
	/*@Override
	public String toString() {
		String[] ss = new String[10];
		ss[0] = "recordsPerPage : "+recordsPerPage;
		ss[1] = "firstPageNo : "+firstPageNo;
		ss[2] = "prevPageNo : "+prevPageNo;
		ss[3] = "currentPageNo : "+currentPageNo;
		ss[4] = "startPageNo : "+startPageNo;
		ss[5] = "endPageNo : "+endPageNo;
		ss[6] = "nextPageNo : "+nextPageNo;
		ss[7] = "finalPageNo : "+finalPageNo;
		ss[8] = "numberOfRecords : "+numberOfRecords;
		ss[9] = "sizeOfPage : "+sizeOfPage;
		
		return Arrays.toString(ss);
	}*/
}
