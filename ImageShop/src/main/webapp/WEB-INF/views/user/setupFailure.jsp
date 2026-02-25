<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
<link rel="stylesheet" href="/css/success.css">

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />
	<div class="success">
		<h2>
			<spring:message code="common.joinMemberSuccess"
				arguments="${userName}" />
		</h2>
		<a href="/auth/login" class="login"><spring:message code="action.login" /></a>
		<a href="/" class="main"><spring:message code="header.home" /></a>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>