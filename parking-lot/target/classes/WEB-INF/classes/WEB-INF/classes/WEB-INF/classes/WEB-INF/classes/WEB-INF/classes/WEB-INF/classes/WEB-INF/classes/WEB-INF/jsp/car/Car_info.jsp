<%--
  Created by IntelliJ IDEA.
  User: 14371
  Date: 2020/12/16
  Time: 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/rollpage.js"></script>
    <style>
        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=88);
        }
        .white_content {
            border-radius: 2%;
            display: none;
            position: absolute;
            top: 9%;
            left: 25%;
            width: 45%;
            height: 75%;
            padding: 20px;
            border: 3px solid black;
            background-color: white;
            z-index:1002;
            overflow: auto;
            max-height: 470px;
        }
    </style>
    <style>
        .smart-green {
            margin-left: 22%;
            /*margin-right: auto;*/
            max-width: 500px;
            /*background: #F8F8F8;*/
            padding: 30px 30px 20px 30px;
            font: 15px Arial, Helvetica, sans-serif;
            color: #666;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
        }

        .smart-green h1 > span {
            display: block;
            font-size: 11px;
            color: #FFF;
        }
        .smart-green label {
            display: block;
            margin: 0px 0px 5px;
        }
        .smart-green label > span {
            float: left;
            margin-top: 10px;
            color: #5E5E5E;
        }
        .smart-green input[type="text"],
        .smart-green textarea, .smart-green select {
            color: #555;
            height: 30px;
            line-height: 15px;
            width: 100%;
            padding: 0px 0px 0px 10px;
            margin-top: 2px;
            border: 1px solid #E5E5E5;
            background: #FBFBFB;
            outline: 0;
            -webkit-box-shadow: inset 1px 1px 2px rgba(238, 238, 238, 0.2);
            box-shadow: inset 1px 1px 2px rgba(238, 238, 238, 0.2);
            font: normal 14px/14px Arial, Helvetica, sans-serif;
        }
        .smart-green textarea {
            height: 100px;
            padding-top: 10px;
        }
        .smart-green .button {
            background-color: #9DC45F;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-border-radius: 5px;
            border: none;
            padding: 10px 25px 10px 25px;
            color: #FFF;
            text-shadow: 1px 1px 1px #949494;
        }
        .smart-green .button:hover {
            background-color: #80A24A;
        }
        .error-msg{
            color: red;
            margin-top: 10px;
        }

    </style>
    <script type="text/javascript" >
        function s1() {
            var idValue = $("#id").val();
            var carNumberValue = $("#carNumber").val();
            var stateValue = $("#state").val();
            var priceModeValue = $("#priceMode").val();
            var carNumberReg = /^([京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新][ABCDEFGHJKLMNPQRSTUVWXY][1-9DF][1-9ABCDEFGHJKLMNPQRSTUVWXYZ]\d{3}[1-9DF]|[京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新][ABCDEFGHJKLMNPQRSTUVWXY][\dABCDEFGHJKLNMxPQRSTUVWXYZ]{5})$/;

            if(idValue==""){
                $(".errorMsg1").text("编号不可为空");
                return false;
            }
            if(carNumberValue == "" || carNumberValue == null){
                $(".errorMsg1").text("车牌号码不可为空");
                return false;
            } else{
                if(!carNumberReg.test(carNumberValue)){
                    $(".errorMsg1").text("请输入正确的车牌号码");
                    return false;
                }
            }
            if(stateValue==""){
                $(".errorMsg1").text("用户状态不可为空");
                return false;
            }
            if(priceModeValue=="") {
                $(".errorMsg1").text("用户类型不可为空");
                return false;
            }
            picks1(idValue,carNumberValue,stateValue,priceModeValue);
        }

        function picks1(id,carNumber,state,priceMode){
            var car = {
                "id":id,
                "carNumber":carNumber,
                "state":state,
                "priceMode":priceMode,
                "situation":0
            }
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath }/carInfor/setNewCar",
                dataType: "text",
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(car),
                success: function(data){
                    var temp = "添加成功";
                    $(".errorMsg1").text(data);
                    if(temp == data){
                        console.log("进入");
                        window.location.href="${pageContext.request.contextPath }/carInfor/getCar";
                    }
                }
            });
        }
    </script>
    <script type="text/javascript" >
        function editFile(id){
            //获取id为 id(此id为传递过来的id值)的 tr标签的子节点
            var a=$("#tr"+id).children();
            var carNumberText = $("#tr"+id).children().siblings().eq(1).text();
            var state = $("#tr"+id).children().siblings().eq(2).text();
            var priceMode = $("#tr"+id).children().siblings().eq(3).text();
            var temp = "input2" + id;
            var tempMode = "input3" + id;
            //a[1]表示第二个单元格
            //$("#tr"+id).children().siblings().eq(1).text() 表示选中'id'为id的tr的第二个单元格，将其变为可编辑状态
            a[1].innerHTML="<td ><input type='hidden' id='oldCarNumber' name='oldCarNumber' value='"+carNumberText+"'/> <input type='text' id='input1"+id+"' value='"+ carNumberText +"'/></td>";
            a[2].innerHTML="<td ><select id='input2"+id+"' style='font-size: 16px;height: 30px;' name='state'><option value='0' >会员</option><option value='1' >拉黑</option></select></td>";
            a[3].innerHTML="<td ><select id='input3"+id+"' style='font-size: 16px;height: 30px;' name='priceMode'><option value='2' >临时</option><option value='1' >月租</option></select></td>";
            // a[4].innerHTML="<td ><input type='text' id='input4"+id+"' value='"+$("#tr"+id).children().siblings().eq(4).text()+"'/></td>";
            // a[5].innerHTML="<td ><input type='text' id='input5"+id+"' value='"+$("#tr"+id).children().siblings().eq(5).text()+"'/></td>";
            // a[6].innerHTML="<td ><input type='text' id='input6"+id+"' value='"+$("#tr"+id).children().siblings().eq(6).text()+"'/></td>";
            // a[7].innerHTML="<td ><input type='text' id='input7"+id+"' value='"+$("#tr"+id).children().siblings().eq(7).text()+"'/></td>";
            // a[8].innerHTML="<td ><input type='text' id='input8"+id+"' value='"+$("#tr"+id).children().siblings().eq(8).text()+"'/></td>";
            //点击修改后将编辑改为保存和取消
            a[6].innerHTML="" +
                "<td><div class='am-btn-toolbar'> <div class='am-btn-group am-btn-group-xs'>" +
                "<button class='am-btn am-btn-default am-btn-xs am-text-secondary' type='button' onclick='save("+id+")'> " +
                "<span class=\"am-icon-edit\"></span>保存 </button>" +
                "<button class='am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only' type='button' onclick='back()'> " +
                "<span class='am-icon-trash-o'></span>取消 </button> </div> </div></td>";

            var options = $("#"+temp).find("option");
            options.each(function (i) {
                if ($(this).text() == state) {
                    $(this).attr("selected", true);
                }
            });

            var optionsMode = $("#"+tempMode).find("option");
            optionsMode.each(function (i) {
                if ($(this).text() == priceMode) {
                    $(this).attr("selected", true);
                }
            });
        }
        //编辑保存操作
        function save(id) {//未定义是可能就是id重复了
            var oldCarNumber = $("#oldCarNumber").val();
            var carId = id;
            var carNumber = $("#input1"+id).val();
            var state = $("#input2"+id).val();
            var priceMode = $("#input3"+id).val();
            var carNumberReg = /^([京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新][ABCDEFGHJKLMNPQRSTUVWXY][1-9DF][1-9ABCDEFGHJKLMNPQRSTUVWXYZ]\d{3}[1-9DF]|[京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新][ABCDEFGHJKLMNPQRSTUVWXY][\dABCDEFGHJKLNMxPQRSTUVWXYZ]{5})$/;

            if (carNumber == "") {
                $(".errorMsg").text("车牌号码不能为空");
                return false;
            } else {
                if(!carNumberReg.test(carNumber)){
                    $(".errorMsg").text("请输入正确的车牌号码");
                    return false;
                }
            }
            if (state == "") {
                $(".errorMsg").text("车辆状态不能为空");
                return false;
            }
            if (priceMode == "") {
                $(".errorMsg").text("计费类型不能为空");
                return false;
            }

            uppick(oldCarNumber,carId,carNumber,state,priceMode);

        }

        function uppick(oldCarNumber,id,carNumber,state,priceMode){
            var oldCar = {
                "carNumber":oldCarNumber
            }
            var upCar = {
                "id":id,
                "carNumber":carNumber,
                "state":state,
                "priceMode":priceMode,
                "situation":0
            }
            var listCar = [oldCar, upCar];
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath }/carInfor/setCar",
                dataType: "text",
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(listCar),
                success: function(data){
                    var temp = "修改成功";
                    $(".errorMsg").text(data);
                    if(temp == data){
                        window.location.href="${pageContext.request.contextPath }/carInfor/getCar";
                    }
                }
            });
        }

        function back() {
            window.location.href="${pageContext.request.contextPath}/carInfor/getCar";
        }
        function del(id) {
            window.location.href="${pageContext.request.contextPath}/carInfor/deleteCar?id="+id;
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
                车辆信息管理
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
                            <form action="${pageContext.request.contextPath}/carInfor/getCar" method="post">
                                <input type="hidden" name="pageIndex" value="1">
                                <div class="am-input-group am-input-group-sm" style="float: left;width: 45%;">
                                    <label >请选择车辆类别：</label>
                                    <select  id="searchMode" style="font-size: 16px;height: 30px;" name="type">
                                        <option value="" selected="selected">选填</option>
                                        <c:forEach items="${modes}" var="types">
                                            <option value="${types.id}" ${types.id != search.priceMode?'':'selected' }>${types.mode}</option>
                                        </c:forEach>
                                    </select>
                                </div>
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
                                    <th class="table-title">车辆编号</th>
                                    <th class="table-title">车牌号码</th>
                                    <th class="table-title">类型</th>
                                    <th class="table-title">状态</th>
                                    <th class="table-title">停车记录</th>
                                    <th class="table-title">累计消费</th>
                                    <th class="table-set">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${carInfors}" var="f">
                                <tr id="tr${f.id}">
                                    <td>${f.id}</td>
                                    <td>${f.carNumber}</td>
                                    <c:choose>
                                        <c:when test="${f.state == 0}">
                                            <td>会员</td>
                                        </c:when>
                                        <c:when test="${f.state == 1}">
                                            <td>拉黑</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>异常</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${f.priceMode == 2}">
                                            <td>临时</td>
                                        </c:when>
                                        <c:when test="${f.priceMode == 1}">
                                            <td>月租</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>异常</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td><a href="${pageContext.request.contextPath}/record/getRecord?carNumber=${f.carNumber}">${f.recordCount==null?"0":f.recordCount}条</a></td>
                                    <td>${f.allPrice}元</td>
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
            <label><span>车辆编号:</span>
                <input id="id" type="text" name="id"  />
            </label>
            <label><span>车牌号码:</span>
                <input id="carNumber" type="text" name="carNumber"  />
            </label>
            <label><span>用户状态:</span>
                <select  id="state" style="font-size: 16px;height: 30px;" name="state">
                    <option value="0" selected="selected">会员</option>
                    <option value="1" >拉黑</option>

                </select>
            </label>
            <label><span>用户类型:</span><br>
                <select id="priceMode" style="font-size: 16px;" name="priceMode">
                    <c:forEach items="${modes}" var="types">
                        <option value="${types.id}">${types.mode}</option>
                    </c:forEach>
                </select>
<%--                <input id="type" type="text" name="type"  />--%>
            </label>
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
