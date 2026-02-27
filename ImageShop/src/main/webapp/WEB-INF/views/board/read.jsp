<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T1 Member Logout</title>
<link rel="stylesheet" href="/css/boardDetail.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

<div class="container">
	<!-- 메인화면 작업 영역 시작 -->
	<h2>
		<spring:message code="board.header.read" />
	</h2>
	<form:form modelAttribute="board">
		<form:hidden path="boardNo" />
		<table>
			<tr>
				<td><spring:message code="board.title" /></td>
				<td><form:input path="title" readonly="true" /></td>
				<td><font color="red"><form:errors path="title" /></font></td>
			</tr>
			<tr>
				<td><spring:message code="board.writer" /></td>
				<td><form:input path="writer" readonly="true" /></td>
				<td><font color="red"><form:errors path="writer" /></font></td>
			</tr>
			<tr>
				<td><spring:message code="board.content" /></td>
				<td><form:textarea path="content" readonly="true" /></td>
				<td><font color="red"><form:errors path="content" /></font></td>
			</tr>
		</table>
	</form:form>

	<div>
		<sec:authentication property="principal" var="pinfo" />
		<!-- principal 정보를 pinfo 변수에 저장   -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="submit" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="submit" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<c:if test="${pinfo.username eq board.writer}">
				<button type="submit" id="btnEdit">
					<spring:message code="action.edit" />
				</button>
				<button type="submit" id="btnRemove">
					<spring:message code="action.remove" />
				</button>
			</c:if>
		</sec:authorize>

		<button type="submit" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>
	</div>

	<!-- 메인화면 작업 영역 끝 -->

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {

			var formObj = $("#board");

			$("#btnEdit").on("click", function() {
				var boardNo = $("#boardNo");
				var boardNoVal = boardNo.val();
				self.location = "/board/modify?boardNo=" + boardNoVal ;
			});
			$("#btnRemove").on("click", function() {
				formObj.attr("action", "/board/remove");
				formObj.submit();
			});
			$("#btnList").on("click", function() {
				self.location = "/board/list${pgrq.toUriString(pgrq.page)}";
			});

		});
	</script>


</body>
</html>