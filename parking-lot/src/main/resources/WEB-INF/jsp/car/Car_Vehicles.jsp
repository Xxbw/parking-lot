<%--
  Created by IntelliJ IDEA.
  User: 14371
  Date: 2020/12/16
  Time: 8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
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
                在停车辆
            </li>
        </ol>
        <div class="tpl-portlet-components">
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
                    <div class="am-u-sm-12 am-u-md-1">
                        <div class="am-btn-group am-btn-group-xs"></div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-btn-group am-btn-group-xs">
                            <label>
                                <%--                                      <span ><font style="font-size: 17px;color: red;">111111111111</font></span>--%>
                                <span class="errorMsg" style="font-size: 16px;color: red"><%=request.getAttribute("films1")==null?"":request.getAttribute("films1")%></span>
                            </label>
                        </div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <form action="${pageContext.request.contextPath}/parked/getVehicles" method="post">
                            <input type="hidden" name="pageIndex" value="1">
                            <div class="am-input-group am-input-group-sm">
                                <input id="searchCar" type="text" name="carNumber" placeholder="请输入车牌号" class="am-form-field" value="${search.carNumber!=null?search.carNumber:''}">
                                <span class="am-input-group-btn">
                                    <button class="am-btn  am-btn-default am-btn-success tpl-am-btn-success am-icon-search" type="submit"></button>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="am-g" style="padding-left: 7%;">
                    <div class="am-u-sm-12">
                        <c:forEach items="${vehicles}" var="cv">
                            <input type="hidden" id="carId" value="${cv.carId}" >
                            <div style="width:210px;height: 340px; border:1px solid black; float:left; margin:30px 30px;text-align: center;">
                                <span style="font-size: 17px;font-weight: bold;float: left;position: absolute;color: red">${cv.parkingState==1?'即将离开':''}</span>
                                <a href="${pageContext.request.contextPath}/carInfor/getCar?carNumber=${cv.carInfor.carNumber}&type=${cv.carInfor.priceMode}" >
                                    <img src="${pageContext.request.contextPath}/project-images${cv.photo}" style="height: 260px;width: 208px;margin-bottom: 10px;border-bottom: 1px solid black">
                                    <span style="font-size: 17px;font-weight: bold;text-align: left">${cv.carInfor.carNumber}</span>
                                </a>
                                    <span style="font-size: 17px;font-weight: bold;float: right;margin-right: 30px;color: red;">
                                        <button type="button" onclick="submitHand(${cv.id})" style="border: none;background: white;float: left;">删除</button>
                                    </span>

                                <br>
                                <span style="font-size: 15px;text-align: right;color: #337ab7;font-weight: bold;">驶入:<fmt:formatDate value="${cv.entryTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="am-u-sm-12" style="margin-top: 2%;">
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
    <form  method="post" action="" class="smart-green" id="form1" enctype="multipart/form-data">
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
        <label style="height: 50px">
            <select id="state" name="parkingState">
                <option value="0" selected="selected">进入车库</option>
                <option value="1">即将离开</option>
            </select>
        </label>
        <label style="height: 50px">
            <span style="margin-top: 20px">图像文件:
                <span><a href="javascript:void(0)" onclick="uploadPhoto()">选择图片</a></span>
            </span>
            <span><input class="date-time" id="upload" accept="image/jpeg,image/jpg,image/png" type="file" name="photo" style="display: none;" onchange="uploadImg()" /></span>
        </label>
        <label id="previewImg" style="height: 200px;display: none">
            <span>
                <input type="hidden" id="imgUrl" name="imgUrl" />
                <img id="preview_photo" src="" width="200px" height="200px">
            </span>
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
<script>
    function s1() {
        var idValue = $("#newCarNumber").val();
        var entryTimeValue = $("#newEntryTime").val();
        var photo = $("#imgUrl").val();
        var parkingState = $("#state").val();

        if(idValue==""){
            $(".errorMsg1").text("车牌号不可为空");
            return false;
        }
        if(entryTimeValue==""){
            $(".errorMsg1").text("驶入时间不可为空");
            return false;
        }
        if (photo==""){
            $(".errorMsg1").text("车牌文件不可为空");
            return false;
        }
        if(parkingState==""){
            $(".errorMsg1").text("出入状态不可为空");
            return false;
        }
        var newVehicle = {
            "carId":idValue,
            "entryTime":entryTimeValue,
            "parkingState":parkingState,
            "photo":photo
        }
        setNewV(newVehicle);
    }

    function uploadImg(){
        if($("#upload").val() == "") {
            $(".errorMsg1").text("车牌文件不可为空");
            return false;
        }
        var formData = new FormData();
        formData.append('file', document.getElementById('upload').files[0]);
        $.ajax({
            url:"${pageContext.request.contextPath }/images/upload",
            type:"post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(data) {
                var imgUrl = JSON.parse(data);
                $("#preview_photo").attr("src", "${pageContext.request.contextPath }/project-images"+imgUrl.url);
                $("#imgUrl").val(imgUrl.url);
                $("#previewImg").show();
            },
            error:function(data) {
                $(".errorMsg1").text("上传失败");
            }
        });
    }
    function uploadPhoto() {
        $("#upload").click();
    }
    function setNewV(newVehicle) {
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath }/parked/setNewVehicles",
            dataType: "text",
            contentType:'application/json;charset=utf-8',
            data: JSON.stringify(newVehicle),
            success: function(data){
                var temp = "添加成功";
                $(".errorMsg1").text(data);
                if(temp == data){
                    window.location.href="${pageContext.request.contextPath }/parked/getVehicles";
                }
            }
        });
    }
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
    function del(id) {
        window.location.href="${pageContext.request.contextPath}/parked/deleteVehicle?id="+id;
    }


</script>
</html>
