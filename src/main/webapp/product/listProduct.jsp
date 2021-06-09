<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ ��� ��ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">


function fncGetProductList(currentPage){

	$("#currentPage").val(currentPage)

	$("form").attr("method" , "POST").attr("action" , "/product/listProduct.").submit();
}

$(function() {
	 
	//==> �˻� Event ����ó���κ�
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
	 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
		fncGetProductList(1);
	});
	
	
	//==> userId LINK Event ����ó��
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
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
														+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
														+"��ǰ�̸� : "+JSONData.prodName+"<br/>"
														+"���� : "+JSONData.price+"<br/>"
														+"����� : "+JSONData.regDate+"<br/>"
														+"�������: "+JSONData.manufactDay+"<br/>"
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

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">${param.menu=='manage'?"��ǰ����":"��ǰ��� ��ȸ"}</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${!empty search.searchCondition && search.searchCondition==0?"selected":""}>��ǰ��ȣ</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1?"selected":""}>��ǰ��</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition==2?"selected":""}>����</option>
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
						<!-- <a href="javascript:fncGetProductList('1');">�˻�</a>-->
						�˻�
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
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
		��ǰ��<br>
			<h7> (click:������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
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
				�Ǹ���
			</c:when>
			<c:when test="${product.proTranCode=='1'}">
				���ſϷ�
				<a href="/updateTranCode.do?menu=manage&prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
			</c:when>
			<c:when test="${product.proTranCode=='2'}">
				�����
			</c:when>
			<c:when test="${product.proTranCode=='3'}">
				��ۿϷ�
			</c:when>
		</c:choose>
		</c:if>
		<c:if test="${param.menu=='search'}">
			<c:choose>
			<c:when test="${!empty product.proTranCode}">
				������
			</c:when>
			<c:when test="${empty product.proTranCode}">
				�Ǹ���
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
<!--  ������ Navigator �� -->

</form>
</div>

</body>
</html>