<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>
    <%@include file="../../WEB-INF/view/head.jspf"%>

    <style type="text/css">
        a:hover {
            text-decoration: underline;
            font-weight: bold;
            font-size: 14px;
            color: #E96129;
        }
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'north',title:'header',split:true,noheader:true," style="height: 20%;background:#2D3E50;">
    <div class="logo">火车购票系统</div>
    <%--引入js时间戳--%>
    <div class="timeDiv" id="timeDiv"></div>
    <c:if test="${user != null}">
        <div class="logout">您好，<font color="#95B8E7">${user.user_name }</font><font color="yellow">${user.real_name }</font>
            &nbsp;| &nbsp;<a href="javascript:logout();"><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/usericons/logout.png'/>&nbsp;退出用户</a>
        </div>
    </c:if>

</div>
<div data-options="region:'south',title:'footer',split:true,noheader:true,"
     style="height:40px;line-height:30px;text-align:center;background:#2D3E50;"><font color="#fff">火车购票系统</font></div>


<div data-options="region:'west',title:'导航菜单',split:true,iconCls:'icon-world'," style="width:175px;padding:0px;">
    <!-- <ul id="nav"></ul> -->
    <div class="easyui-accordion" data-options="fit:false,border:false,animate:true">
        <div title="首页" data-options="selected:true,iconCls:'icon-user_control'" style="padding:10px;">
            <a href="javascript:openTab('修改个人信息','${pageContext.request.contextPath }/user/admin/modifyInfo.do','icon-person')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-person'" style="width: 125px;padding:2px 8px 2px 5px;">个人信息</a>
            <a href="javascript:openPasswordModifyDialog();" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 125px;padding:2px 8px 2px 5px;">修改密码</a>
        </div>
        <div title="车票" data-options="iconCls:'icon-user_manager'" style="padding:10px">
            <a href="javascript:openTab('单程票','${pageContext.request.contextPath }/user/admin/userManage.do','icon-list_all')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-list_all'"
               style="width: 125px;padding:2px 8px 2px 5px;">单程票</a>
            <a href="javascript:openTab('往返票','${pageContext.request.contextPath }/user/admin/userManage.do?user_type=5','icon-user_list')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-user_list'"
               style="width: 125px;padding:2px 8px 2px 5px;">往返票</a>

        </div>
        <div title="个人信息" data-options="iconCls:'icon-item_control'" style="padding: 10px">
            <a href="javascript:openTab('个人信息','${pageContext.request.contextPath }/configSwitch.do','icon-switch')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">个人信息</a>
            <a href="javascript:openTab('修改密码','${pageContext.request.contextPath }/configSwitch.do','icon-switch')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">修改密码</a>

        </div>
        <div title="个人订单" data-options="iconCls:'icon-item'" style="padding:10px;">
            <a href="javascript:openTab('查询订单','${pageContext.request.contextPath }/configSwitch.do','icon-switch')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">查询订单</a>
            <a href="javascript:openTab('出行足迹','${pageContext.request.contextPath }/configSwitch.do','icon-switch')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">出行足迹</a>
            <a href="javascript:openTab('出行消费','${pageContext.request.contextPath }/configSwitch.do','icon-switch')"
               class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-switch'" style="width: 125px;padding:2px 8px 2px 5px;">出行消费</a>
        </div>

    </div>
</div>
<div data-options="region:'center'," style="overflow:hidden;">
    <div class="easyui-tabs" data-options="fit:'true',border:'false','id':'tabs'" id="tabs">
        <div title="首页" data-options="iconCls:'icon-home'">
            <div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
        </div>
    </div>
</div>
<c:if test="${user != null}">
<div id="dlg" class="easyui-dialog" style="width:400px; height:200px; padding:10px 20px"
     data-options="iconCls:'icon-modifyPassword',closed:true,buttons:'#dlg-buttons'">
    <form id="fm" method="post">
        <input type="hidden" name="user_name" value="${user.user_name }"/>
        <table cellspacing="8px">
            <tr>
                <td>用户名</td>
                <td>
                    <%-- <input type="text" id="user_name" name="user_name" value="${user.user_name }" readonly="readonly"> --%>
                    <span>${user.user_name }</span>
                </td>
            </tr>
            <tr>
                <td>新密码</td>
                <td>
                    <input type="password" id="user_pass" name="user_pass" class="easyui-validatebox"
                           required="true" style="width:200px">
                </td>
            </tr>
            <tr>
                <td>确认新密码</td>
                <td>
                    <input type="password" id="user_pass2" name="user_pass2" class="easyui-validatebox"
                           required="true" style="width:200px">
                </td>
            </tr>
        </table>
    </form>
</div>
</c:if>
<div id="dlg-buttons">
    <div align="center">
        <a href="javascript:modifyPassword()" class="easyui-linkbutton"
           data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
        <a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton"
           data-options="iconCls:'icon-cancel',plain:true">关闭</a>
    </div>
</div>
<%--引入js时间戳--%>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/currentTime.js"></script>

</body>
</html>