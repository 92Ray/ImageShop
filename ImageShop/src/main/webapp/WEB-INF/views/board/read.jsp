<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
<link rel="stylesheet" href="/css/detail.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<!-- 메인화면 작업 영역 시작 -->
	<div class="container">
		<h2>
			<spring:message code="user.header.read" />
		</h2>
		<form:form modelAttribute="board">
			<!-- 현재 페이지 번호와 페이징 크기를 숨겨진 필드 요소를 사용하여 전달한다. -->
			<input type="hidden" id="page" name="page" value="${pgrq.page}">
			<input type="hidden" id="sizePerPage" name="sizePerPage"
				value="${pgrq.sizePerPage}">
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
	</div>
	<div>

		<sec:authentication property="principal" var="pinfo" />

		<!-- 관리자전용 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button type="submit" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="submit" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
		</sec:authorize>

		<!-- 회원전용 -->
		<!-- 사용자정보를 가져온다. -->
		<sec:authentication property="principal" var="customuser" />

		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<c:if test="${customuser.getMember().userName eq board.writer}">

				<button type="button" id="btnEdit">
					<spring:message code="action.edit" />
				</button>

				<button type="button" id="btnRemove">
					<spring:message code="action.remove" />
				</button>

			</c:if>
		</sec:authorize>

		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>


	</div>


	<!-- 메인화면 작업 영역 끝 -->

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<!-- 이벤트 처리 영역 -->

	<script>
		$(document).ready(function() {
			let formObj = $("#board");

			$("#btnEdit").on("click", function() {
				let boardNo = $("#boardNo").val();
				let page = $("#page").val();
				let sizePerPage = $("#sizePerPage").val();
				self.location = "/board/modify?page=" + page+ "&sizePerPage=" + sizePerPage+ "&boardNo=" + boardNo;
			});

			$("#btnRemove").on("click", function() {
				let boardNo = $("#boardNo").val();
				let page =$("#page").val();
				let sizePerPage = $("#sizePerPage").val();
				self.location = "/board/modify?page=" + page+ "&sizePerPage=" + sizePerPage+ "&boardNo=" + boardNo;
			});

			$("#btnList").on("click", function() {
				let page =$("#page").val();
				let sizePerPage = $("#sizePerPage").val();
				self.location = "/board/modify?page=" + page+ "&sizePerPage=" + sizePerPage;
			});

		});
	</script>
</body>
</html>

