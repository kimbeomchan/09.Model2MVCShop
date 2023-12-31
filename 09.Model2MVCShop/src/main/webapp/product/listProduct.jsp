<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScript 이용
	function fncGetPageList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
	   	//document.detailForm.submit();
	   	$("#currentPage").val(currentPage)
	   	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	
	$(function () {
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			var prodNo = $(this).data('prodno');
			var menu = "${menu}";
			
			if (menu == "search") {
				$("input[name='prodNo']").val(prodNo);
				$("form").attr("method", "POST").attr("action", "/product/getProduct").submit();
			} else if (menu == "manage") {
				$("input[name='prodNo']").val(prodNo);
				$("form").attr("method", "POST").attr("action", "/product/updateProductView").submit();
			}
		});	
	});
	
	$(function () {
		var prodNo = $(this).data('prodno');
		
		$("c:if:contains('배송하기')").on("click", function(){
			self.location.href = "/purchase/updateTranCode?prodNo=" + prodNo + "&tranCode=2&currentPage=" + ${resultPage.currentPage};
		});
		
	});
	
	 $(function() {
		$("td.ct_btn01:contains('검색')").on("click" , function() {
			fncGetPageList(1);
		});
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<%-- <form name="detailForm" method="POST" action="/product/listProduct?menu=${menu}"> --%>

<form name="detailForm" >

<input type="hidden" name="prodNo" />
<input type="hidden" name="menu" value="${menu}"/>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
					<c:if test="${menu.equals('search')}" >
						상품 목록 조회
					</c:if>
					<c:if test="${menu.equals('manage')}" >
						상품 관리
					</c:if>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${search.searchCondition.equals("0") ? "selected" : "" } >상품번호</option>
				<option value="1" ${search.searchCondition.equals("1") ? "selected" : "" } >상품명</option>
				<option value="2" ${search.searchCondition.equals("2") ? "selected" : "" } >상품가격</option>
			</select>
			<input 	type="text" name="searchKeyword"  value="${search.searchKeyword}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetPageList(1);">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">

	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount}  건수,	현재 ${resultPage.currentPage} 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="i" value="0" />
	<c:forEach var="vo" items="${list}" >
		<c:set var="i" value="${ i + 1 }" />
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<%-- <td align="left" data-prodno="${vo.prodNo}" > --%>
		<td align="left" data-prodno="${vo.prodNo}"> ${vo.prodName}
			<%-- <c:if test="${menu.equals('search')}" >
				<a href="/product/getProduct?prodNo=${vo.prodNo}&menu=${menu}">${vo.prodName}</a>
				${vo.prodName}
			</c:if>
			<c:if test="${menu.equals('manage')}" >
				<a href="/product/updateProductView?prodNo=${vo.prodNo}&menu=${menu}">${vo.prodName}</a>
			</c:if> --%>
		</td>
		<td></td>
		<td align="left">${vo.price}</td>
		<td></td>
		<td align="left">${vo.regDate}</td>
		<td></td>
		<td align="left">
		
			<c:if test="${menu.equals('manage')}">
				<c:if test="${vo.proTranCode == null}" >
					판매중
				</c:if>
				<c:if test="${vo.proTranCode.trim() == '1'}" >
					구매완료
					<%-- <a href="/purchase/updateTranCode?prodNo=${vo.prodNo}&tranCode=2&currentPage=${resultPage.currentPage}">배송하기</a> --%>
				</c:if>
				<c:if test="${vo.proTranCode.trim() == '2'}" >
					배송중
				</c:if>
				<c:if test="${vo.proTranCode.trim() == '3'}" >
					배송완료
				</c:if>
			</c:if>
			
			<c:if test="${menu.equals('search')}">
				${vo.proTranCode == null ? '판매중' : '판매완료'}
			</c:if>
			
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
	</c:forEach>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp" />
		
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>
</div>
</body>
</html>
