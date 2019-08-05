<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>车票</title>
	<%@include file="../head.jspf"%>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/js/userManage.js"></script> --%>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.js"></script>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		
		a:hover{
			text-decoration:underline;
			font-weight:bold;
			font-size: 14px;
			color: #E96129;
		}
		
		#searchBox{
		    background: #fff8f8;
		    font-size: 12px;
		    width: 125px;
		}
		
		.datagrid-header-row td{
			background-color:#E0ECFF;
			font-weight:bold;
			height : 28px;
		}
		
		.datagrid-btable tr{
			height: 31px;
		}
		
	</style>
</head>
	<script type="text/javascript">
		$(function() {
		
			//扩展 dateBox
			$.extend(  
			    $.fn.datagrid.defaults.editors, {  
			        datebox: {  
			            init: function (container, options) {  
			                var input = $('<input type="text">').appendTo(container);  
			                input.datebox(options);
			                return input;  
			            },  
			            destroy: function (target) {  
			                $(target).datebox('destroy');  
			            },  
			            getValue: function (target) {  
			                return $(target).datebox('getValue');  
			            },  
			            setValue: function (target, value) {  
			                $(target).datebox('setValue', formatDatebox(value));  
			            },  
			            resize: function (target, width) {  
			                $(target).datebox('resize', width);  
			            }  
			        }
			    });
		
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : '../../user/findUserByType.do?user_type=' + '${user_type}',
				title : '当前列表',
				rownumbers : true,
				height : 600,
				//singleSelect : true,
				//载入提示信息
				loadMsg : 'loading...',
				//水平自动展开，如果设置此属性，则不会有水平滚动条，演示冻结列时，该参数不要设置
				fitColumns : true,
				//数据多的时候不换行
				nowrap : true,
				//设置分页
				pagination : true,
				//设置每页显示的记录数，默认是10个
				pageSize : 15,
				//每页显示记录数项目
				pageList : [ 3, 5, 10, 15, 20 ],
				//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
				idField : 'user_name',
				striped : true,	//隔行换色
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total == 0) {
		            	$.messager.alert("提示框","<font size='2'>未查询到相关数据！</font>", "info");
		            }
		        },
				
				columns : [ [ 
					{field : 'user_id',title : 'id编号',align : 'center',width : 100,hidden:true}, 
					{field : 'user_name',title : '用户名',align : 'center',width : 100}, 
					{field : 'user_pass',title : '密码',align : 'center',width : 100},
					{field : 'real_name',title : '姓名',align : 'center',width : 100}, 
					{field : 'user_sex',title : '性别',align : 'center',width : 100,formatter : user_sexFormatter}, 
					{field : 'user_department',title : '所属系部',align : 'center',width : 100}, 
					{field : 'user_title',title : '职称',align : 'center',width : 100}, 
					{field : 'user_mailbox',title : '电子邮箱',align : 'center',width : 100}, 
					{field : 'user_telphone',title : '联系电话',align : 'center',width : 100}, 
					{field : 'reg_date',title : '添加时间',align : 'center',width : 100, formatter : reg_dateFormatter, parser : reg_dateParser, editor : "datebox"}, 
					{field : 'user_type',title : '用户类型',align : 'center',width : 100,formatter : user_typeFormatter}, 
					{field : 'signln_valid',title : '状态',align : 'center',width : 100,formatter : signln_validFormatter}, 
					{field : 'user_remark',title : '备注',align : 'center',width : 100}, 
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		

		function reload() {
			$("#dg").datagrid("reload");
		}

		
		function searchUser() {
			var str = $("#searchBox").val();
			var user_department = $("#department").combobox("getValue");
			var user_title = $("#title").combobox("getValue");
			var signln_valid = $("#valid").combobox("getValue");
    		
			$("#dg").datagrid("load",{
				str : str,
				user_department : user_department,
				user_title : user_title,
				signln_valid : signln_valid
			});
		}
		
		function clear() {
			$("#department").combobox("setValue", "");
			$("#title").combobox("setValue", "");
			$("#valid").combobox("setValue", "");
			$("#searchBox").val("");
		}

		//定义全局url，用于修改和添加操作
		var url;

		function closeUserDialog() {
			$("#fm").form("reset");
			$("#dlg").dialog("close"); //关闭对话框
			$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
		}
		

		
		function reg_dateFormatter(value){
			if(value != null) {
	            var date = new Date(value);
	            var year = date.getFullYear();
	            var month = date.getMonth() + 1;
	            if(month < 10) {
	            	month =  "0" + month;
	            }
	            var day = date.getDate();
	            if(day < 10) {
	            	day =  "0" + day;
	            }
	            return year + '-' + month + '-' + day;
			}
        }
        
        function reg_dateParser(s) {
        	if (!s) return new Date();  
            var ss = (s.split('-'));  
            var y = parseInt(ss[0],10);  
            var m = parseInt(ss[1],10);  
            var d = parseInt(ss[2],10);  
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
                return new Date(y,m-1,d);  
            } else {  
                return new Date();  
            }  
        }

		
		function optionFormatter(value, row, index) {
			return [
	            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png' title='修改'/>修改</a>&nbsp;&nbsp;&nbsp;",  
	            "<a href='javascript:void(0);' onclick='destory(" + row.user_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png' title='删除'/>删除</a>",
	        ].join("");
		}

		
		 function modify(index){
		 	//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//将时间格式化，因为当前数据的实际格式为JSON序列化的形式，而并非"yyyy-MM-dd"，只有格式化之后，数据才能够正确回填到form表格
			row.reg_date = reg_dateFormatter(row.reg_date);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "修改用户信息");
				$("#fm").form("load", row);
				document.getElementById("user_name").disabled = true;
				url = "${pageContext.request.contextPath }/user/updateUser.do";
			}
		};
		
		 function destory(user_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//row.reg_date = reg_dateFormatter(row.reg_date);
			//提示是否确认删除
			$.messager.confirm("系统提示","<font size='2'>您是否确定要删除用户：<font color=red>" + row.user_name + "</font>？</font>",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/user/deleteUserById.do",
					{
						user_id : user_id,
					},
					function(data) {
						if (data) {
							$.messager.alert("系统提示","<font size='2'>恭喜您，数据删除成功！</font>", "info");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
						}
					},"json");
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		};
		
		function closeImportDialog() {
			$("#ifm").form("reset");
			$("#importForm").dialog("close"); //关闭对话框
		}


	</script>
	<body>
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<!-- <span>按条件查询：</span>&nbsp;&nbsp; -->
				<span>&nbsp;&nbsp;出发地：</span>
				<select id="department" name="user_department" class="easyui-combobox" style="width:100px;">
					<option value="">-----请选择-----</option>
					<option value="计算机系">计算机系</option>
					<option value="软件工程系">软件工程系</option>
					<option value="信息安全系">信息安全系</option>
					<option value="网络工程系">网络工程系</option>
				</select>
				<span>&nbsp;&nbsp;目的地：</span>
				<select id="title" name="user_title" class="easyui-combobox" style="width:100px;">
					<option value="">-----请选择-----</option>
					<option value="教授">教授</option>
					<option value="副教授">副教授</option>
					<option value="研究员">研究员</option>
					<option value="副研究员">副研究员</option>
					<option value="讲师">讲师</option>
					<option value="助教">助教</option>
				</select>
				<span>&nbsp;&nbsp;出发日：</span>
				<select id="valid" name="signln_valid" class="easyui-combobox" style="width:100px;">
					<option value="">-----请选择-----</option>
					<option value="2">正常</option>
					<option value="1">禁用</option>
				</select>
				<span>&nbsp;&nbsp;返程日：</span>
				<input type="text" id="searchBox" name="str" placeholder="请输入关键字" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:searchUser();">开始查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-clear',plain:true," href="javascript:clear();">重置查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新页面</a>
			</div>
		</div>
		
		<table id="dg"></table>
		
		<div id="dlg" class="easyui-dialog" style="width:500px; height:480px; padding:10px 20px" data-options="iconCls:'icon-guide_edit',closed:true,collapsible:true,minimizable:true,maximizable:true,resizable:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="user_id" name="user_id"/>
				<input type="hidden" name="user_name"/>
				<table cellspacing="8px">
					<tr>
						<td>用户名</td>
						<td>
							<input type="text" id="user_name" name="user_name" class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>密码</td>
						<td>
							<input type="text" id="user_pass" name="user_pass" class="easyui-numberbox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>姓名</td>
						<td>
							<input type="text" id="real_name" name="real_name" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>性别</td>
						<td>
							<input type="radio" name="user_sex" value="1" checked="checked" />男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="user_sex" value="2" />女
						</td>
					</tr>
					<tr>
						<td>所属系部</td>
						<td>
							<select id="user_department" name="user_department" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="计算机系">计算机系</option>
								<option value="软件工程系">软件工程系</option>
								<option value="信息安全系">信息安全系</option>
								<option value="网络工程系">网络工程系</option>
							</select> &nbsp;
						</td>
					</tr>
					<tr>
						<td>职称</td>
						<td>
							<select id="user_title" name="user_title" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="教授">教授</option>
								<option value="副教授">副教授</option>
								<option value="研究员">研究员</option>
								<option value="副研究员">副研究员</option>
								<option value="讲师">讲师</option>
								<option value="助教">助教</option>
							</select> &nbsp;
					</td>
					</tr>
					<tr>
						<td>电子邮箱</td>
						<td>
							<input type="text" id="user_mailbox" name="user_mailbox">&nbsp;
						</td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td>
							<input type="text" id="user_telphone" name="user_telphone">&nbsp;
						</td>
					</tr>
					<tr>
						<td>添加时间</td>
						<td>
							<input type="text" id="reg_date" name="reg_date" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>用户类型</td>
						<td>
							<select id="user_type" name="user_type" class="easyui-combobox" style="width:100px;">
								<option value="">-----请选择-----</option>
								<option value="1">系统管理员</option>
								<option value="2">项目管理员</option>
								<option value="3">系部管理员</option>
								<option value="4">评审专家</option>
								<option value="5">项目申报者</option>
							</select> &nbsp;
						</td>
					</tr>
					<tr>
						<td>状态</td>
						<td>
							<input type="radio" name="signln_valid" value="1" checked="checked" />禁用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="radio" name="signln_valid" value="2" />正常
						</td>
					</tr>
					<tr>
						<td>备注</td>
						<td>
							<input type="text" id="user_remark" name="user_remark" class="easyui-validatebox" required="true">&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<div id="dlg-buttons">
			<div align="center">
				<a href="javascript:saveUser()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeUserDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭</a>
			</div>
		</div>
		
	</body>
</html>