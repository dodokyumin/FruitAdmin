package kr.ac.kopo.ctc.kopo444.service;

import java.util.List;

import kr.ac.kopo.ctc.kopo444.domain.StockItem;

public interface StockItemService {

	//조회
	StockItem readOne(String id);
	
	List<StockItem> readAll(String strcPage);
	
	//페이지 불러오기
	Pagination getPagination(String strcPage);
	
	//입력
	boolean stockItemCreateOne(String name, String stockNum, String content, String strId, String fileName);
	
	// 수정
	StockItem stockItemUpdateOne(String stockNum, String strId);
	
	// 삭제
	boolean stockItemDeleteOne(String strId);
	
	boolean stockItemDeleteAll();
	
	//총 갯수
	int getRowCount();
	
	//cPage null 체크
	String checkcPage(String strcPage);
	
	//새로운 날짜 받기
	String newDate();
	
	//페이지 null 체크
	public int checkCPage(String strcPage);
	
}
