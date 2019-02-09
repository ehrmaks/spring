package com.example.spring02.service.shop;

import java.util.List;

import com.example.spring02.model.shop.dto.ProductDTO;

public interface ProductService {
	List<ProductDTO> listProduct(String search_option, String keyword, int start, int end);
	ProductDTO detailProduct(int product_id);
	String fileInfo(int product_id);
	void updateProduct(ProductDTO dto);
	void deleteProduct(int product_id);
	void insertProduct(ProductDTO dto);
	public int countArticle(String search_option, String keyword) throws Exception;
}
