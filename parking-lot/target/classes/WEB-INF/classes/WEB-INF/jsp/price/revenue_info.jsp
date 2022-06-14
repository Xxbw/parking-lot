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
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/SimpleChart.js"></script>
    <style>
        .container {
            margin: 20px auto;
            max-width: 960px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
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
        .info-panel {
            width: 100%;
            height: auto;
            overflow: hidden;
            margin-top: 4.25rem;
            background: #ffffff;
            border-radius: .75rem;
            position: relative;
            padding-bottom: .5rem;
            box-shadow: 0 0 10rem rgb(0 0 0 / 10%);
            margin-bottom: 3.25rem;
        }

        .info-panel ul li {
            width: 25%;
            height: 8.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            position: relative;
            padding-top: 1.9rem;
            padding-bottom: .25rem;
        }
        .info-panel ul li:first-child i {
            font-size: 1.6rem;
        }
        .info-panel ul li a {
            font-size: 1.1rem;
            color: #8a8a8a;
        }
        .info-panel ul li span {
            font-size: 1.6rem;
            font-weight: bold;
            color: #333;
            padding: .75rem 0 .25rem 0;
        }

        .info-panel ul li p {
            font-size: 1.3rem;
            color: #8a8a8a;
            display: flex;
            align-items: center;
            letter-spacing: .05rem;
            margin-bottom: 0px;
        }

        .container1 {
            width: 100%;
            padding: 0 1.75rem 0 1.75rem;
            position: relative;
            max-width: 960px;
            margin: 0 auto;
            z-index: 2;
        }

        .info-panel ul {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }

    </style>


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
                收入统计
            </li>
        </ol>
        <div class="tpl-portlet-components">
            <br>
            <div class="tpl-block">
                <div class="am-g">
                    <div class="am-u-sm-12">
                        <div class="container1">
                            <div class="info-panel">
                                <ul>
                                    <li><p><i class="iconfont icon-money-bag"></i>该日收入(元)</p> <span><c:out value="${payPrice.priceD}"></c:out></span></li>
                                    <li><p><i class="iconfont icon-money-bag"></i>该月收入(元)</p> <span><c:out value="${payPrice.priceM}"></c:out></span></li>
                                    <li><p><i class="iconfont icon-money-bag"></i>该年收入(元)</p> <span><c:out value="${payPrice.priceY}"></c:out></span></li>
                                    <li><p><i class="iconfont icon-money-bag"></i>累计收入(元)</p> <span><c:out value="${payPrice.priceA}"></c:out></span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="am-u-sm-12">
                        <div class="container">
                            <h2>年收入统计</h2>
                            <canvas id="revenue-bar" style="height: 500px; width: 1000px; background-color: white;" width="400" height="300"></canvas>

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

<div id="fade" class="black_overlay"></div>
</body>
<script type="text/javascript">
    var data = ${allYearPrice};
    console.log(data)

    const bars = new SimpleBarChart({
        id: 'revenue-bar',
        values: data,
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul','Aug', 'Sept', 'Oct', 'Nov', 'Dec'],
        scale: 100,
        backgroundColor: 'white',
        unit: '$',
        gridLineStyle: 'dashed',
        colors: ['#1baf74', '#fda145'],
        barSpacing: 30,
        xAxisFontColor: 'gray',
        xAxisLine: false,
        gridLineColor: 'gray',
        gridFontColor: 'gray',
        dashes: 40,
        cornerRadius: 8,
        labelSpace: 60,
        barHoverFontColor: 'gray'
    })

    //Listener for hover interaction
    bars.addEventListener('hover', e => {
        console.log(e.detail)
    })

    bars.draw()

</script>
</html>
