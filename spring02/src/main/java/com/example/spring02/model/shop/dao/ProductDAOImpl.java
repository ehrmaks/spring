package com.example.spring02.model.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.shop.dto.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Inject
	SqlSession sqlSession;
	
	
	// 상품 상세정보
	@Override
	public ProductDTO detailProduct(int product_id) {
		return sqlSession.selectOne("product.detail_product", product_id);
	}
	
	// 상품 정보 수정
	@Override
	public void updateProduct(ProductDTO dto) {
		sqlSession.update("product.update_product", dto);
	}

	// 상품 레코드 삭제
	@Override
	public void deleteProduct(int product_id) {
		sqlSession.delete("product.product_delete",product_id);
	}

	// 상품 추가
	@Override
	public void insertProduct(ProductDTO dto) {
		sqlSession.insert("product.insert", dto);
	}

	// 사진첨부 url
	@Override
	public String fileInfo(int product_id) {
		return sqlSession.selectOne("product.fileInfo", product_id);
	}

	// 상품 목록
	@Override
	public List<ProductDTO> listProduct(String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("product.product_list", map);
	}

	// 상품 갯수 검사
	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectOne("product.count", map);
	}

}
