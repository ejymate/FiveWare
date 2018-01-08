<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" var="url" />
<c:import url="${url}/resources/temp/ref.jsp"></c:import> 

<link href="${url}/resources/css/erp/ej_erp.css" rel="stylesheet">
<link href="${url}/resources/css/common/modal_boot.css" rel="stylesheet">
<link>

<title>Insert title here</title>

<script type="text/javascript">
	$(function() {
		//Get the modal
		var modal = document.getElementById('ej_modal');
		var modalOne = document.getElementById('ej_modalOne');
		
		// Get the button that opens the modal
		var btn = document.getElementById("ej_write_btn");
		
		// Get the <span> element that closes the modal
		var close = document.getElementsByClassName("close");
		
		// When the user clicks the button, open the modal 
		btn.addEventListener('click', function() {
			modal.style.display = "block";
		});
		
		// When the user clicks on <span> (x), close the modal
		close[0].addEventListener('click', function() {
			modal.style.display = "none";
		});
		
		close[1].addEventListener('click', function() {
			modalOne.style.display = "none";
		});
		
		// write - code
		$("#ej_write_btn").click(function() {
			$.ajax({
				type:"GET",
				url:"../../codeName",
				success:function(data){
					$("#code").val(data);
				}
			});
		});
		
		// update - selectOne
		$(".ej_modalOne_btn").click(function() {
			modalOne.style.display = "block";
			
			var code = $(this).text();
			$.ajax({
	            data : {"code" : code},
	            url : "./productOne",
	            type : "get",
	            success : function(data){
	            	$("#code_update").val(data.code);
					$("#classification_update").val(data.classification);
					$("#name_update").val(data.name);
					$("#business_number_update").val(data.business_number);
					$("#representative_update").val(data.representative);
					$("#division_update").val(data.division);
					$("#division_mail_update").val(data.division_mail);
					$("#bank_update").val(data.bank);
					$("#account_number_update").val(data.account_number);
					$("#use_update").val(data.use);
					
					// if 'use' is true, 'stop'
					if($("#use_update").val() == "true") {
						$("#ej_modal_stop").val("사용중지")
					} else {
						$("#ej_modal_stop").val("사용")
					}
	            },
	            error : function(data){
	               alert("error");
	            }
         	}); 
		});
		
		/////////////////////////////delete / use Stop////////////////////////////////////
		$("#ej_modal_delete").click(function() {
			var del = confirm("Are you sure you want to delete it?")
			
			if(del) {
				$("#ej_modalModify_frm").attr("action", "//////////////////////")
				$("#ej_modalModify_frm").submit();
			}
		});
		
		$("#ej_modal_stop").click(function() {
			$("#ej_modalModify_frm").attr("action", "////////////////////////")
			$("#ej_modalModify_frm").submit();
		});
		
		
		///////////////////////File Cancel/////////////////////////////////////
		$(".ej_file_cancel").click(function() {
			alert("test");
			$("#ej_write_frm").attr("action", "../../ajax/fileDelete");
			$("#ej_write_frm").submit();
		});
		
		////////////////////////////////////Pager//////////////////////////////////
		
		$(".ej_list").click(function() {
			var cur = $(this).attr("title");
			var s = '${pager.search}';
			var t = '${pager.kind}';
			document.ej_frm.curPage.value=cur;
			document.ej_frm.submit();
		});
		
		//////////////////////////File Upload//////////////////////////////////
		var obj = $("#dropzone");

	     obj.on('dragenter', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '2px solid #5272A0');
	     });

	     obj.on('dragleave', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '2px dotted #8296C2');
	     });

	     obj.on('dragover', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	     });

	     obj.on('drop', function (e) {
	          e.preventDefault();
	          $(this).css('border', '2px dotted #8296C2');

	          var files = e.originalEvent.dataTransfer.files;
	          
	          console.log(files);
	          
	          if(files.length < 1)
	               return;
	          
	          var code = document.getElementById('code').value;
	          
	          F_FileMultiUpload(files, code);
	     });
	     
	}); // Window Onload End
	
	function F_FileMultiUpload(files, code) {
		/*************** 이미지만 올릴 수 있도로고 처리!!!!!!! ******************/
		if( files.length < 5 ) {
	         var data = new FormData();
	         for (var i = 0; i < files.length; i++) {
	            data.append('file', files[i]);
	         }
	         
	         data.append('code', code)
	    
	         var url = "../../ajax/drapAndDrop";
	         $.ajax({
	            url: url,
	            method: 'post',
	            data: data,
	            processData: false,
	            contentType: false,
	            success: function(data) {
	            	alert("success!!");
	            	console.log(data);
	            	F_FileMultiUpload_Callback(data);
	            	
	            },
	            error: function() {
	            	alert("error");
	            }
	         });
		} else {
			alert("4개까지 이미지를 업로드할 수 있습니다.");
		}
	    
	}

	// 파일 멀티 업로드 Callback
	function F_FileMultiUpload_Callback(files) {
	    var result = document.getElementById('result');
	    alert(result);
		for(var i=0; i < files.length; i++){
		    var img = document.createElement('img');
		    img.setAttribute("src", "${pageContext.request.contextPath}/resources/product/"+files[i]);
		    img.setAttribute("width", "20%");
		    img.setAttribute("height", "150px");
		    img.className = "img_margin";
		    result.appendChild(img);
		}
	}
	
