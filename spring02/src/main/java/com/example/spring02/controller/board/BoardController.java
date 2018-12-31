package com.example.spring02.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.stylesheets.LinkStyle;

import com.example.spring02.controller.member.MemberController;
import com.example.spring02.model.board.dto.BoardDTO;
import com.example.spring02.service.board.BoardService;
import com.example.spring02.service.board.Paper;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("board/*")
public class BoardController {
	
	//로깅을 위한 변수
	private static final Logger logger=
				LoggerFactory.getLogger(MemberController.class);
	
	
	@Inject
	BoardService boardService;
	
	// 첨부파일 목록을 리턴
	// ArrayList를 json 배열로 변환하여 리턴
	@RequestMapping("getAttach/{bno}")
	@ResponseBody // view가 아닌 데이터 자체를 리턴
	public List<String> getAttach(@PathVariable("bno") int bno){
		
		List<Map<String, Object>> listA = boardService.getAttach(bno);
		
		List<String> list = new ArrayList<String>();
		Iterator iterator = null;

		
		for(int i=0; i<listA.size(); i++) {
			Set key = listA.get(i).keySet();
			iterator = key.iterator();
			
			while(iterator.hasNext()) {
				String keyValue = (String) iterator.next().toString();
				
				list.add(String.valueOf(listA.get(i).get(keyValue)));
			}
		}
		return list;
	}
	
	@RequestMapping("delete.do")
	public String delete(int bno) throws Exception {
		boardService.delete(bno); // 삭제 처리
		
		return "redirect:/board/list.do"; // 목록으로 이동
	}
	
	// 게시물 내용 수정
	@RequestMapping("update.do")
	public String update(BoardDTO dto) throws Exception {
		
		if(dto != null) {
			boardService.update(dto); // 레코드 수정
			String[] file = dto.getFiles();
		}
		// 수정 완료 후 현재페이지에서 수정된 내용 확인
		return "redirect:/board/view.do?bno=" + dto.getBno();
		// return "redirect:/board/list.do"
		// 리스트로 돌아가기
		//return "redirect:/board/list.do";
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(
	@RequestParam (defaultValue="title") String search_option,
	@RequestParam (defaultValue="") String keyword,
	@RequestParam (defaultValue="1") int curPage) 
			throws Exception {
		


		// 레코드 갯수 계산
		int count = 
				boardService.countArticle(search_option, keyword);
		
		// 페이지 관련 설정
		Paper pager = new Paper(count, curPage);
		
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		// 게시물 목록
		List<BoardDTO> list =
				boardService.listAll(search_option, keyword, start, end);
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("list", list); // map 에 자료 저장
		map.put("count", count);
		map.put("pager", pager); // 페이지 네비게이션을 위한 변수
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		mav.setViewName("board/list");
		mav.addObject("map", map);
		return mav;	
	}
	
	@RequestMapping(value="/board/search", method=RequestMethod.POST,
			produces = "application/json")
	@ResponseBody
	public ModelAndView search(
			@RequestBody String paramData ) throws Exception {
		
		
		logger.info("search 메소드 진입");
		
		String search_option = "";
		String keyword = "";
		int curPage = 1;
		
		List<Map<String, Object>> resultMap = new ArrayList<Map<String,Object>>();
		resultMap = JSONArray.fromObject(paramData);
		
		for(Map<String, Object> map : resultMap) {
			search_option = (String) map.get("search_option");
			keyword = (String) map.get("keyword");
			curPage = (Integer) map.get("curPage");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 레코드 갯수 계산
		int count = boardService.countArticle(search_option, keyword);
				
		// 페이지 관련 설정
		Paper pager = new Paper(count, curPage);
				
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
				
		// 게시물 목록
		List<BoardDTO> list = boardService.listAll(search_option, keyword, start, end);
		
		ModelAndView mav = new ModelAndView();
		
		map.put("list", list); // map 에 자료 저장
		map.put("count", count);
		map.put("pager", pager); // 페이지 네비게이션을 위한 변수
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		mav.addAllObjects(map);
		mav.setViewName("jsonView");
		
		return mav; 
	}
	
	@RequestMapping("view.do")
	public ModelAndView view(int bno, HttpSession session) throws Exception{
		boardService.increaseViewcnt(bno, session);
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("board/view"); // 포워딩 할 뷰의 이름
		mav.addObject("dto", boardService.read(bno)); // 자료저장

		return mav; // views/board/view.jsp 로 넘어가서 출력됨.
	}
	
	@RequestMapping("updateForm.do")
	public ModelAndView updateForm(int bno) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("board/updateForm");
		mav.addObject("dto", boardService.read(bno));
		
		return mav;
	}
	
	@RequestMapping("write.do")
	public String write() {
		// 글쓰기 폼페이지로 이동
		return "board/write";
	}
	
	// write.jsp에서 입력한 내용들이 BoardDTO에 저장됨.
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardDTO dto
			, HttpSession session) throws Exception{
		
		// 세션에서 사용자아이디와 이름을 가져옴
		String writer = (String) session.getAttribute("userid");
		dto.setWriter(writer);

		String name = (String) session.getAttribute("name");
		dto.setUser_name(name);

		
		// 레코드 저장
		boardService.create(dto);


		return "redirect:/board/list.do";
	}
	
}
