<%--
  Created by IntelliJ IDEA.
  User: 14371
  Date: 2020/12/16
  Time: 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>后台管理系统</title>
    <link rel="icon" type="image/png"
          href="${pageContext.request.contextPath}/statics/assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed"
          href="${pageContext.request.contextPath}/statics/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/statics/assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/assets/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/assets/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/assets/css/frame.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/rollpage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/setnew.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/rollpage.js"></script>

    <script type="text/javascript" >
        function s1() {
            var idValue = $("#newCarNumber").val();
            var entryTimeValue = $("#newEntryTime").val();
            var departureTimeValue = $("#newDepartureTime").val();

            if(idValue==""){
                $(".errorMsg1").text("车牌号不可为空");
                return false;
            }
            if(entryTimeValue==""){
                $(".errorMsg1").text("驶入时间不可为空");
                return false;
            }
            if(departureTimeValue != "") {
                var result = getTrueTime(entryTimeValue,departureTimeValue);
                if (result > 1){
                    $(".errorMsg").text("驶出时间不能早于驶入时间");
                    return false;
                }
            }
            picks1(idValue,entryTimeValue,departureTimeValue);
        }

        function picks1(carId,entryTime,departureTime){
            var newRecord = {
                "carId":carId,
                "entryTime":entryTime,
                "departureTime":departureTime,
            }
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath }/record/setNewRecord",
                dataType: "text",
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(newRecord),
                success: function(data){
                    var temp = "添加成功";
                    $(".errorMsg1").text(data);
                    if(temp == data){
                        window.location.href="${pageContext.request.contextPath }/record/getRecord";
                    }
                }
            });
        }

        function editFile(id){
            //获取id为 id(此id为传递过来的id值)的 tr标签的子节点
            var a=$("#tr"+id).children();
            var carId = $("#carId").val();
            var carNumberText = $("#tr"+id).children().siblings().eq(1).text();
            var entryTime = new Date();
            entryTime = $("#tr"+id).children().siblings().eq(2).text();
            var departureTime = new Date();
            departureTime = $("#tr"+id).children().siblings().eq(3).text();
            var tempCarId = "input1" + id;
            var temp = "input2" + id;
            var tempDep = "input3" + id;
            //a[1]表示第二个单元格
            //$("#tr"+id).children().siblings().eq(1).text() 表示选中'id'为id的tr的第二个单元格，将其变为可编辑状态
            a[1].innerHTML="<td ><input type='hidden' id='input0"+id+"' name='carId' value='"+carId+"'/> " +
                "<select id='input1"+id+"' style='font-size: 16px;height: 30px;' name='carNumber'>" +
                "<c:forEach items='${carInforList}' var='types'><option value='${types.id}' >${types.carNumber}</option></c:forEach>" +
                "</select>";
            a[2].innerHTML="<td ><input type='datetime-local' id='input2"+id+"' /> </td>";
            a[3].innerHTML="<td ><input type='datetime-local' id='input3"+id+"' /></td>";
            //点击修改后将编辑改为保存和取消
            a[5].innerHTML="" +
                "<td><div class='am-btn-toolbar'> <div class='am-btn-group am-btn-group-xs'>" +
                "<button class='am-btn am-btn-default am-btn-xs am-text-secondary' type='button' onclick='save("+id+")'> " +
                "<span class=\"am-icon-edit\"></span>保存 </button>" +
                "<button class='am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only' type='button' onclick='back()'> " +
                "<span class='am-icon-trash-o'></span>取消 </button> </div> </div></td>";

            $("#"+temp).val(entryTime.replace(" ","T"));
            $("#"+tempDep).val(departureTime.replace(" ","T"));

            var options = $("#"+tempCarId).find("option");
            options.each(function (i) {
                if ($(this).val() == carId) {
                    $(this).attr("selected", true);
                }
            });
        }
        //编辑保存操作
        function save(id) {//未定义是可能就是id重复了
            var carId = $("#input1"+id).val();
            var carNumber = $("#input1"+id).text();
            var entryTime = $("#input2"+id).val();
            var departureTime = $("#input3"+id).val();

            if (carId == "") {
                $(".errorMsg").text("车牌号码不能为空");
                return false;
            }
            if (entryTime == "") {
                $(".errorMsg").text("驶入时间不能为空");
                return false;
            }
            if (departureTime != "") {
                var result = getTrueTime(entryTime,departureTime);
                if (result > 1){
                    $(".errorMsg").text("驶出时间不能早于驶入时间");
                    return false;
                }
            }

            uppick(id,carId,entryTime,departureTime);

        }

        function uppick(id,carId,entryTime,departureTime){
            var record = {
                "id":id,
                "carId":carId,
                "entryTime":entryTime,
                "departureTime":departureTime,
                "price":0
            }
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath }/record/setRecord",
                dataType: "text",
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(record),
                success: function(data){
                    var temp = "修改成功";
                    $(".errorMsg").text(data);
                    if(temp == data){
                        window.location.href="${pageContext.request.contextPath }/record/getRecord";
                    }
                }
            });
        }

        function getTrueTime(date1,date2){
            var oDate1 = new Date(date1);
            var oDate2 = new Date(date2);
            if(oDate1.getTime() > oDate2.getTime()){
                return 2;
            } else  if(oDate1.getTime() < oDate2.getTime()){
                return 1;
            }else if(oDate1.getTime() == oDate2.getTime()){
                return 0;
            }
        }

        function back() {
            window.location.href="${pageContext.request.contextPath}/record/getRecord";
        }
        function del(id) {
            window.location.href="${pageContext.request.contextPath}/record/deleteRecord?id="+id;
        }

    </script>
    <script type="text/javascript">

        $( function() {
            var choose = function(id) {
                return document.getElementById(id);
            }
            //自定柳部分
            window.confirm = function(message, yesCallBack, noCallBack) {

                var message = message || "确定?";

                choose("dialog-message").innerHTML = message;
                // 显示遮罩和对话框
                choose("dialog-hide").className = "wrap-dialog";
                // 确定按钮

                choose("dialog").onclick = function(e) {
                    if (e.target.className == "dialog-btn") {
                        choose("dialog-hide").className = "wrap-dialog dialog-hide";
                        yesCallBack();
                    } else if (e.target.className == "dialog-btn dialog-ml50") {
                        choose("dialog-hide").className = "wrap-dialog dialog-hide";
                        noCallBack();
                    }
                };
                // 取消按钮
                choose("closeBtn").onclick = function() {
                    choose("dialog-hide").style.display = "none";
                }
            }
        })
        function submitHand(id) {
            function submitBtn() {
                // btn();
                del(id);
            }

            function closeBtn() {
                window.history.go(0);
            }
            confirm("确定要删除吗？", submitBtn, closeBtn);
        }

    </script>
