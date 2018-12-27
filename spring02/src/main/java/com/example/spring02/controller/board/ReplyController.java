package com.example.spring02.controller.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.board.dto.ReplyDTO;
import com.example.spring02.service.board.ReplyPager;
import com.example.spring02.service.board.ReplyService;

@RestController
@RequestMapping("/reply/*")
public class ReplyController {
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam int bno, ModelAndView mav, 
			@RequestParam(defaultValue="1") int curPage, HttpSession session) {
		// 페이징 처리
		int count = replyService.count(bno); // 댓글 갯수
		ReplyPager replyPager = new ReplyPager(count, curPage);
		
		// 현재 페이지의 페이징 시작 번호
		int start = replyPager.getPageBegin();
		
		// 현재 페이지의 페이징 끝 번호
		int end = replyPager.getPageEnd();
		
		List<ReplyDTO> list = replyService.list(bno, start, end, session);
		
		// 뷰이름 지정
		mav.setViewName("board/reply_list");
		// 뷰에 전달할 데이터 지정
		mav.addObject("list", list);
		mav.addObject("replyPager", replyPager);
		// reply_list.jsp로 포워딩
		return mav;
	}
	
	//댓글 목록을 ArrayList로 리턴
	@RequestMapping("listjson.do")
	//@ResponseBody // 리턴 데이터를 json 변환(RestController 사용시 생략가능)  
	public List<ReplyDTO> listjson(@RequestParam int bno, 
			@RequestParam(defaultValue="1") int curPage, HttpSession session) {
		// 페이징 처리
		int count = replyService.count(bno);
		ReplyPager paper = new ReplyPager(count, curPage);
		
		// 현재 페이지의 페이징 시작 번호
		int start = paper.getPageBegin();
		
		// 현재 페이지의 페이징 끝 번호
		int end = paper.getPageEnd();
		
		List<ReplyDTO> list = replyService.list(bno, start, end, session);
		
		return list; // 댓글목록
	}
	
	@RequestMapping(value="/list/{bno}/{curPage}", 
			method=RequestMethod.GET)
	public ModelAndView replyList(@PathVariable("bno") int bno, 
			@PathVariable int curPage, ModelAndView mav, HttpSession session, ReplyDTO dto) {
				
		String userid=(String)session.getAttribute("userid");
		dto.setReplyer(userid);
		String user_name=(String) session.getAttribute("name");
		dto.setUser_name(user_name);
		
		// 페이징 처리
		int count = replyService.count(bno);
		ReplyPager replyPager = new ReplyPager(count, curPage);
		
		// 현재 페이지의 시작 번호
		int start = replyPager.getPageBegin();
		// 현재 페이지의 끝 번호
		int end = replyPager.getPageEnd();
		
		List<ReplyDTO> list = replyService.list(bno, start, end, session);
		
		// 뷰이름 지정
		mav.setViewName("board/reply_list");
		mav.addObject("list", list);
		mav.addObject("replyPager", replyPager);
		
		// reply_list.jsp 로 포워딩
		return mav;
	}
	
	@RequestMapping("insert.do")
	public void insert(ReplyDTO dto, HttpSession session) {
		// 댓글 작성자 아이디
		String userid=(String)session.getAttribute("userid");
		dto.setReplyer(userid);
		String user_name=(String) session.getAttribute("name");
		dto.setUser_name(user_name);

		
		replyService.create(dto);
		//jsp 페이지로 가거나 데이터를 리턴하지 않음.
	}
	
	// 1_2. 댓글입력 (@RestController방식으로 json전달하여 댓글입력)
    // @ResponseEntity : 데이터 + http status code
    // @ResponseBody : 객체를 json으로 (json - String)
    // @RequestBody : json을 객체로
    @RequestMapping(value="insertRest.do", method=RequestMethod.POST)
    public ResponseEntity<String> insertRest(@RequestBody ReplyDTO dto, HttpSession session){
        ResponseEntity<String> entity = null;
        try {
            // 세션에 저장된 회원아이디를 댓글작성자에 세팅
            String userid = (String) session.getAttribute("userid");
            dto.setReplyer(userid);
            
            String user_name = (String) session.getAttribute("name");
            dto.setUser_name(user_name);

            // 댓글입력 메서드 호출
            replyService.create(dto);
            // 댓글입력이 성공하면 성공메시지 저장
            entity = new ResponseEntity<String>("success", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            // 댓글입력이 실패하면 실패메시지 저장
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        // 입력 처리 HTTP 상태 메시지 리턴
        return entity;
    }
	
	@RequestMapping(value="/update/{rno}", 
			method= {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> replyUpdate(@PathVariable("rno") int rno,
			@RequestBody ReplyDTO dto) {
		ResponseEntity<String> entity = null;
		try {
			dto.setRno(rno);
			replyService.update(dto);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			// 댓글 수정이 실패하면 실패 상태메시지 저장
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		// 수정 처리 HTTP 상태 메시지 리턴
		return entity;
	}
	
	@RequestMapping(value="/delete/{rno}")
	public ResponseEntity<String> replyDelete(@PathVariable("rno") int rno) {
		ResponseEntity<String> entity = null;
		try {
			replyService.delete(rno);
			// 댓글 삭제가 성공하면 성공 상태 메시지 저장
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			System.out.println("댓글 삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
			// 댓글 삭제가 실패하면 실패 상태 메시지 저장
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			System.out.println("댓글 삭제 실패");
		}
		// 삭제 처리 HTTP 상태 메시지 리턴
		return entity;
	}

	// 3. 댓글 상세 보기
    // /reply/detail/1 => 1번 댓글의 상세화면 리턴
    // /reply/detail/2 => 2번 댓글의 상세화면 리턴
    // @PathVariable : url에 입력될 변수값 지정
	@RequestMapping(value="/detail/{rno}", 
			method=RequestMethod.GET)
	public ModelAndView replyDetail(@PathVariable("rno") int rno, 
			ModelAndView mav) {
		ReplyDTO dto = replyService.detail(rno);
		
		// 뷰이름 지정
		mav.setViewName("board/replyDetail");
		// 뷰에 전달할 데이터 지정
		mav.addObject("dto", dto);
		// replyDetail.jsp로 포워딩
		return mav;
	}
	
	
}
