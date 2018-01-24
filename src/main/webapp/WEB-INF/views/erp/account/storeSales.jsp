<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" var="url" />
<c:import url="${url}/resources/temp/ref.jsp"></c:import> 
 <link href="${url }/resources/css/erp/storeSales.css" rel="stylesheet">


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

 


<title>Insert title here</title>
<script type="text/javascript">

		 
 $(function(){
	 
		 var message = '${message}';
	     if(message != ""){
	        alert(message);
	     }
	 
		$(".fw_menu").click(function(){
			var sub = $(this).attr("title");
			
			if($("."+sub).html().trim()=="∧"){
				$("."+sub).html("∨");
			}else{
				$("."+sub).html("∧");
			}
			
		});
	 
		$("#eb_searchBtn").click(function(){
			var store=$("#eb_selectStore").val();
			var menu=$("#eb_selectMenu").val();
			var regdate=$("#eb_selectRegdate").val();
			alert(store);
			alert(menu)
			alert(regdate)			
			$("#eb_contents_table").css("display","block");
			$("#eb_storeName").val(store);
			
			$.ajax({
				type : "post",
				url : "./storeSearch",
				data : {
					"store" : store,
					"product" : menu,
					"regdate" : regdate
				}, success : function(data){
					alert(data);
				}
			});
		});
	 
	
	 
 });
 
 
 
 
</script>
</head>
<body>
<c:import url="${url}/resources/temp/headerExample.jsp"></c:import> 


<div id="fw_container">
	<!-- submenu -->
	<div id="fw_subcontainer">
	
		<!-- submenu banner -->
		<div id="fw_subbanner">
			회계
		</div>
		<!-- submenu banner end -->
		
		<!-- submenu menu -->
			<div class="fw_menu " data-toggle="collapse" data-target=".fw_subselected" title="sub1">
				기초정보
				<div class="fw_arrow sub1">
					∧
				</div>
			</div>
			
			<div class="fw_subselected collapse" id="sub1">
				<ul>
					<li><a href="./storeRegist"> 지점 등록</a></li>
					<li><a href="./accountRegist">예금 계좌 등록</a></li>
					<li><a href="./tempRegist">부서 등록</a></li>
				</ul>
			</div>
			
			<!-- ----------2---------- -->
				<div class="fw_menu fw_selected" data-toggle="collapse" data-target="#sub2" title="sub2" >
					전표 
				<div class="fw_arrow sub2">
					∨
				</div>
			</div>
			
			<div class="fw_subsub collapse in"  id="sub2">
				<ul>
					<li><a href="./storeSales">지점매출</a></li>
					<li><a href="./chit"> 전표 입력</a></li>
					<li><a href="./chitApproval">승인전표</a></li>
					<li><a href="./chitNapproval">미승인전표</a></li>
				</ul>
			</div>
			
		
		
			
			
			
			
		<!-- submenu menu end -->
	</div>
	<!-- submenu end -->
	
	<div id="fw_mainwrap">
		
		<div id="fw_main">
			
			<div id="eb_fw_main_1"></div>
			
			<div id="eb_fw_main_2">
				<table id="eb_fw_main_2_table">
					<tr >
						<td class="eb_row">회계</td>
						<td class="eb_row">영업/구매</td>
						<td class="eb_row">인사</td>
						<td class="eb_row">일정</td>
					</tr>
				</table>
			</div>
				
				
		</div>
			
			
			<!--contents 시작  -->
			<div id="eb_contents_wrap">
				 
				<div class="eb_contents_text">
				 	<span class="glyphicon glyphicon-file" id="eb_contents_text_p">지점매출</span>
				</div>
				
				<div id="eb_contents_box">
				
			<div class="eb_blank"></div>
					
					
				<!-- 검색 -->
				   <input type="hidden" name="curPage" value="1">
					
					
				<!-- <form name="frm" action="./storeSales" method="get"> -->
					<div id="eb_contents_box_div" >
						<input type="hidden" name="curPage" value="1">
					  	
						  	<table id="eb_searchTable" >
						  		<tr>
						  			<td class="eb_searchTd1">날짜</td>
						  			<td class="eb_searchTd"><input type="date" name="regdate" id="eb_selectRegdate"></td>
						  			<td class="eb_searchTd1">지점</td>
						  			<td class="eb_searchTd">
						  			
						  				<select name="store" id="eb_selectStore">
						  			 <c:forEach items="${list }" var="dto">	
									  		<option value="${dto.store }" title="${dto.code}">${dto.store }</option>
									  	</c:forEach>	
						  				</select>
						  			</td>
						  		</tr>
						  		
						  		<tr>
						  			<td class="eb_searchTd1">상품명</td>
						  			<td class="eb_searchTd">
						  					<select name="menu" id="eb_selectMenu">
						  				 <c:forEach items="${mr_list}" var="dto">	
									  		<option value="${dto.menuName}">${dto.menuName}</option>
									  	</c:forEach>	
						  				</select>
						  			
						  			</td>
						  			
						  			<td colspan="2"><input type="button" class="btn btn-defalut" id="eb_searchBtn" value="search"></td>
						  		</tr>
						  	
						  	
						  	
						  	</table> 
			
					
						
						</div>
			<!-- 	</form>		 -->
				   <!--검색 끝 -->
				  
				</div> 
				
				<div id="eb_contents_table">
				  	
             				
             			
             			<p>지점명 <input type="text" id="eb_storeName" readonly="readonly" style="border: 0;"></p>
             		<table class="table">
						   
						<thead id="eb_table_head">
						    <tr>
						     <th>날짜</th>
						     <th>상품명</th>
						     <th>판매개수</th>	
						     <th>상품당 매출</th>					   
						    </tr>
						 </thead>
						    
					<%-- 	    <tbody>
						   
						   </tbody> --%>
					 </table>
		
		 	 
				
				
				
				<!-- page 처리 -->
				<div id="eb_page">
					<c:if test="${pager.curBlock gt 1}">
						<span class="eb_list" title="${pager.startNum-1}">[이전]</span>
					</c:if>
					
					<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
						<span class="eb_list" title="${i}">${i}</span>
					</c:forEach>
					
					<c:if test="${pager.curBlock lt pager.totalBlock}">
						<span class="eb_list" title="${pager.lastNum+1}">[다음]</span>
					</c:if>
				</div>  		  
						  
						  
				<!-- page 처리 끝 -->		  
				
			
		</div>
	</div>
   </div>
</div>

</body>
</html>