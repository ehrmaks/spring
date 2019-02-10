package com.example.spring02.controller.shop;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.shop.dto.ProductDTO;
import com.example.spring02.service.shop.ProductService;
import com.example.spring02.service.shop.ShopPaper;

@Controller
@RequestMapping("shop/product/*")
public class ProductController {
	
	private static final Logger Logger = 
			LoggerFactory.getLogger(ProductController.class);
	
	@Inject
	ProductService productService;
	
	@RequestMapping("write.do")
	public String write() {
		return "shop/product_write";
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute ProductDTO dto) {
		String filename="-";
		// 첨부파일이 있으면
		if(!dto.getFile1().isEmpty()) {
			// 첨부파일의 이름
			filename=dto.getFile1().getOriginalFilename();
			try {
				String path="C:\\Users\\김경훈\\Desktop\\Spring\\work\\spring02\\src\\main\\webapp\\WEB-INF\\views\\images\\";
				// 디렉토리가 존재하지 않으면 생성
				new File(path).mkdir();
				// 임시 디렉토리에 저장된 첨부파일을 이동
				dto.getFile1().transferTo(new File(path+filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		dto.setPicture_url(filename);
		productService.insertProduct(dto);
		
		return "redirect:/shop/product/list.do";
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(
			@RequestParam (defaultValue="product_name") String search_option,
			@RequestParam (defaultValue="") String keyword,
			@RequestParam (defaultValue="1") int curPage) throws Exception{
		
		int count = productService.countArticle(search_option, keyword);
		
		ShopPaper paper = new ShopPaper(count, curPage);
		
		int start = paper.getPageBegin();
		int end = paper.getPageEnd();
		
		List<ProductDTO> list = productService.listProduct(search_option, keyword, start, end);
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("count", count);
		map.put("paper", paper);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		// 포워딩할 뷰의 경로
		mav.setViewName("/shop/product_list");
		// 전달할 데이터
		mav.addObject("map", map);
		
		return mav;
	}
	
	@RequestMapping("update.do")
	public String update(ProductDTO dto) {
		String filename="-";
		Logger.debug("ProductDTO => " + dto);
		// 새로운 첨부파일이 있으면
		if(!dto.getFile1().isEmpty()) {
			// 첨부파일의 이름
			filename=dto.getFile1().getOriginalFilename();
			String path="C:\\Users\\김경훈\\Desktop\\Spring\\work\\spring02\\src\\main\\webapp\\WEB-INF\\views\\images\\";
			try {
				// 디렉토리가 존재하지 않으면 생성
				new File(path).mkdirs();
				// 임시 디렉토리에 저장된 첨부파일을 이동
				dto.getFile1().transferTo(new File(path+filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setPicture_url(filename);
		} else { // 새로운 첨부파일이 없을 때
			// 기존에 첨부한 파일 정보를 가져옴
			ProductDTO dto2 = 
					productService.detailProduct(dto.getProduct_id());
			
			dto.setPicture_url(dto2.getPicture_url());
		}
		
		// 상품정보 수정
		productService.updateProduct(dto);
		
		return "redirect:/shop/product/list.do";
	}
	
	@RequestMapping("delete.do")
	public String delete(@RequestParam int product_id) {
		// 첨부파일 삭제
		String filename=productService.fileInfo(product_id);
		System.out.println("첨부파일 이름 : " + filename);
		if(filename != null && !filename.equals("-")) {
			String path="C:\\Users\\김경훈\\Desktop\\Spring\\work\\spring02\\src\\main\\webapp\\WEB-INF\\views\\images\\";
			File f = new File(path+filename);
			System.out.println("파일존재여부 : " + f.exists());
			
			if(f.exists()) { // 파일이 존재하면
				f.delete(); // 파일 삭제
				System.out.println(f + "(이)가 삭제 되었습니다.");
			}
		}
		//레코드 삭제
		productService.deleteProduct(product_id);
		
		return "redirect:/shop/product/list.do";
	}
	
	@RequestMapping("edit/{product_id}")
	public ModelAndView edit(@PathVariable("product_id") int product_id,
			ModelAndView mav) {
		// 이동할 뷰의 이름
		mav.setViewName("shop/product_edit");
		
		// 뷰에 전달할 데이터
		mav.addObject("dto", productService.detailProduct(product_id));
		
		return mav;
	}
	
	@RequestMapping("detail/{product_id}")
	public ModelAndView detail(@PathVariable("product_id") int product_id,
			ModelAndView mav) {
		mav.setViewName("shop/product_detail");
		mav.addObject("dto", productService.detailProduct(product_id));
		
		return mav;
	}
}
