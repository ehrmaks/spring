package com.example.spring02.service.shop;

public class ShopPaper {
	public static final int PAGE_SCALE=10; // 페이지당 게시물수
	public static final int BLOCK_SCALE=10; // 화면당 페이지수
	
	private int curPage; // 현재 페이지
	private int prevPage; // 이전 페이지
	private int nextPage; // 다음 페이지
	private int totPage; // 전체 페이지 갯수
	private int totBlock; // 전체 페이지블록 갯수
	private int curBlock; // 현재 블록
	private int prevBlock; // 이전 블록
	private int nextBlock; // 다음 블록
	private int pageBegin; // #{start} 변수에 전달될 값
	private int pageEnd; // #{end} 변수에 전달될 값
	private int blockBegin; // 블록의 시작페이지 번호
	private int blockEnd; // 블록의 끝페이지 번호
	
	// 생성자
	// Paper (레코드 갯수, 출력할 페이지 번호)
	public ShopPaper(int count, int curPage) {
		curBlock = 1;
		this.curPage = curPage;
		setTotPage(count);
		setPageRange();
		setTotBlock();
		setBlockRange();
	
	}	
	
	// page가 1~10까지 있으면 1블록, 11~20까지 있으면 2블록
	public void setBlockRange() {
		// 원하는 페이지가 몇번째 블록에 속하는지 계산
		curBlock=(curPage-1)/BLOCK_SCALE +1; //     1 , 2 , 3
		// 블록의 시작페이지, 끝페이지 번호 계산
		blockBegin = (curBlock-1) * BLOCK_SCALE+1;//1 , 11, 21
		blockEnd = blockBegin + BLOCK_SCALE-1; //   10, 20, 30
		// 마지막 블록 번호가 범위를 초과하지 않도록 처리
		if(blockEnd > totPage) {
			blockEnd = totPage;
		}
		
		// [이전][다음]을 눌렀을 때 이동할 페이지 번호
		prevPage = (curBlock==1) ? 1 : (curBlock-1) * BLOCK_SCALE;
		nextPage = curBlock>totBlock ? (curBlock*BLOCK_SCALE)
				: (curBlock*BLOCK_SCALE)+1;
		
		// 마지막 페이지가 범위를 초과하지 않도록 처리
		if(nextPage>=totPage) {
			nextPage=totPage;
		}
	}
	
	// totPage가 10일 때 totBlock은 2
	public void setTotBlock() {
		// 시작번호 = (현재페이지-1)x페이지당 게시물수 +1
		totBlock = (int) Math.ceil(totPage*1.0 / BLOCK_SCALE);
	}

	
	// 1page(1~10), 2page(11~20), 3page(21~30)...
	public void setPageRange() {
		pageBegin = (curPage-1) * PAGE_SCALE + 1;
		pageEnd = pageBegin + PAGE_SCALE -1;
	}
	
	
	
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotPage() {
		return totPage;
	}

	
	// 게시물 수(count)가 10개라면, totPage는 2개이다.
	public void setTotPage(int count) {
		totPage = (int) Math.ceil(count * 1.0/PAGE_SCALE);
		
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	
	
}
