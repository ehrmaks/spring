package com.example.spring02.controller.shop;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.shop.dao.CartDAO;
import com.example.spring02.model.shop.dto.CartDTO;
import com.example.spring02.service.member.MemberService;
import com.example.spring02.service.shop.CartService;
import com.mysql.cj.xdevapi.JsonArray;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("shop/cart/*")
public class CartController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(CartController.class);
	
	@Inject
	CartService cartService;
	@Inject
	MemberService memberService;
	@Inject
	CartDAO cartDao;
	
	@RequestMapping(value="/shop/cart/count", method=RequestMethod.POST,
			produces = "application/json")
	@ResponseBody
	public ModelAndView count(ModelAndView mav, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		int counting = cartService.counting(userid);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("counting", counting);
		mav.addAllObjects(map);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping("list.do")
	public ModelAndView list (HttpSession session, 
			ModelAndView mav) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String userid = (String) session.getAttribute("userid");
		
		List<CartDTO> list = cartService.listCart(userid);
		
		int sumMoney = cartService.sumMoney(userid);
		
		int fee = sumMoney >= 50000 ? 0 : 2500;
		
		map.put("sumMoney", sumMoney); // 장바구니 금액 합계
		map.put("fee", fee); // 배송료
		map.put("sum", sumMoney+fee); // 총합계금액
		map.put("list", list); // 맵에 자료 추가
		map.put("count", list.size()); // 상품갯수
		mav.setViewName("shop/cart_list");
		mav.addObject("map", map);
		
		return mav;
	}
	
	@RequestMapping("insert.do")
	public String insert(HttpSession session, 
			@ModelAttribute CartDTO dto) {
				
		String userid = (String) session.getAttribute("userid");
		
		dto.setUserid(userid);

		// 장바구니에 기존 상품이 있는지 검사
		int count = cartService.countCart(userid, dto.getProduct_id());
		if(count == 0) {
			// 없으면 insert
			cartService.insert(dto);
		} else {
			// 있으면 update
			cartService.updateCart(dto);
		}
	
		
		
		return "redirect:/shop/cart/list.do";
	}
	
	@RequestMapping("delete.do")
	public String delete(@RequestParam int cart_id, 
			HttpSession session) {
		if(session.getAttribute("userid")!=null) {
			cartService.delete(cart_id);
		}
		
		return "redirect:/shop/cart/list.do";
	}
	
	@RequestMapping("deleteAll.do")
	public String deleteAll(HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		
		if(userid != null) {
			cartService.deleteAll(userid);
		}
		
		return "redirect:/shop/cart/list.do";
	}
	
	@RequestMapping("update.do")
	public ModelAndView update(@RequestParam int[] amount,
			@RequestParam int[] cart_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String) session.getAttribute("userid");
		
		if (userid != null) {
			for(int i=0; i<cart_id.length; i++) {
				if(amount[i] == 0) { // 수량이 0이면 레코드 삭제
					cartService.delete(cart_id[i]);
				} else { // 0이 아니면 수정
					CartDTO dto = new CartDTO();
					dto.setUserid(userid);
					dto.setCart_id(cart_id[i]);
					dto.setAmount(amount[i]);
					cartService.modifyCart(dto);
				}
			}
		}
		
		
		mav.setViewName("redirect:/shop/cart/list.do");
		
		/*return "redirect:/shop/cart/list.do";*/
		return mav;
	}
	
	@SuppressWarnings({ "unchecked", "null" })
	@RequestMapping(value="/shop/cart/update", method=RequestMethod.POST,
			produces="application/json")
	@ResponseBody
	public ModelAndView ajaxUpdate(
			@RequestBody String paramData, HttpSession session) throws Exception {
		
		String userid = (String) session.getAttribute("userid");
		
		List<Map<String, Object>> resultMap = new ArrayList<Map<String,Object>>();
		resultMap = JSONArray.fromObject(paramData);
		
		int cart_id[]=null;
		int amount[] = null;
		
		for(Map<String, Object> map : resultMap) {
			String c_id = map.get("cart_id").toString(); // ["150","149","148"]
			
			// 정규식으로 표현
			/*Pattern p = Pattern.compile("\\d+");
			Matcher m = p.matcher(c_id);
			List<Integer> list = new ArrayList<>();
			
			while (m.find()) {
				int i = 0;
				list.add(Integer.valueOf(m.group(i)));
				cart_id[i] = list.get(i).intValue();
				i++;
			}*/
			// 문자열 자르기로 표현
			cart_id = Arrays.stream(c_id.substring(2, c_id.length()-2).split("\",\""))
				    .map(String::trim).mapToInt(Integer::parseInt).toArray();
			
			String a_amount = map.get("amount").toString(); // ["4","1","2"]
			amount = Arrays.stream(a_amount.substring(2, a_amount.length()-2).split("\",\""))
				    .map(String::trim).mapToInt(Integer::parseInt).toArray();
		}
		
		if (userid != null) {
			for(int i=0; i<cart_id.length; i++) {
				if(amount[i] == 0) { // 수량이 0이면 레코드 삭제
					cartService.delete(cart_id[i]);
				} else { // 0이 아니면 수정
					CartDTO dto = new CartDTO();
					dto.setUserid(userid);
					dto.setCart_id(cart_id[i]);
					dto.setAmount(amount[i]);
					cartService.modifyCart(dto);
				}
			}
		}
		
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		
		List<CartDTO> list = cartService.listCart(userid);
		
		int sumMoney = cartService.sumMoney(userid);
		
		int fee = sumMoney >= 50000 ? 0 : 2500;
		
		map.put("sumMoney", sumMoney); // 장바구니 금액 합계
		map.put("fee", fee); // 배송료
		map.put("sum", sumMoney+fee); // 총합계금액
		map.put("list", list); // 맵에 자료 추가
		map.put("count", list.size()); // 상품갯수
		map.put("cart_id", cart_id);
		map.put("amount", amount);
		mav.addAllObjects(map);
		mav.setViewName("jsonView");
		/*return "redirect:/shop/cart/list.do";*/
		return mav;
	}
	
	@RequestMapping("buy.do")
	public ModelAndView buy(ModelAndView mav, CartDTO dto, HttpSession session) {
		int sumMoney = dto.getSumMoney();
		int fee = dto.getFee();
		dto.setTotal_amount(sumMoney+fee);
		int total_amount = sumMoney+fee;
		int point = 0;
		for(int i=0; i<sumMoney; i++) {
			if(i%1000 == 0) {
				point += 50;
			}
		}
		String userid = (String) session.getAttribute("userid");
		memberService.amount(userid, point, total_amount);
		cartDao.cartClear(userid);
		
		mav.setViewName("shop/buy");
		return mav;
	}
}