</script>

<style>
    #dropzone
    {
        border:2px dotted #3292A2;
        width:100%;
        height:50px;
        color:#92AAB0;
        text-align:center;
        font-size:24px;
        padding:10px;
    }
    #result {
    	width: 100%;
    	height: 150px;
    }
    
    .img_margin {
    	margin-left: 2.5%;
    	margin-right: 2.5%;
    }
</style>


</head>
<body>
<c:import url="${url}/resources/temp/headerExample.jsp"></c:import>

<div id="fw_container">
	<!-- submenu -->
	<div id="fw_subcontainer">
	
		<!-- submenu banner -->
		<div id="fw_subbanner">
			인사
		</div>
		<!-- submenu banner end -->
		
		<!-- submenu menu -->
			<div class="fw_menu fw_selected" data-toggle="collapse" data-target=".fw_subselected" title="sub1">
				기초정보
				<div class="fw_arrow sub1">
					∧
				</div>
			</div>
			
			<div class="fw_subselected collapse in" id="sub1">
				<ul>
					<li> 선택1</li>
					<li> 선택2</li>
					<li> 선택3</li>
					<li> 선택4</li>
				</ul>
			</div>
			
			<!-- ----------2---------- -->
				<div class="fw_menu" data-toggle="collapse" data-target="#sub2" title="sub2" >
					사원관리
				<div class="fw_arrow sub2">
					∨
				</div>
			</div>
			
			<div class="fw_subsub collapse"  id="sub2">
				<ul>
					<li> 비선택1</li>
					<li> 비선택2</li>
					<li> 비선택3</li>
					<li> 비선택4</li>
				</ul>
			</div>
			
			<!-- -------------------- -->
				<div class="fw_menu" data-toggle="collapse" data-target="#sub3" title="sub3" >
					사원관리
				<div class="fw_arrow sub3" >
					∨
				</div>
			</div>
			
			<div class="fw_subsub collapse"  id="sub3">
				<ul>
					<li> 비선택1</li>
					<li> 비선택2</li>
					<li> 비선택3</li>
					<li> 비선택4</li>
				</ul>
			</div>
			
			<!-- -------------------- -->
				<div class="fw_menu" data-toggle="collapse" data-target="#sub4" title="sub4" >
					사원관리
				<div class="fw_arrow sub4">
					∨
				</div>
			</div>
			
			<div class="fw_subsub collapse"  id="sub4">
				<ul>
					<li> 비선택1</li>
					<li> 비선택2</li>
					<li> 비선택3</li>
					<li> 비선택4</li>
				</ul>
			</div>
			
			<!-- -------------------- -->
				<div class="fw_menu" data-toggle="collapse" data-target="#sub5" title="sub5" >
					사원관리
				<div class="fw_arrow sub5">
					∨
				</div>
			</div>
			
			<div class="fw_subsub collapse"  id="sub5">
				<ul>
					<li> 비선택1</li>
					<li> 비선택2</li>
					<li> 비선택3</li>
					<li> 비선택4</li>
				</ul>
			</div>
		<!-- submenu menu end -->
	</div>
	<!-- submenu end -->
	
	<div id="fw_mainwrap">
			<div id="fw_main">
				<div class="sales_title_menu">기초 정보</div>
				<div class="sales_title_menu">구매 관리</div>
				<div class="sales_title_menu">자재 관리</div>
				<div class="sales_title_menu">반품 관리</div>
				<div class="sales_title_menu">조 회</div>
			</div>
			
			<!-- main contents -->
			<div id="fw_main_contents">
				<div id="erp_jh_contents_title">
					<div id="mr_icon">icon</div>
					<p id="mr_title">제품 등록</p>
				</div>
				
				<!-- 검색 기능 -->
				<div id="erp_jh_contents_search">
					<form name="ej_frm" action="./product" method="get">
						<div class="erp_ej_search" style="max-width: 420px;">
							<div class="erp_ej_inputBox">
								<select name="kind">
									<option value="code">품목코드</option>
									<option value="name">품목명</option>
									<option value="standard">규격</option>
								</select>
							</div>
							<div class="erp_ej_inputBox">
								<input type="text" name="search">
							</div>
							<div class="erp_ej_inputBox">
								<input class="ej_search_btn btn" type="submit" value="검색">
							</div>
						</div>
					</form>					
				</div>
				<!-- 검색 기능 끝 -->
				
				
				<!-- table Start -->
				<div id="erp_jh_contents_table">
					<table class="table">
					    <thead>
					      <tr>
					        <th>품목코드</th>
					        <th>품목명</th>
					        <th>규격</th>
					        <th>가격</th>
					        <th>이미지</th>
					        <!-- 사용구분은 취소선이나 색깔로 표시 -->
					      </tr>
					    </thead>
					    <tbody>
						    <c:forEach items="${list}" var="dto">
						    	<tr>
						    		<td><a class="ej_modalOne_btn">${dto.code}</a></td>
						    		<td>${dto.name}</td>
						    		<td>${dto.standard}</td>
						    		<td>${dto.price}</td>
						    		<td>준비중</td>
						    	</tr>
						    </c:forEach>
					    </tbody>
					 </table>
					 
					 <!-- pager Start -->
					 	<div id="mr_pager" style="margin-top: 20px;">
							<c:if test="${pager.curBlock gt 1}">
								<span class="ej_list" title="${pager.startNum-1}">◀</span>
							</c:if>
							<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
								<span class="ej_list" title="${i}">${i}</span>
							</c:forEach>
							<c:if test="${pager.curBlock lt pager.totalBlock}">
								<span class="ej_list" title="${pager.lastNum+1}">▶</span>
							</c:if>
						</div>
					 <!-- pager 끝 -->
				</div>
				<!-- table 끝 -->
					
				<!-- 등록 버튼 -->
				<div id="erp_jh_contents_bottom">
					<button class="ej_right_btn btn" id="ej_write_btn">신규등록</button>
				</div>
				<!-- 등록 버튼 끝 -->
				
			</div>
			<!-- END_main contents -->
	</div>
