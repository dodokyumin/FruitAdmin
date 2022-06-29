package kr.ac.kopo.ctc.kopo444.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo444.domain.StockItem;

public interface StockItemDao {
	final static String COULUMN_ID = "id";
	final static String TABLE_NAME = "twiceFruit";
	
	//create
	int createOne(StockItem StockItem);
	
	//read
	StockItem readOne(int id);
	List<StockItem> readAll(int startIndex, int countPerPage);
	
	//update
	StockItem updateOne(StockItem StockItem);
	
	//delete
	int deleteOne(int id);

	//count rows
	int RowCount();	
	
	//delete all
	int deleteAll();
}
