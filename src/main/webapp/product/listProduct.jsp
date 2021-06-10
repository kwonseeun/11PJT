<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">


function fncGetProductList(currentPage){

	$("#currentPage").val(currentPage)

	$("form").attr("method" , "POST").attr("action" , "/product/listProduct.").submit();
}

$(function() {
	 
});


//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
$( "td:nth-child(2)" ).on("click" , function() {
	 self.location ="/product/getProduct?prodNo="+$(this).text().trim();
});
			
$( "td:nth-child(2)" ).css("color" , "red");

});	
	
	
	
	$(function() {
	
	$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			
			var prodNo = $(this).children().val().trim();
			
			alert(prodNo);
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
			

							
							var displayValue = "<h3>"
														+"상품번호 : "+JSONData.prodNo+"<br/>"
														+"상품이름 : "+JSONData.prodName+"<br/>"
														+"가격 : "+JSONData.price+"<br/>"
														+"등록일 : "+JSONData.regDate+"<br/>"
														+"현재상태: "+JSONData.manufactDay+"<br/>"
														+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "#"+prodNo+"" ).html(displayValue);
							}
							
					});
							
	});						
			
	
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "orange");
	$("h7").css("color" , "orange");
	
			
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmosk");
});	

</script>

</head>

<body >


<jsp:include page="/layout/toolbar.jsp" />


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
	
			<div class="page-header text-info">
	       <h3>상품목록조회</h3>
	    </div>
	
 		<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-defualt">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">

		<div class="form-group">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${!empty search.searchCondition && search.searchCondition==0?"selected":""}>상품번호</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1?"selected":""}>상품명</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition==2?"selected":""}>가격</option>
			</select>
		</div>	
			 
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
		상품명<br>
			<h7> (click:상세정보)</h7>
		</td>
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
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${i+1}" />
		<tr class="ct_list_pop">
		<td align="center">${i}</td>
		<td></td>
		<td align="left">
			<input type="hidden" prodNo="${product.prodNo }" value="${product.prodNo}"/>
			<!-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>-->
			${product.prodName}
		</td>
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>	
		<td></td>
		<td align="left">
		<c:if test="${param.menu=='manage'}">
			<c:choose>
			<c:when test="${empty product.proTranCode}">
				판매중
			</c:when>
			<c:when test="${product.proTranCode=='1'}">
				구매완료
				<a href="/updateTranCode.do?menu=manage&prodNo=${product.prodNo}&tranCode=2">배송하기</a>
			</c:when>
			<c:when test="${product.proTranCode=='2'}">
				배송중
			</c:when>
			<c:when test="${product.proTranCode=='3'}">
				배송완료
			</c:when>
		</c:choose>
		</c:if>
		<c:if test="${param.menu=='search'}">
			<c:choose>
			<c:when test="${!empty product.proTranCode}">
				재고없음
			</c:when>
			<c:when test="${empty product.proTranCode}">
				판매중
			</c:when>
		</c:choose>
		</c:if>
		</td>	
	</tr>
	<tr>	
	<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<!-- PageNavigation Start -->

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
				<jsp:include page="../common/ProductpageNavigator.jsp"/> 
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>
</div>

</body>
</html>