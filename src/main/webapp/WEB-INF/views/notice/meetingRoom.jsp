<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set
	value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"
	var="url" />
<c:import url="${url}/resources/temp/ref.jsp" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
.modal-content {
	width: 400px;
	height: 250px;
}

.modal-title {
	font-size: 25px;
}

.modal-table	{
	max-width: 100%;
	width: 100%;
}

.choice_date	{
	margin-bottom: 3%;
}

.choice_meeting	{
	margin-bottom: 3%;
	display: none;
}

.choice_time	{
	display: none;
}

.choice_meeting select	{
	width: 39%;
	height: 9%;
}

.choice_time select	{
	width: 30%;
}
</style>

<script type="text/javascript">
	$(function(){
		$(".choice_date").on("change", function(){
			$(".choice_meeting").css("display", "block");
		});
		$(".choice_meeting").on("change", function(){
			$(".choice_time").css("display", "block");
		});
	});
</script>
</head>
<body>
	<button type="button" class="btn btn-info btn-lg" data-toggle="modal"
		data-target="#myModal">회의실 예약</button>
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<span class="modal-title">회의실 예약</span>
				</div>
				<div class="modal-body">
					<div class="choice_date">
						날짜 선택 : &nbsp;&nbsp;&nbsp;&nbsp;<input type="date" id="date" name="date">
					</div>
					<div class="choice_meeting">
						회의실 선택 : 
						<select>
							<option>A 회의실</option>
							<option>B 회의실</option>
							<option>C 회의실</option>
							<option>D 회의실</option>
						</select>
					</div>
					<div class="choice_time">
						시간 선택 : &nbsp;&nbsp;&nbsp;
						<select>
							<option>09:00</option>
							<option>10:00</option>
							<option>11:00</option>
							<option>12:00</option>
							<option>13:00</option>
							<option>14:00</option>
							<option>15:00</option>
							<option>16:00</option>
							<option>17:00</option>
						</select>
						~
						<select>
							<option>10:00</option>
							<option>11:00</option>
							<option>12:00</option>
							<option>13:00</option>
							<option>14:00</option>
							<option>15:00</option>
							<option>16:00</option>
							<option>17:00</option>
							<option>18:00</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default">예약</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>