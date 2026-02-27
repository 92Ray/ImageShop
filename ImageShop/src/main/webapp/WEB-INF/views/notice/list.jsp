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
<title>Code Group List</title>
<link rel="stylesheet" href="/css/boardList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<!-- 메인화면 작업 영역 시작 -->
	<div class="container">
		<h2>
			<spring:message code="board.header.list" />
		</h2>
	

		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<a href="register"><spring:message code="action.new" /></a>
		</sec:authorize>

		<table border="1">
			<tr>
				<th align="center" width="80"><spring:message code="notice.no" /></th>
				<th align="center" width="320"><spring:message
						code="notice.title" /></th>
				<th align="center" width="180"><spring:message
						code="notice.regdate" /></th>
			</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="3"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="notice">
						<tr>
							<td align="center">${notice.noticeNo}</td>
							<td align="left"><a
								href="/notice/read?noticeNo=${notice.noticeNo}"><c:out
										value="${notice.title}" /></a></td>
							<td align="center"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${notice.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>

		<script>
			var result = "${msg}";

			if (result === "SUCCESS") {
				alert("<spring:message code='common.processSuccess' />");
			}
		</script>


		<!-- 페이징 네비게이션 추가
		<div>
			<c:if test="${empty pgrq.keyword}">
				<c:if test="${pagination.prev}">
					<a
						href="/notice/list${pagination.makeQuery(pagination.startPage - 1)}">&laquo;</a>
				</c:if>
				<c:forEach begin="${pagination.startPage }"
					end="${pagination.endPage }" var="idx">
					<c:if test="${pagination.pageRequest.page eq idx}">
						<a href="/notice/list${pagination.makeQuery(idx)}">[${idx}]</a>
					</c:if>
					<c:if test="${!(pagination.pageRequest.page eq idx)}">
						<a href="/noticelist${pagination.makeQuery(idx)}">${idx}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pagination.next && pagination.endPage > 0}">
					<a href="/notice/list${pagination.makeQuery(pagination.endPage +1)}">&raquo;</a>
				</c:if>
			</c:if>
		</div>
		
		-->

	</div>
	<!-- 메인화면 작업 영역 끝 -->

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<!-- 이벤트 처리 영역 -->
	<script>
		let result = "${msg}";
		if (result === "SUCCESS") {
			alert("<spring:message code='common.processSuccess' />");
		} else if (result === "FAIL") {
			alert("<spring:message code='common.processFail' />");
		}
	</script>
</body>
</html>