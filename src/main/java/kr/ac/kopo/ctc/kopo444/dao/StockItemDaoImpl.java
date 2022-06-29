package kr.ac.kopo.ctc.kopo444.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo444.domain.StockItem;

public class StockItemDaoImpl implements StockItemDao {

	public StockItemDaoImpl() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("jdbc 드라이버 로드 실패");
		}
	}

	@Override
	public int createOne(StockItem stockItem) {
		String sql = "INSERT INTO " + TABLE_NAME + "(id, name, stockNum, curDate, regDate, content, fileName) VALUES (?, ?, ?, ?, ?, ?, ?)";
		int result;
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			pstmt.setInt(1, stockItem.getId());
			pstmt.setString(2, stockItem.getName());
			pstmt.setInt(3, stockItem.getStockNum());
			pstmt.setString(4, stockItem.getCurDate());
			pstmt.setString(5, stockItem.getRegDate());
			pstmt.setString(6, stockItem.getContent());
			pstmt.setString(7, stockItem.getFileName());
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// e만 넣으면 hashcode가 나오므로 getMessage()를 붙여준다.
			throw new IllegalStateException("insert 실패 " + e.getMessage());
		}
		return result;
	}

	@Override
	public StockItem readOne(int inputId) {
		String sql = "SELECT * FROM " + TABLE_NAME + " WHERE id=?";
		
		StockItem stockItem = new StockItem();
		
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, inputId);
			try (ResultSet rs = pstmt.executeQuery();){
				
				rs.next();
					int id = rs.getInt("id");
					String name = rs.getString("name");
					int stockNum = rs.getInt("stockNum");
					String curDate = rs.getString("curDate");
					String regDate = rs.getString("regDate");
					String content = rs.getString("content");

					stockItem.setId(id);
					stockItem.setName(name);
					stockItem.setStockNum(stockNum);
					stockItem.setCurDate(curDate);
					stockItem.setRegDate(regDate);
					stockItem.setContent(content);
			}
			
		} catch (SQLException e) {
			// e만 넣으면 hashcode가 나오므로 getMessage()를 붙여준다.
			throw new IllegalStateException("insert 실패 " + e.getMessage());
		}
		return stockItem;
	}

	@Override
	public List<StockItem> readAll(int startIndex, int countPerPage) {
		List<StockItem> results = new ArrayList<>();
		String sql = "SELECT * FROM " + TABLE_NAME + " ORDER BY "+ COULUMN_ID +" desc LIMIT ?, ?";
		// TRY RESOURCE CATCH문
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, startIndex - 1);
			pstmt.setInt(2, countPerPage);
			try (ResultSet rs = pstmt.executeQuery();) {

				while (rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("name");
					int stockNum = rs.getInt("stockNum");
					String curDate = rs.getString("curDate");
					String regDate = rs.getString("regDate");
					String content = rs.getString("content");

					StockItem stockItem = new StockItem();
					stockItem.setId(id);
					stockItem.setName(name);
					stockItem.setStockNum(stockNum);
					stockItem.setCurDate(curDate);
					stockItem.setRegDate(regDate);
					stockItem.setContent(content);

					results.add(stockItem);
				}
			}
		} catch (SQLException e) {
			throw new IllegalStateException("db 연결 실패" + e.getMessage());
		}
		return results;
	}

	@Override
	public StockItem updateOne(StockItem stockItem) {
		String sql = "UPDATE " + TABLE_NAME + " SET stockNum=?, curDate=? WHERE id = ?";
		
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			// pstmt.setString(1, TABLE_NAME);
			pstmt.setInt(1, stockItem.getStockNum());
			pstmt.setString(2, stockItem.getCurDate());
			pstmt.setInt(3, stockItem.getId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// e만 넣으면 hashcode가 나오므로 getMessage()를 붙여준다.
			// throw new IllegalStateException("update 실패 " + e.getMessage());
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return stockItem;
	}

	@Override
	public int deleteOne(int id) {
		String sql = "delete from " + TABLE_NAME + " where id=?";
		int result = 0;

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, id);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			throw new IllegalStateException("db 연결 실패" + e.getMessage());
		}

		return result;
	}

	@Override
	public int RowCount() {
		int rowcount = 0;
		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				Statement stmt = conn.createStatement();
				ResultSet rset = stmt.executeQuery("SELECT COUNT(*) FROM " + TABLE_NAME);) {

			while (rset.next()) {
				rowcount = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new IllegalStateException("count 실패 " + e.getMessage());
		}
		return rowcount;
	}

	@Override
	public int deleteAll() {
		String sql = "delete from " + TABLE_NAME + " where id > 0";
		int result = 0;

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33063/koposw44", "root", "koposw44");
				PreparedStatement pstmt = conn.prepareStatement(sql);) {
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			throw new IllegalStateException("db 연결 실패" + e.getMessage());
		}

		return result;
	}

}
