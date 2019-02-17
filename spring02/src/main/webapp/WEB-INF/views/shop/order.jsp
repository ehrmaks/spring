<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/header.jsp" %>
<title>Insert title here</title>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
$(function() {
	var phone = $("input[name=phone]").val();
	phone_arr = phone.split("-");
	var phone1 = phone_arr[0];
	var phone2 = phone_arr[1];
	var phone3 = phone_arr[2];
	
	document.getElementById("phone1").value = phone1;
	document.getElementById("phone2").value = phone2;
	document.getElementById("phone3").value = phone3;
	
	$("#btnPayment").click(function() {
		var phone1 = $("#phone1").val();
		var phone2 = $("#phone2").val();
		var phone3 = $("#phone3").val();
		var phone = phone1 + "-" + phone2 + "-" + phone3;
		document.getElementById("phone").value = phone;
		
		document.form1.action="${path}/shop/cart/buy.do";
		document.form1.submit();
	});

});




function daumZipCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			
			var fullAddr = ''; // 최종 주소 변수
			var extraAddr = '';
			
			if(data.userSelectedType === 'R') {
				fullAddr = data.roadAddress;
			} else {
				fullAddr = data.jibunAddress;
			}
			
			if(data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다.
				if(data.bname !== '') {
					extraAddr += data.bname;
				}
				
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + 
							data.buildingName : data.buildingName);
				}
				
				fullAddr += (extraAddr !== '' ? ' (' + extraAddr + 
						')' : '');
			}
			
			document.getElementById('zipcode').value =
				data.zonecode; // 5자리 새우편번호 사용
			
			document.getElementById('address1').value =
				fullAddr;
				
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('address2').focus();
		}
	}).open();
}
</script>

<style type="text/css">
[wid="true"] {
    width: 1260px;
}
[wid] {
    margin: 0 auto;
    position: relative;
    -webkit-box-sizing: border-box;
    -khtml-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -ms-box-sizing: border-box;
    -o-box-sizing: border-box;
    box-sizing: border-box;
}
#-title-package h1 > span {
    display: block;
    color: #999;
    letter-spacing: -0.03em;
    font-size: 12px;
    font-family: 'Roboto','Open Sans','PT Sans','nanumgothic','malgun gothic','arial','dotum','sans-serif';
}
.-font-ns {
    font-family: 'Roboto','NanumGothic','Open Sans','PT Sans','malgun gothic','돋움',Dotum,Helvetica,'Apple SD Gothic Neo',Sans-serif;
}
#-title-package h1 > span {
    display: block;
    color: #999;
    letter-spacing: -0.03em;
    font-size: 12px;
    font-family: 'Roboto','Open Sans','PT Sans','nanumgothic','malgun gothic','arial','dotum','sans-serif';
}
.ec-base-box.typeMember {
    padding: 0;
}
.ec-base-box {
    padding: 20px;
    margin-left: auto;
    margin-right: auto;
    border: 1px solid #e8e8e8;
    background: #fff;
    color: #404040;
}
.xans-order-dcinfo {
    margin: 20px 0;
    color: #353535;
    line-height: 1.5;
}
h3 {
    display: block;
    font-size: 1.17em;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
.xans-order-dcinfo .description .mileage {
    margin: 6px 0 0;
    padding: 10px 0 0;
    border-top: 1px solid #e8e8e8;
    *zoom: 1;
}
.xans-order-form .controlInfo {
    padding: 10px 0 8px 10px;
    border-top: 1px solid #e8e5e4;
    color: #f76560;
    font-size: 11px;
    line-height: 1.5;
    background: #fbfbfb;
}
.xans-order-form .controlInfo li {
    padding: 0 0 2px 19px;
    background: url(/_panda/image/cafe24/ico_info.gif) no-repeat 0 1px;
}
.ec-base-table .right {
    text-align: right;
}

.xans-order-form .ec-base-table tfoot td .gLeft {
    float: left;
    margin: 6px 0 0;
}
.ec-base-table .center {
    text-align: center;
}
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    vertical-align: baseline;
}
.typeList{
    position: relative;
    padding-left: 5px !important;
    padding-right: 5px !important;
    border: 1;
    border-color: gray;
}
.ec-base-table.typeList td.thumb img {
    max-width: 80px !important;
    height: auto;
}
.xans-order-form .controlInfo.typeBtm {
    margin: -1px 0 0;
    border-top: 0;
    border-bottom: 1px solid #e8e5e4;
}
.xans-order-form .ec-base-button {
    padding: 10px 0 50px;
    border-bottom: 1px solid #868686;
}
.ec-base-button .gRight {
    float: right;
    text-align: right;
}
.-titlepack h3, .-titlepack.-font-ns {
    font-size: 14px;
    font-weight: normal;
}
.xans-order-form .orderArea .title .required {
    margin: -15px 0 0;
    color: #353535;
    text-align: right;
}
.gBlank5 {
    display: block;
    margin-top: 5px;
}

