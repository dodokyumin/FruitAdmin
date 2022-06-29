package kr.ac.kopo.ctc.kopo444.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import kr.ac.kopo.ctc.kopo444.dao.StockItemDao;
import kr.ac.kopo.ctc.kopo444.dao.StockItemDaoImpl;
import kr.ac.kopo.ctc.kopo444.domain.StockItem;

public class StockItemServiceImpl implements StockItemService{

	StockItemDao stockItemDao = new StockItemDaoImpl();

	private int countPerPage = 10;
	final int COUNT_PER_PAGE = 10;
	final int PAGE_SIZE = 10;

	@Override
	public List<StockItem> readAll(String strcPage) {
		// 총 레코드 수 조회
		// 페이지네이션 계싼
		// 전제 목록 조회
		// 전체 목록 조회 결과랑 페이지 네이션을 dto로 묶어서 반환
		// 페이지네이션 계산
		Pagination pagination = new Pagination();
		int cPage = checkCPage(strcPage);
		pagination.setcPage(cPage);
		pagination.setCountPerPage(countPerPage);

		// 전체 목록 조회 
		int startIndex = ((pagination.getcPage() - 1) * pagination.getCountPerPage() + 1);
		
		List<StockItem> stockItem = stockItemDao.readAll(startIndex, countPerPage);

		// 전체 목록 조회 결과랑 페이지 네이션을 dto로 묶어서 반환
//		ScoreItemDto scoreItemDto = new ScoreItemDto(scoreItem,
//				getPagination(cPage, COUNT_PER_PAGE, PAGE_SIZE, TOTAL_COUNT));
//		
		return stockItem;
	}

	@Override
	public StockItem readOne(String strId) {
		int id = Integer.parseInt(strId);
		StockItem scoreItem = stockItemDao.readOne(id);
//		if (searchid.length() == 0) {
//			searchid = "0";
//		}
//		name = "해당 학번 없음.";
		return scoreItem;
	}

	@Override
	// countPerPage 한페이지당 몇개의 리스트
	// pageSize 밑에 보여줄 페이지 갯수
	// totalCount 총 게시물 수
	public Pagination getPagination(String strcPage) {
		
		int currPage = Integer.parseInt(strcPage);
		
		Pagination p = new Pagination();
		
		// 총 레코드 수 조회
		int totalCount = getRowCount();
		
		// >>
		int totalPage;
		if ((totalCount % countPerPage) > 0) {
			totalPage = totalCount / countPerPage + 1;
		} else {
			totalPage = totalCount / countPerPage;
		}

		// currPage
		if (currPage > totalPage) {
			currPage = totalPage;
		} else if (currPage < 1) {
			currPage = 1;
		}
		p.setcPage(currPage);
		
		//pageSize
		p.setPageSize(PAGE_SIZE);

		// <<
		p.setPpPage(1);
		// >>
		p.setNnPage(totalPage);

		// >
		if ((totalPage - currPage) < PAGE_SIZE) {
			p.setnPage(totalPage);
		} else {
			p.setnPage((currPage / PAGE_SIZE + 1) * PAGE_SIZE + 1);
		}
		// < 
		if ((currPage / PAGE_SIZE) == 0) {
			p.setpPage(1);
		} else {
			p.setpPage((currPage-PAGE_SIZE / PAGE_SIZE)); //이 부분 문데
		}

		// 첫 페이지 번호
		int startPage = (currPage / PAGE_SIZE) * PAGE_SIZE + 1;	
		if ((currPage % PAGE_SIZE) == 0) {		
			startPage -= PAGE_SIZE;
		}
		p.setFirstPage(startPage);
		
		// 마지막 페이지 번호
		int lastPage = (startPage + PAGE_SIZE - 1) >= totalPage ? totalPage : (startPage + PAGE_SIZE - 1);
		p.setLastPage(lastPage);
		
		if(lastPage >= totalPage) {
			p.setLastPage(totalPage);
		}
		
		return p;
	}

	@Override
	public boolean stockItemCreateOne(String strName, String strStockNum, String strContent, String strId, String fileName) {
		
		int deter = 0;
		boolean result = false;
		
		StockItemDao boardItemDao = new StockItemDaoImpl();
		StockItem boardItem = new StockItem();
		
		String date = newDate();
		
		int id = Integer.parseInt(strId);
		String name = strName;
		int stockNum = Integer.parseInt(strStockNum);
		String content = strContent;

		boardItem.setId(id);
		boardItem.setName(name);
		boardItem.setStockNum(stockNum);
		boardItem.setCurDate(date);
		boardItem.setRegDate(date);
		boardItem.setContent(content);
		boardItem.setFileName(fileName);
		
		deter = boardItemDao.createOne(boardItem);
		if(deter == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public StockItem stockItemUpdateOne(String strStockNum, String strId) {
		
		int stockNum = Integer.parseInt(strStockNum);
		int id = Integer.parseInt(strId);
		
		StockItemDao stockItemDao = new StockItemDaoImpl();
		StockItem stockItem = new StockItem();
		
		String date = newDate();
		
		stockItem.setId(id);
		stockItem.setStockNum(stockNum);
		stockItem.setCurDate(date);

		
		
		stockItemDao.updateOne(stockItem);
		
		return stockItem;
	}

	@Override
	public boolean stockItemDeleteOne(String strId) {
		int deter = 0;
		boolean result = false;
		int id = Integer.parseInt(strId);
		StockItemDao stockItemDao = new StockItemDaoImpl();
		deter = stockItemDao.deleteOne(id);
		
		if(deter == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public int getRowCount() {
		int rowcount = stockItemDao.RowCount();
		return rowcount;
	}

	@Override
	public String checkcPage(String strcPage) {
		if(strcPage == null) {
			strcPage = "1";
		}
		return strcPage;
	}

	@Override
	public String newDate() {
		Date nowDate = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd"); 
		//원하는 데이터 포맷 지정
		String date = simpleDateFormat.format(nowDate);
		return date;
	}

	@Override
	public boolean stockItemDeleteAll() {
		int deter = 0;
		boolean result = false;
		StockItemDao stockItemDao = new StockItemDaoImpl();
		deter = stockItemDao.deleteAll();
		
		if(deter >= 0) {
			result = true;
		}
		
		return result;
	}
	
	@Override
	public int checkCPage(String strcPage) {
		// 현재 페이지 번호 null 체크
		int cPage = 0;
		if (strcPage == null) {
			cPage = 1;
		} else {
			cPage = Integer.parseInt(strcPage);
		}
		return cPage;
	}

	
}