</head>

<body data-type="generalComponents">

<%@include file="../top.jsp"%>

<div class="tpl-page-container tpl-page-header-fixed">
    <!--左边start-->
    <%@include file="../sidebar.jsp"%>
    <!--左边end-->
    <div class="tpl-content-wrapper">
        <!--右边内容start-->
        <ol class="am-breadcrumb">
            <li>
                <a href="${pageContext.request.contextPath}/main/home" class="am-icon-home">首页</a>
            </li>
            <li class="am-active">
                停车记录
            </li>
        </ol>
        <div class="tpl-portlet-components">
            <br>
            <div class="tpl-block">
                <div class="am-g">
                    <div class="am-u-sm-12 am-u-md-1">
                        <div class="am-btn-group am-btn-group-xs">
                            <button type="button"
                                    class="am-btn am-btn-default am-btn-success"  onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
                                <span class="am-icon-plus"></span> 新增
                            </button>
                        </div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-btn-group am-btn-group-xs">
                            <label>
                                <%--                                      <span ><font style="font-size: 17px;color: red;">111111111111</font></span>--%>
                                <span class="errorMsg" style="font-size: 16px;color: red"><%=request.getAttribute("films1")==null?"":request.getAttribute("films1")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3" style="width: 35%;">
                        <form action="${pageContext.request.contextPath}/record/getRecord" method="post">
                            <input type="hidden" name="pageIndex" value="1">
                            <div class="am-input-group am-input-group-sm" style="float: left;width: 55%;">
                                <input id="searchCar" type="text" name="carNumber" placeholder="请输入车牌号" class="am-form-field" value="${search.carNumber!=null?search.carNumber:''}">
                                <span class="am-input-group-btn">
                                        <button class="am-btn  am-btn-default am-btn-success tpl-am-btn-success am-icon-search" type="submit"></button> </span>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="am-g">
                    <div class="am-u-sm-12">
                        <table class="am-table am-table-striped am-table-hover table-main" style="border-bottom: 1px solid #dddddd;padding-bottom: 0px;">
                            <thead>
                            <tr>
                                <th class="table-title">记录编号</th>
                                <th class="table-title">车牌号码</th>
                                <th class="table-title">驶入时间</th>
                                <th class="table-title">驶出时间</th>
                                <th class="table-title">收费金额</th>
                                <th class="table-set">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${parkingRecords}" var="f">
                                <input type="hidden" id="carId" value="${f.carId}" >
                                <tr id="tr${f.id}">
                                    <td>${f.id}</td>
                                    <td>${f.carInfor.carNumber}</td>
                                    <td><fmt:formatDate value="${f.entryTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td><fmt:formatDate value="${f.departureTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${f.price}元</td>
                                    <td>
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <button class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                                        type="button" onclick="editFile(${f.id})">
                                                    <span class="am-icon-edit"></span> 编辑
                                                </button>
                                                <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                        type="button" onclick="submitHand(${f.id})">
                                                    <span class="am-icon-trash-o"></span> 删除
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!--行end-->
                            </tbody>
                        </table>
                    </div>
                    <div class="am-u-sm-12">
                        <div class="pz_fy">

                            <input type="hidden" id="totalPageCount"
                                   value="${pages.totalPageCount}" />
                            <c:import url="../common/rollpage.jsp">
                                <c:param name="totalCount" value="${pages.totalCount}" />
                                <c:param name="currentPageNo" value="${pages.currentPageNo}" />
                                <c:param name="totalPageCount" value="${pages.totalPageCount}" />
                            </c:import>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="wrap-dialog dialog-hide" id="dialog-hide">
    <div class="dialog" id="dialog">
        <a class="closeBtn" id="closeBtn">X</a>
        <div class="dialog-header">
            <span class="dialog-title">提示</span>
        </div>
        <div class="dialog-body">
            <span class="dialog-message" id="dialog-message">确定要修改吗？</span>
        </div>
        <div class="dialog-footer">
            <input type="button" class="dialog-btn" id="dialog-confirm" value="确定">
            <input type="button" class="dialog-btn dialog-ml50" id="dialog-cancel" value="取消">
        </div>
    </div>
</div>

<div id="light" class="white_content">
    <form  method="post" action="" class="smart-green" id="f1" enctype="multipart/form-data">
        <label><span>车牌号码:</span>
            <select  id="newCarNumber" style="font-size: 16px;" name="carId">
                <c:forEach items="${carInforList}" var="types">
                    <option value="${types.id}" >${types.carNumber}</option>
                </c:forEach>
            </select>
        </label>
        <label style="height: 50px"><span style="margin-top: 20px">驶入时间:
            <input class="date-time" id="newEntryTime" type="datetime-local" name="entryTime" style="" /></span>
        </label>
        <label style="height: 50px"><span style="margin-top: 20px">驶出时间:
            <input class="date-time" id="newDepartureTime" type="datetime-local" name="departureTime"  /></span>
        </label>
<%--        <label><span>本次收入:</span>--%>
<%--            <input id="type" type="text" name="price" style="font-size: 16px;height: 30px"  />--%>
<%--        </label>--%>
        <label><span class="errorMsg1" style="color: red"></span></label>
        <br>
        <label></label>
        <label style="margin-top: 30px;"><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="button" class="button" id="btn" onclick="s1()" value="确定" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" class="button" value="关闭" onclick= "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"/>
        </label>

    </form>

</div>
<div id="fade" class="black_overlay"></div>
</body>

</html>