</div>



<!-- Modal -->
<div id="ej_modal" class="modal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
      	<!-- modal header -->
        <div class="modal-header">
          <button type="button" class="close ej_file_cancel">&times;</button>
          <h4 class="modal-title">|제품 등록</h4>
        </div>
        <!-- modal header 끝-->
        
        <!-- modal contents -->
       <form action="./productWrite" method="post" id="ej_write_frm" enctype="multipart/form-data">
       <input type="hidden" name="use" value="true">
        <div class="modal-body">
        	<div class="input-group input-group_modal or_input-group_modal">
			  <span class="input-group-addon">품목코드</span>
			  <input id="code" name="code" type="text" class="form-control" readonly="readonly">
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal">
			  <span class="input-group-addon">품목명</span>
			  <input id="name" name="name" type="text" class="form-control">
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal">
			  <span class="input-group-addon">규격</span>
			  <input id="standard" name="standard" type="text" class="form-control">
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal">
			  <span class="input-group-addon">가격</span>
			  <input id="price" name="price" type="text" class="form-control">
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal_2">
			  <span class="input-group-addon">개요</span>
			  <input id="memo" name="memo" type="text" class="form-control">
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal_2">
			  <div id="dropzone">Drag & Drop Files Here</div> 
			</div>
			
			<div class="input-group input-group_modal or_input-group_modal_2">
			  <div id="result"></div>
			</div>
			
			
        </div>
        <!-- modal contents 끝-->
        
        <!-- modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-default">등록</button>
          <button type="button" class="btn btn-default ej_file_cancel" data-dismiss="modal">Close</button>
        </div>
      </form>
      	<!-- modal footer 끝-->
      </div>
    </div>
  </div>
<!-- Modal 끝 -->


<!-- Modal update/delete Start -->
<form id="ej_modalModify_frm" action="###################################" method="POST">

<div id="ej_modalOne" class="modal">

  <!-- Modal content -->
  <div id="modal-result" class="modal-content">
	  <div class="modal-header">
	    <span class="close">&times;</span>
	    <h2>거래처 정보</h2>
	  </div>
	  <div class="modal-body">
	  
	  	<!-- Modal Contents -->
	  	<div class="erp_ej_container">
	  	
	  	
		</div>
	  	<!-- Modal Contents End -->
		  
	  </div>
	  <div class="modal-footer">
	    <input type="submit" id="ej_modal_update" class="btn" value="수정">
	    <input type="button" id="ej_modal_stop" class="btn" value="사용중지">
	    <input type="button" id="ej_modal_delete" class="btn" value="삭제">
	  </div>
  </div>

</div>
</form>
<!-- Modal update/delete End -->


</body>
</html>