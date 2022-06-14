<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>
	<c:if test="${param.totalCount<1}">
		<p style="text-align: center;">无</p>
	</c:if>
	<c:if test="${param.totalCount>0}">
	<%-- 当前页:${param.currentPageNo}
	总页:${param.totalPageCount}
	当前页小于总页吗?
	${param.currentPageNo < param.totalPageCount }
	 --%>
		<div class="page-bar">
			<ul class="page-num-ul clearfix">
				<li>共${param.totalCount }条记录&nbsp;&nbsp;
						${param.currentPageNo}/${param.totalPageCount }页&nbsp;&nbsp;
					<c:if test="${param.currentPageNo > 1}">
						<a href="javascript:page_nav(document.forms[0], 1);">首页</a>
						<a href="javascript:page_nav(document.forms[0], ${param.currentPageNo-1});">上一页</a>
					</c:if>
					<c:if test="${param.currentPageNo < param.totalPageCount }">
						<a href="javascript:page_nav(document.forms[0], ${param.currentPageNo+1 });">下一页</a>
						<a href="javascript:page_nav(document.forms[0], ${param.totalPageCount });">最后一页</a>
					</c:if> &nbsp;&nbsp;
				</li>

			</ul>
			<span class="page-go-form"><label>跳转至</label>
				<input type="text" name="inputPage" id="inputPage" class="page-key page-btn"style="margin-bottom: 7px"; />页
				<button type="button" class="page-btn"
					onClick='jump_to(document.forms[0],document.getElementById("inputPage").value)'>GO</button>
			</span>
		</div>
	</c:if>

</body>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/statics/js/rollpage.js"></script>
</html>