.txtInfo {
    color: #707070;
}
.ec-base-table .center {
    text-align: center;
}
.ec-base-table.typeList .center td, .ec-base-table.typeList td.center {
    padding-left: 5px;
    padding-right: 5px;
}
.txt16 {
    font-size: 16px;
}
.gMerge {
    position: relative;
    z-index: 1;
    margin-top: -1px;
}
.txt14 {
    font-size: 14px;
}
.ec-base-table tbody th {
    padding: 11px 0 10px 18px;
    border: 1px solid #dfdfdf;
    border-bottom-width: 0;
    color: #353535;
    text-align: left;
    font-weight: normal;
}
.-btn.-black, .-btn.-black:link, .-btn.-black:visited {
    color: #fff;
    border: 1px solid #3c434d;
    border-bottom-color: #363d47;
    box-shadow: 0 2px 2px rgba(0,0,0,0.04);
    text-shadow: 0 0 2px rgba(0,0,0,0.2);
    background: #434a54;
    background: linear-gradient(to bottom,#434a54 100%,#434a54 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#434a54',endColorstr='#434a54',GradientType=0 );
}
.-btn i {
    position: relative;
    top: 0;
}
.fa-window-restore:before {
    content: "\f2d2";
}
.xans-order-form .payArea .total {
    float: right;
    width: 240px;
    margin: 0 -241px 0 0;
    text-align: right;
    background: #fbfafa;
}
.xans-order-form .payArea .total .button {
    margin: 16px 0 10px;
    text-align: center;
}
.xans-order-form .payArea:after {
    position: absolute;
    top: 0;
    right: 240px;
    display: block;
    content: "";
    width: 1px;
    height: 100%;
    background: #777;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>


<div id="-title-package">
	<ul>
		<li>
			<h1 class="-font-ns" style="text-align: center;">
				주문서 작성
				<span>주문서를 꼼꼼히 작성해주세요.</span>
			</h1>
		</li>
	</ul>
</div>

<div class="container">
	<form method="post" name="form1">
		<input type="hidden" value="${map.sumMoney}" name="sumMoney">
		<input type="hidden" value="${map.fee}" name="fee">
		
	<div class="xans-element- xans-order xans-order-dcinfo ec-base-box typeMember">
		<div class="information">
			<h3 class="title">혜택정보</h3>
			<div class="description">
				<div class="member ">
					<p>
						<strong>${map.name}</strong>님은 [<strong>${map.rating}</strong>] 회원이십니다.
					</p>
					<ul>
						<li class="displaynone">
							<span class="displaynone">₩5000원</span>
							 이상
							<span class="displaynone"></span>
							구매시 
							<span>0%</span>
							을 추가할인 받으실 수 있습니다. 
						</li>
					</ul>
				</div>
				<ul class="mileage">
					<li>
						가용 적립금 : 
						<strong>${map.available}원</strong>
					</li>
					<li>
						예치금 : 
						<strong>0원</strong>
					</li>
					<li>
						쿠폰 : 
						<strong>${map.coupon}개</strong>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<ul style="font-size: 11px; font-style: italic;">
		<li>
			상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
		</li>
		<li>
			할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.
		</li>
	</ul>
	
	<div class="orderListArea ">
		<div>
			<table class="table table-hover" border="1">
				<colgroup>
					<col style="width:98px;">
					<col style="width:98px;">
					<col style="width:98px;">
					<col style="width:75px;">
					<col style="width:98px;">
					<col style="width:85px;">
					<col style="width:98px;">
				</colgroup>
				<thead>
					<tr>
						<th scope="row">이미지</th>
						<th scope="row">상품정보</th>
						<th scope="row">판매가</th>
						<th scope="row">수량</th>
						<th scope="row">합계</th>
					</tr>
				</thead>
				<tfoot class="right">
					<tr>
						<td colspan="8">
							<span class="gLeft">[기본배송]</span>
							 상품구매금액 <strong><fmt:formatNumber value="${map.sumMoney}"
							pattern="###,###,###"></fmt:formatNumber>원</strong> + 배송비
							 <span><fmt:formatNumber value="${map.fee}"
							pattern="###,###,###"></fmt:formatNumber>원</span> = 합계 : 
							 <strong class="txtEm gIndent10">
							 	₩
							 	<span class="txt18"><fmt:formatNumber value="${map.sum}"
							pattern="###,###,###"></fmt:formatNumber></span>원
							 </strong>
						</td>
					</tr>
				</tfoot>
				<tbody class="xans-element- xans-order xans-order-normallist center">
					
					<c:forEach var="row" items="${map.list}">
						<tr class="xans-record-">
							<td class="thumb">
								<a href="/shop/product/detail/${row.product_id}"><img src="/images/${row.picture_url}" width="50px"></a>
							</td>
							<td class="left">
								<a href="/shop/product/detail/${row.product_id}"><strong>${row.product_name}</strong></a>
							</td>
							<td><fmt:formatNumber value="${row.product_price}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td>${row.amount}</td>
							<td name="money"><fmt:formatNumber value="${row.money}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td>
						</tr>
					</c:forEach>
					
				</tbody>
				
				<thead>
					<tr>
						<th scope="col">총적립금</th>
						<th scope="col">배송료</th>
						<th scope="col">합계</th>
					</tr>
				</thead>
					<tbody>
						<tr>
						<td><img src="/images/point.png"><fmt:formatNumber value="${map.avail_point}"
							pattern="###,###,###"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${map.fee}"
							pattern="###,###,###"></fmt:formatNumber></td>
						<td class="center">
							<strong><fmt:formatNumber value="${map.sum}"
							pattern="###,###,###"></fmt:formatNumber></strong>
						</td>
					</tr>
					</tbody>
				
			</table>
		</div>
		<ul class="ec-base-help controlInfo typeBtm">
			<li style="font-size: 11px; font-style: italic;">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</li>
		</ul>
		<div class="ec-base-button">
			<span class="gRight">
				<a href="javascript:window.history.back();" class=""><img src="/images/back.png"></a> <!-- 이전페이지 -->
			</span>
		</div>
		<!-- 주문 정보 -->
		<div class="orderArea  ec-shop-ordererForm">
			<div class="title">
				<h4 class="-font-ns">주문 정보</h4>
				<p class="required"> 필수입력사항</p>
			</div>
			<table class="table table-hover" border="1">
				<tbody class="address_form  ">
					<tr>
						<th scope="row">
							주문하시는 분 *&nbsp;
						</th>
						<td>
							<input name="name" id="name" size="10" value="${map.name}">
						</td>
					</tr>
					<tr class>
						<th scope="row">
							주소 *&nbsp;
						</th>
						<td>
							<input name="zipcode" id="zipcode" readonly="readonly" size="7" value="${map.dto2.zipcode}">
							<!-- <input type="button" onclick="daumZipCode()" value="우편번호 찾기"> -->
							<a href="#"><img src="/images/post.png" onclick="daumZipCode()"></a><br>
							<input name="address1" id="address1" size="45" readonly="readonly" value="${map.dto2.address1}">기본 주소<br>
							<input name="address2" id="address2" size="30" value="${map.dto2.address2}">나머지 주소
						</td>
					</tr>
					<tr>
						<th scope="row">
							휴대전화 *&nbsp;
						</th>
						<td>
							<input type="hidden" id="phone" name="phone" value="${map.dto2.phone}">
							<select id="phone1" name="phone1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> - 
							<input name="phone2" id="phone2" size="4"> - 
							<input name="phone3" id="phone3" size="4">
						</td>
					</tr>
				</tbody>
				<tbody class="email ec-orderform-emailRow">
					<tr>
						<th scope="row">
							이메일 *&nbsp;
						</th>
						<td>
							<input type="text" name="email" id="email" size="30" value="${map.dto2.email}">
							<ul class="gBlank5 txtInfo">
								<li>- 이메일을 통해 주문처리과정을 보내드립니다.</li>
								<li>- 이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요.</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="-titlepack">
		<br><br>
		<h4 class="-font-ns">결제 예정 금액</h4>
	</div>
	<div class="totalArea">
		<div class="ec-base-table typeList gBorder total">
			<table border="1" class="table table-hover">
				<colgroup>
					<col style="width: 33.33%">
					<col style="width: 33.33%" class>
					<col style="width: 33.33%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" style="text-align: center;">
							<strong>총 주문 금액</strong>
						</th>
						<th scope="col" style="text-align: center;">
							<strong>총 </strong>
							<strong id="total_addsale_text">할인 </strong>
							<strong>금액</strong>
						</th>
						<th scope="col" style="text-align: center;">
							<strong>총 결제예정 금액</strong>
						</th>
					</tr>
				</thead>
				<tbody class="center">
					<tr>
						<td class="price">
							<div class="box txt16">
								<strong>₩
									<span id="total_order_price_view" class="txt23">${map.sum}</span>원
								</strong>
							</div>
						</td>
						<td class="option">
							<div class="box txt16">
								<strong>-</strong>
								<strong>₩
									<span id="total_sale_price_view" class="txt23">0</span>원
								</strong>
							</div>
						</td>
						<td>
							<div class="box txtEm txt16">
								<strong>=</strong>
								<strong>₩
									<span id="total_order_sale_price_view" class="txt23">${map.sum}</span>원
								</strong>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="detail">
			<div class="ec-base-table gMerge ">
				<table border="1" summary>
					<colgroup>
						<col style="width:139px">
						<col style="width:auto">
					</colgroup>
					
					<tbody>
						<tr class="sum txt14">
							<th scope="row">
								<strong>총 할인금액</strong>
							</th>
							<td>
								&nbsp;₩
								<strong id="total_addsale_price_view">0</strong>원
							</td>
						</tr>
						<tr class=" mCouponSelect">
							<th scope="row">
								쿠폰할인
							</th>
							<td>
								&nbsp;
								<a href="#" id="btnCoupon" class="-btn -black -sm">
									<img src="/images/coupon.png">
								</a>
							</td>
						</tr>
						<tr class="sum txt14">
							<th scope="row">
								<strong>적립금</strong>
							</th>
							<td>
								&nbsp;₩
								<input type="text" name="point" id="point">
								 원 (총 사용가능 포인트 : ₩${map.sum})
								<strong>${map.point}</strong>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="-titlepack">
		<br><br>
		<!-- <h3 class="-font-ns">결제수단</h3> -->
	</div>
	<div class="payArea">
		<div class="total">
			<h4>
				<strong>최종결제 금액</strong>
			</h4>
			<p class="price">
				<span>₩</span>
				<input id="sum" name="sum" type="text" readonly="readonly" value="${map.sum}">
				<span>원</span>
			</p>
			<div class="button">
				<!-- <button id="btnPayment" type="button"><img src="/images/payment.png"></button> -->
				<a href="#" id="btnPayment"><img src="/images/payment.png"></a>
			</div>
			<div class="xans-order-form .payArea:after">
				
			</div>
		</div>
	</div>
	</form>
</div>
</body>
</html>