<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" var="url" />
	<link href="${url}/resources/css/erp/orderRegist.css" rel="stylesheet">
	<c:import url="${url}/resources/temp/ref.jsp"></c:import> 

<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		var message = '${message}';
	
		if(message != ""){
			alert(message);
		}
		
		$("#or_insert").click(function(){
			
			$.ajax({
				type:"GET",
				url:"../../codeName",
				success:function(data){
					$("#orderCode").val(data);
					
					$.ajax({
						type:"GET",
						url:"../mater/materStorageList",
						success:function(data){
							var i=0;
							$(data).each(function(){
								$("#storageName").append("<option value="+data[i]+">"+data[i]+"</option>");
								i++;
							});
							
							$.ajax({
								type : "GET",
								url : "../mater/materSupList",
								success:function(data){
									var i=0;
									$(data).each(function(){
										$("#account").append("<option value="+data[i]+">"+data[i]+"</option>");
										i++;
									});
								}
							});
						}
					});
				}
			});
		});
		
		$(".er_btn").click(function(){
			$("#or_write_frm").submit();
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
         자재관리
      </div>
      <!-- submenu banner end -->
      
      <!-- submenu menu -->
         <div class="fw_menu fw_selected" data-toggle="collapse" data-target="#sub1" title="sub1">
            기초정보
            <div class="fw_arrow sub1">
               ∧
            </div>
         </div>
         
         <div class="fw_subselected collapse in" id="sub1">
            <ul>
               <li> 거래처 등록</li>
               <li> 제품 등록</li>
               <li><a href="../../erp/foundation/menuRegist">메뉴 등록</a></li>
               <li><a href="../../erp/foundation/storageRegist">창고 등록</a></li>
            </ul>
         </div>
         
         <!-- ----------2---------- -->
            <div class="fw_menu" data-toggle="collapse" data-target="#sub2" title="sub2" >
               구매관리
            <div class="fw_arrow sub2">
               ∨
            </div>
         </div>
         
         <div class="fw_subsub collapse"  id="sub2">
            <ul>
               <li><a href="../../erp/order/orderRegist">주문 입력</a></li>
               <li> 주문 현황 보기</li>
            </ul>
         </div>
         
         <!-- ----------3---------- -->
         <div class="fw_menu" data-toggle="collapse" data-target="#sub3" title="sub3" >
               자재관리
            <div class="fw_arrow sub3">
               ∨
            </div>
         </div>
         
         <div class="fw_subsub collapse"  id="sub3">
            <ul>
               <li><a href="../../erp/mater/materRegist?materKind=enter">입고 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=rele">출고 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=back">반품 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=confin">불출 입력</a></li>
            </ul>
         </div>
         
         <!-- ----------4---------- -->
         <div class="fw_menu"  >
               	조회
         </div>
         
      <!-- submenu menu end -->
   </div>
	<!-- submenu end -->
	
	<!-- --------------------------------------------------------------------------------------------------------------- -->
	
	<div id="fw_mainwrap">
			<div id="fw_main">
				<!-- <div class="sales_title_menu">기초 정보</div>
				<div class="sales_title_menu">구매 관리</div>
				<div class="sales_title_menu">자재 관리</div>
				<div class="sales_title_menu">반품 관리</div>
				<div class="sales_title_menu">조 회</div> -->
			</div>
			
			<div id="fw_main_contents">
				<div id="erp_jh_contents_title">
					<div id="or_icon">icon</div>
					<p id="or_title">주문 입력</p>
				</div>
				<div id="erp_jh_contents_search">
					<div id="er_search">
						<!-- 검색 기능 -->
							<div class="input-group search_group">
								<form id="or_search_frm" method="get">
									<input type="hidden" name="materKind" value="enter">
									기간 선택 <input id="smaterDate" name="smaterDate" type="date"> ~ <input id="ematerDate" name="ematerDate" type="date">		
							      <div class="input-group-btn">
							        <button type="button" id="search_btn" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
							      </div>
							      <input id="dateListReset" class="btn btn-default" type="button" value="초기화">
							    </form>	
						    </div>	
						<!-- 검색 기능 끝 -->
					</div>
				</div>
				
				<!-- table -->
					<div id="erp_jh_contents_table">
						<table class="table">
						    <thead>
						      <tr>
						        <th>주문코드</th>
						        <th>계약일</th>
						        <th>납기일</th>
						        <th>거래처</th>
						        <th>품목</th>
						        <th>금액</th>
						      </tr>
						    </thead>
						    
						    <tbody>
						    <c:forEach items="${orderList}" var="orderList"> 
						      <tr>
						        <td class="materView" title="${enterList.materCode}" data-toggle="modal" data-target="#er_update_modal">${orderList.orderCode}</td>
						        <td>${orderList.contractDate}</td>
						        <td>${orderList.deadline}</td>
						        <td>${orderList.account}</td>
						        <td></td>
						        <td></td>
						      </tr>
						    </c:forEach>
						    </tbody>
						 </table>
					</div>
				<!-- table 끝 -->
				
				<!-- 등록 버튼 -->
					<div id="erp_jh_contents_bottom">
						<button id="or_insert" class="modal_btn" data-toggle="modal" data-target="#or_modal">신규등록</button>
					</div>
				<!-- 등록 버튼 끝 -->
				
				
				<!-- Modal -->
				<div class="modal fade" id="or_modal" role="dialog">
				    <div class="modal-dialog modal-lg">
				      <div class="modal-content">
				      
				      	<!-- modal header -->
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">|주문 입력</h4>
				        </div>
				        <!-- modal header 끝-->
				        
				        <!-- modal contents -->
				       <form action="./orderWrite" method="post" id="or_write_frm">
				        <div class="modal-body">
				        	<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">주문코드</span>
							  <input id="orderCode" name="orderCode" type="text" class="form-control" readonly="readonly">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">계약일자</span>
							  <input id="contractDate" name="contractDate" type="date" class="form-control">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">부서</span>
							  <input id="temp" name="temp" type="text" class="form-control">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">작성자</span>
							  <input id="name" name="name" type="text" class="form-control">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">거래처</span>
							  <select id="account" name="account">
							  </select>
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">납품장소</span>
							  <input id="delivery" name="delivery" type="text" class="form-control">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">납기일</span>
							  <input id="deadline" name="deadline" type="date" class="form-control">
							</div>
							
							<div class="input-group input-group_modal or_input-group_modal">
							  <span class="input-group-addon">출하창고</span>
							  <select id="storageName" name="storageName">
							  </select>
							</div>
							
							<div class="input-group input-group_modal memo_modal">
							  <span class="input-group-addon">메모</span>
							   <textarea name="orderMemo" class="form-control form-control_area" rows="5" id="comment"></textarea>
							</div>
							
							
							<div id="erp_jh_modal_table">
								<table class="table">
								    <thead>
								      <tr>
								        <th>제품코드</th>
								        <th>제품명</th>
								        <th>규격</th>
								        <th>단가</th>
								        <th>수량</th>
								        <th>금액</th>
								      </tr>
								    </thead>
								    
								    <tbody>
								    <%-- <c:forEach items="${orderList}" var="orderList"> 
								      <tr>
								        <td class="materView" title="${enterList.materCode}" data-toggle="modal" data-target="#er_update_modal">${orderList.orderCode}</td>
								        <td>${orderList.contractDate}</td>
								        <td>${orderList.deadline}</td>
								        <td>${orderList.account}</td>
								        <td></td>
								        <td></td>
								      </tr>
								    </c:forEach> --%>
								    </tbody>
								 </table>
							</div>
							
				        </div>
				        <!-- modal contents 끝-->
				        
				        <!-- modal footer -->
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default er_btn">등록</button>
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </form>
				      	<!-- modal footer 끝-->
				      </div>
				    </div>
				  </div>
				<!-- Modal 끝 -->
				
				
				<!-- 수정 Modal -->
				
				
				<!-- 수정 Modal 끝 -->
				
				
			</div>
		</div>
	</div>
</body>
</html>