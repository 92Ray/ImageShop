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
<title>T1 Board Registration</title>
<link rel="stylesheet" href="/css/board/Register.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<!-- 메인화면 작업 영역 시작 -->
	<div class="main-wrapper">
		<div class="container">
			<h2>
				<spring:message code="item.header.register" />
			</h2>

			<form:form modelAttribute="item" action="register"
            enctype="multipart/form-data">
            <table>
                <tr>
                    <td><spring:message code="item.itemName" /></td>
                    <td><form:input path="itemName" /></td>
                    <td><font color="red"><form:errors path="itemName" /></font></td>
                </tr>
                <tr>
                    <td><spring:message code="item.itemPrice" /></td>
                    <td><form:input path="price" />&nbsp;원</td>
                    <td><font color="red"><form:errors path="price" /></font></td>
                </tr>
                <tr>

                    <td><spring:message code="item.itemFile" /></td>
                    <td><input type="file" name="picture" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td><spring:message code="item.itemPreviewFile" /></td>
                    <td><input type="file" name="preview" /></td>
                    <td></td>

                </tr>
                <tr>

                    <td><spring:message code="item.itemDescription" /></td>
                    <td><form:textarea path="description" /></td>
                    <td><form:errors path="description" /></td>
                </tr>
            </table>
        </form:form>

			<div>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="submit" id="btnRegister">
						<spring:message code="action.register" />
					</button>
				</sec:authorize>

				<button type="submit" id="btnList">
					<spring:message code="action.list" />
				</button>
			</div>

			<!-- 메인화면 작업 영역 끝 -->

			<jsp:include page="/WEB-INF/views/common/footer.jsp" />

			<script>
				$(document).ready(function() {
					var formObj = $("#notice");
					$("#btnRegister").on("click", function() {
						formObj.submit();
					});
					$("#btnList").on("click", function() {
						self.location = "/notice/list";
					});
				});
			</script>
			</div>
			</div>
</body>
</html>