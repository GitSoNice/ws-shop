<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="${pageContext.request.contextPath}/css/Style1.css"
	type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index-1.css" />
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
</HEAD>
<script>
    function Calendar(){
        $('#privilegeTime').showCalendar();
    }

    function checkForm() {
        var cname = $("#cname").val();
        if (cname == null || cname == '') {
            alert("一级分类名称不能为空!");
            return false;
        }
        var discount = $("#discount").val();
        if (discount == null || discount == '') {
            alert("折扣不能为空!");
            return false;
        }
        var privilegeTime = $("#privilegeTime").val();
        if (privilegeTime == null || privilegeTime == '') {
            alert("优惠时间不能为空!");
            return false;
        }

        var pattern = /(0\.\d{1,2})$/;
        if(!pattern.test(discount)) {
            alert("折扣必须是小于一的一位小数，如0.1！");
            return false;
        }
    }
</script>
<body>
<form:form id="Form1" name="Form1"
           action="${pageContext.request.contextPath}/updateCategory" method="post"
           modelAttribute="category" enctype="multipart/form-data" onsubmit="return checkForm();">
    <table class="table">
        <tr style="text-align:center;font-size:20px;font-weight: bold;">
            <td style="font-size:22px;">编辑一级分类</td>
        </tr>
        <form:hidden path="cid"/>
        <tbody>
            <tr style="text-align:center;">
                <td style="font-size:20px;">
                    一级分类名称：<form:input type="text" path="cname" id="cname"/>
                </td>
            </tr>
            <tr style="text-align:center;">
                <td style="font-size:20px;">
                    折扣：<form:input type="text" path="discount" id="discount"/>
                </td>
             </tr>
            <tr style="text-align:center;">
                <td style="font-size:20px;">
                     优惠时间：<form:input type="text" path="privilegeTime" id="privilegeTime" onclick="Calendar();"/>
                </td>
            </tr>
            <tr>
                <td width="100%" style="text-align:center;">
					<button type="submit" id="userAction_save_do_submit" value="确定" class="btn btn-primary">
                        &#30830;&#23450;
                    </button>
                    <FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
					<button type="reset" value="重置" class="btn btn-primary">&#37325;&#32622;</button>

					<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <INPUT
					class="btn btn-primary" type="button" onclick="history.go(-1)" value="返回" />
					<span id="Label1"></span>
				</td>
			</tr>
		</table>
    </form:form>
</body>
</HTML>