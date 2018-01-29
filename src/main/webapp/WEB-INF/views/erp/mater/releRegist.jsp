<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" var="url" />
	<link href="${url}/resources/css/erp/releRegist.css" rel="stylesheet">
	<c:import url="${url}/resources/temp/ref.jsp"></c:import> 

<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		var message = '${message}';
		
		if(message != ""){
			swal(message);
		}
		
		
		$("#rr_insert").click(function(){
			$.ajax({
				type:"GET",
				url:"../../codeName",
				success:function(data){
					$("#materCode").val(data);
					
					$.ajax({
						type : "GET",
						url : "./materOrder",
						success:function(data){
							$("#erp_jh_modal_table").html(data);
						}
					}); 
				}
			});
		});
		
		$(".rr_btn").click(function(){
 			var materDate=$("#materDate").val();
 			var account=$("#account").val();
 			var temp=$("#temp").val();
 			var name=$("#name").val();
 			
			if(materDate==""){
				swal("출고날을 입력해주세요.");
			}else if(temp=""){
				swal("부서를 입력해주세요.");
			}else if(name=""){
				swal("담당자 입력해주세요.");
			}else{
				$("#rr_write_frm").submit();
				$(".rr_btn").attr("data-dismiss", "modal");
			}
		}); 
		
		$("#search_btn").click(function(){
			
			var smaterDate=$("#smaterDate").val();
			var ematerDate=$("#ematerDate").val(); 
			var materKind="rele";
			
		 	if(smaterDate=="" || ematerDate==""){
		 		swal("기간을 입력해주세요.");
			}else{ 
				
				$.ajax({
					type : "GET",
					url : "./materDateList",
					data : {
						materKind : materKind,
						smaterDate : smaterDate,
						ematerDate : ematerDate
					},
					success:function(data){
						$("#erp_jh_contents_table").html(data);
					}
				});
			}
		});
		
		$("#dateListReset").click(function(){
			location.reload();
		});
		
		$(".materView").click(function(){
			var materCode=$(this).attr("title");
			
			$.ajax({
				data : {"materCode" : materCode},
				url : "./materView",
				type : "get",
				success : function(data){
					$("#er_update_modal_contents").html(data);
				},
				error : function(){
					swal("error");
				}
			});
		});
		
		$("#erp_jh_modal_table").on("click", "#allCheck", function(){
			var id=$(this).attr("id");
			var title=$(this).attr("title");
			
			if($("#allCheck").prop("checked")){
				$(".materCheck").prop("checked",true);
				$("#order"+id).prop("disabled", false);
				$("#code"+title).prop("disabled", false);
			}else{
				$(".materCheck").prop("checked",false);
				$("#order"+id).prop("disabled", true);
				$("#code"+title).prop("disabled", true);
			}
		});
		
		$("#erp_jh_modal_table").on("click", ".materCheck", function(){
			var id=$(this).attr("id");
			var title=$(this).attr("title");
			
			if($("#"+id).prop("checked")){
				$("#order"+id).prop("disabled", false);
				$("#code"+title).prop("disabled", false);
			}else{
				$("#order"+id).prop("disabled", true);
				$("#code"+title).prop("disabled", true);
			}
		});
		
		$("#rr_update_modal").on("click", ".mater_delete", function(){
			var materCode=$(this).attr("title");
			var materKind="rele";

			$.ajax({
				data : {"materCode" : materCode,
						"materKind" : materKind},
				url : "./materDelete",
				type : "get",
				success : function(data){
					swal("삭제 완료");
					location.reload();
				},
				error : function(){
					swal("error");
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
         자재관리
      </div>
      <!-- submenu banner end -->
      
      <!-- submenu menu -->
         <div class="fw_menu " data-toggle="collapse" data-target="#sub1" title="sub1">
            기초정보
            <div class="fw_arrow sub1">
               ∧
            </div>
         </div>
         
         <div class="fw_subsub collapse " id="sub1">
            <ul>
              <li><a href="../foundation/supplier">거래처 등록</a></li>
               <li><a href="../foundation/product">제품 등록</a></li>
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
               <li><a href="../order/orderRegist">주문 입력</a></li>
               <li><a href="../order/graph/orderGraph">주문 현황 보기</a></li>
            </ul>
         </div>
         
         <!-- ----------3---------- -->
         <div class="fw_menu fw_selected" data-toggle="collapse" data-target="#sub3" title="sub3" >
               자재관리
            <div class="fw_arrow sub3">
               ∨
            </div>
         </div>
         
         <div class="fw_subselected  collapse in"  id="sub3">
            <ul>
               <li><a href="../../erp/mater/materRegist?materKind=enter">입고 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=rele">출고 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=back">반품 입력</a></li>
               <li><a href="../../erp/mater/materRegist?materKind=confin">불출 입력</a></li>
            </ul>
         </div>
         
         <!-- ----------4---------- -->
         <div class="fw_menu" data-toggle="collapse" data-target="#sub4" title="sub4" >
               	조회
            <div class="fw_arrow sub4">
               	∨
            </div>
         </div>
         
         <div class="fw_subsub collapse"  id="sub4">
            <ul>
               <li><a href="../../erp/into/intoList">조회 및 엑셀 다운</a></li>
            </ul>
         </div>
         
      <!-- submenu menu end -->
   </div>
	<!-- submenu end -->
	
	<!-- --------------------------------------------------------------------------------------------------------------- -->
	
	<input type="hidden" name="materKind" value="rele">
	
	<div id="fw_mainwrap">
			<div id="fw_main">
				<div id="rr_icon"><img id="logoImg" src="${pageContext.request.contextPath}/resources/images/logo/smallLogo.png"></div>
			</div>
			
			<div id="fw_main_contents">
				<div id="erp_jh_contents_title">
					
					<p id="rr_title">출고등록</p>
				</div>
				<div id="erp_jh_contents_search">
					<div id="rr_search">
						<!-- 검색 기능 -->
							<div class="input-group search_group">
								<form id="rr_search_frm" method="get">
								<input type="hidden" name="materKind" value="rele">
									기간 선택 &nbsp;<input id="smaterDate" name="smaterDate" type="date"> &nbsp;~&nbsp; <input id="ematerDate" name="ematerDate" type="date">					
							        <button type="button" id="search_btn" class="btn btn-default"><i class="fa fa-search"></i></button>
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
						        <th>출고코드</th>
						        <th>출고일</th>
						        <th>부서</th>
						        <th>담당자</th>
						        <th>비고</th>
						      </tr>
						    </thead>
						    
						    <tbody>
						   <c:forEach items="${releList}" var="releList">
						      <tr>
						        <td class="materView" title="${releList.materCode}" data-toggle="modal" data-target="#rr_update_modal">${releList.materCode}</td>
						        <td>${releList.materDate}</td>
						        <td>${releList.temp}</td>
						        <td>${releList.name}</td>
						        <td>${releList.materMemo}</td>
						      </tr>
						    </c:forEach>
						    </tbody>
						 </table>
					</div>
				<!-- table 끝 -->
				
				<!-- 등록 버튼 -->
					<div id="erp_jh_contents_bottom">
					<c:if test="${member.temp eq '영업/구매부'}">
						<button id="rr_insert" class="btn btn-default modal_btn" data-toggle="modal" data-target="#rr_modal">신규등록</button>
					</c:if>
					</div>
				<!-- 등록 버튼 끝 -->
				
				
				<!-- Modal -->
				<div class="modal fade" id="rr_modal" role="dialog">
				    <div class="modal-dialog modal-m">
				      <div class="modal-content">
				      
				      	<!-- modal header -->
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">|출고 등록</h4>
				        </div>
				        <!-- modal header 끝-->
				        
				        <!-- modal contents -->
				         <form action="./materWrite" method="get" id="rr_write_frm">
				        <div class="modal-body">
				        	<div class="input-group input-group_modal">
							  <span class="input-group-addon">출고코드</span>
							  <input id="materCode" name="materCode" type="text" class="form-control" placeholder="Additional Info">
							</div>
							
							<div class="input-group input-group_modal">
							  <span class="input-group-addon">출고일</span>
							  <input  id="materDate" name="materDate" type="date" class="form-control">
							</div>
							
							<div class="input-group input-group_modal">
							  <span class="input-group-addon">부서</span>
							  <input id="temp" name="temp" type="text" class="form-control" placeholder="Additional Info">
							</div>
							
							<div class="input-group input-group_modal">
							  <span class="input-group-addon">담당자</span>
							  <input id="name" name="name" type="text" class="form-control" placeholder="Additional Info">
							</div>
							
							<div class="input-group input-group_modal">
							  <span class="input-group-addon">비고</span>
							   <textarea name="materMemo" class="form-control form-control_area" rows="5" id="comment"></textarea>
							</div>
							
							<input type="hidden" name="materKind" value="rele">
				       		
				       		<div id="erp_jh_modal_table">
							
							</div>
				        </div>
				        <!-- modal contents 끝-->
				        
				        <!-- modal footer -->
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default rr_btn">등록</button>
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				        </form>
				      	<!-- modal footer 끝-->
				      </div>
				    </div>
				  </div>
				<!-- Modal 끝 -->
				
				
				<!-- 수정 Modal -->
				
				<div class="modal fade" id="rr_update_modal" role="dialog">
				  <div id="er_update_modal_contents">
					</div>
				  </div>
				<!-- 수정 Modal 끝 -->
				
				
			</div>
		</div>
	</div>
</body>
</html>