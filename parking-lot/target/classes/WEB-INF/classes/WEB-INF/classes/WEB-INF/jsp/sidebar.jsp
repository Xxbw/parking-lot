
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="tpl-left-nav tpl-left-nav-hover">
	<div class="tpl-left-nav-title">
		功能菜单
	</div>
	<div class="tpl-left-nav-list">
		<ul class="tpl-left-nav-menu">
			<li class="tpl-left-nav-item">
				<a href="${pageContext.request.contextPath}/main/home" class="nav-link active"> <i
					class="am-icon-home"></i> <span>首页</span> </a>
			</li>
			<li class="tpl-left-nav-item">
				<a href="javascript:;"
					class="nav-link tpl-left-nav-link-list active"> <i
					class="am-icon-folder"></i> <span>车辆信息</span> </a>
					<ul class="tpl-left-nav-sub-menu" style="display: block">
						<li>
							<a href="${pageContext.request.contextPath}/carInfor/getCar"> <i
								class="am-icon-angle-right"></i> <span>车辆管理</span> </a>
							<a href="${pageContext.request.contextPath}/record/getRecord"> <i
								class="am-icon-angle-right"></i> <span>停车记录</span> </a>
							<a href="${pageContext.request.contextPath}/parked/getVehicles"> <i
								class="am-icon-angle-right"></i> <span>在停车辆</span> </a>
						</li>
					</ul>
			</li>
			<li class="tpl-left-nav-item">
				<a href="javascript:;"
				   class="nav-link tpl-left-nav-link-list active"> <i
						class="am-icon-folder"></i> <span>营收统计</span> </a>
				<ul class="tpl-left-nav-sub-menu" style="display: block">
					<li>
						<a href="${pageContext.request.contextPath}/revenue/getRevenue"> <i
								class="am-icon-angle-right"></i> <span>收入统计</span> </a>
<%--						<a href="${pageContext.request.contextPath}/"> <i--%>
<%--								class="am-icon-angle-right"></i> <span>收入详情</span> </a>--%>
					</li>
				</ul>
			</li>
			<li class="tpl-left-nav-item">
				<a href="javascript:;"
				   class="nav-link tpl-left-nav-link-list active"> <i
						class="am-icon-folder"></i> <span>个人设置</span> </a>
				<ul class="tpl-left-nav-sub-menu" style="display: block">
					<li>
						<a href="${pageContext.request.contextPath }/main/personInfo"> <i
								class="am-icon-angle-right"></i> <span>个人信息修改</span> </a>
						<a href="${pageContext.request.contextPath }/main/update"> <i class="am-icon-angle-right"></i>
							<span>密码修改</span> </a>
					</li>
				</ul>
			</li>
			
		</ul>
	</div>
</div>