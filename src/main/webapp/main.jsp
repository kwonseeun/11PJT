<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="/css/background.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<script>
	!function ($){
		/*=============
		캐러젤 슬라이더
		*===============*/
		$(function () {
			$('.carousel').carousel({
				interval:2000
			});
		});
	}(window.jQuery);
	</script>
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
	
    .carousel-inner > .item > img {
      top: 0;
      left: 0;
	min-width: 100%;
    } 
    
      .carousel-inner > .item > h1 {
      text-align:center;
      }


        body {
            padding-top : 70px;
        }
        a:hover, a:focus { 

    animation-duration: 3s; 

    animation-name: rainbowLink; 
    animation-iteration-count: infinite; 

} 

@keyframes rainbowLink {     

    0% { color: #ff2a2a; }

    15% { color: #ff7a2a; }

    30% { color: #ffc52a; }

    45% { color: #43ff2a; }

    60% { color: #2a89ff; }

    75% { color: #202082; }

    90% { color: #6b2aff; } 

   100% { color: #e82aff; }
   
   

}
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	 	
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div id="kv" class="carousel slide">

		<ol class="carousel-indicators">

		  <li data-target="#kv" data-slide-to="0" class="active"></li>

		  <li data-target="#kv" data-slide-to="1" class=""></li>

		  <li data-target="#kv" data-slide-to="2"></li>

		</ol>    

		<div class="carousel-inner">

			<div class="item active">

				<img src="images/gom1.jfif" alt="wecome">

				<div class="carousel-caption hidden-phone">

				<h1> 01번 </h1>

				</div>

			</div>

			<div class="item">

				<img src="images/gom2.jfif" alt="My story" />

				<div class="carousel-caption hidden-phone">

				<h1> 02번 </h1>

				</div>

			</div>

			<div class="item">

				<img src="images/gom3.jfif" alt="My story" />

				<div class="carousel-caption hidden-phone">

				<h1> 03번 </h1>

				</div>

			</div>

		</div>

		<a class="left carousel-control" href="#kv" data-slide="prev"><</a>

		<a class="right carousel-control" href="#kv" data-slide="next">></a>

	</div>

</body>

</html>