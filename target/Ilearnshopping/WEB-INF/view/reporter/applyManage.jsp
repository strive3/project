<%@page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="serverPath" value="http://192.168.0.50:9080/ssmFile"></c:set>
<c:set var="mm" value="${list }"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户申报管理</title>
    <%@include file="../head.jspf" %>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/ueditor1_4_3_3/lang/zh-cn/zh-cn.js"></script>
    <style type="text/css">
        a {
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
            font-weight: bold;
            font-size: 14px;
            color: #E96129;
        }

        #searchBox {
            background: #fff8f8;
            font-size: 12px;
            width: 180px;
        }

        .datagrid-header-row td {
            background-color: #E0ECFF;
            font-weight: bold;
            height: 28px;
        }

        .datagrid-btable tr {
            height: 31px;
        }
    </style>

</head>
	<script type="text/javascript">
		$(function() {
			//datagrid初始化
			$('#dg').datagrid(
			{
				//请求数据的url
				url : '../../apply/listApply.do?item_submit=' + '${apply.item_submit}' + '&item_status=' + '${apply.item_status}' + '&item_user=' + '${apply.item_user}' + '&history_flag=' + '${apply.history_flag}',
				title : '当前列表',
				rownumbers : true,
				height : 800,
				//载入提示信息
				loadMsg : 'loading...',
				//水平自动展开，如果设置此属性，则不会有水平滚动条，演示冻结列时，该参数不要设置
				fitColumns : true,
				fit : true,
				//数据多的时候不换行
				nowrap : true,
				//设置分页
				pagination : true,
				//设置每页显示的记录数，默认是10个
				pageSize : 15,
				//每页显示记录数项目
				pageList : [ 3, 5, 10, 15, 20 ],
				sortOrder : 'asc',
				remoteSort : false,
				//指定id为标识字段，在删除，更新的时候有用，如果配置此字段，在翻页时，换页不会影响选中的项
				idField : 'item_id',
				striped : true,	//隔行换色
				//上方工具条 添加 修改 删除 刷新按钮
				toolbar : '#toolbar',
				//同列属性，但是这些列将会冻结在左侧,z大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内
				frozenColumns : [ [ 
					{field : 'ck', checkbox : true}, //复选框
				] ],
				onLoadSuccess: function (data) {
		            if (data.total != 0) {
		            	var array1 = [];
		            	var array2 = [];
		            	for(var i = 0 ; i < data.rows.length; i++) {
		            	// console.log(data.row[i].apply_time);
						//	apply_time  提交时间   history_flag  ：1：正在申报 	2：历史申报记录
		            		if(data.rows[i].apply_time != null) {
		            			//console.log(typeof data.rows[i].history_flag);
		            			array1.push(data.rows[i].apply_time);
		            			if(data.rows[i].history_flag === "2") {
		            				array2.push(data.rows[i].history_flag);
		            			}
		            		}
		            	}
	            		if(array1.length == 0) {
	            			$("#dg").datagrid("hideColumn", "apply_time");
	            			$("#dg").datagrid("hideColumn", "item_status");
	            			$("#dg").datagrid("hideColumn", "item_starttime");
	            			$("#dg").datagrid("hideColumn", "item_deadline");
	            		} else {
	            			//$("#dg").datagrid("hideColumn", "item_submit");
	            			if(array2.length != 0) {
	            				$("#dg").datagrid("hideColumn", "option");
	            				/* $("#addApply").hide(); */
	            			}
	            			$("#dg").datagrid("hideColumn", "option");
	            		}
		            } else {
		            	$.messager.alert("提示框","<font size='2'>未查询到相关数据！</font>", "info");
		            }
		        },
				columns : [ [ 
					{field : 'item_id',title : '项目编号',align : 'center',width : 100, hidden : true}, 
					{field : 'item_name',title : '项目名称',align : 'center', sortable : true, width : 100, formatter : item_nameFormatter}, 
					{field : 'item_type',title : '项目类别',align : 'center',width : 100},
					{field : 'item_user',title : '项目申报人',align : 'center', sortable : true, width : 100},
					{field : 'user_title',title : '申报人职称',align : 'center',width : 100},
					{field : 'apply_year',title : '申报年份',align : 'center', sortable : true ,width : 100},
					{field : 'user_department',title : '所属系部',align : 'center',width : 100},
					{field : 'item_starttime',title : '项目起始日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'item_deadline',title : '项目截止日期',align : 'center',width : 100, formatter : dateFormatter}, 
					{field : 'item_submit',title : '提交状态',align : 'center',width : 100, formatter : item_submitFormatter}, 
					{field : 'apply_time',title : '提交时间',align : 'center', sortable : true, width : 100, formatter : datetimeFormatter}, 
					{field : 'item_status',title : '当前状态',align : 'center',width : 100, formatter : item_statusFormatter}, 
					{field : 'item_description',title : '项目描述',align : 'center',width : 100}, 
					{field : 'history_flag',title : '时间标志',align : 'center',width : 100, hidden : true}, 
					{field : 'path',title : '项目申报书',align : 'center',width : 100,formatter : pathFormatter}, 
					{field : 'option',title : '操作',align : 'center',width : 100,formatter : optionFormatter}, 
				] ],
			});
		});
		
		function editApply() {
			//获取选中要修改的行
			var selectedRows = $("#dg").datagrid("getSelections");
			//确保被选中行只能为一行
			if (selectedRows.length != 1) {
				if(selectedRows.length  == 0) {
					$.messager.alert("系统提示","<font size='2'>请选择一条记录进行修改！</font>","info");
				} else {
					$.messager.alert("系统提示","<font size='2'>一次只能选择一条记录！</font>","warning");
				}
				return;
			}
			//获取选中行
			var row = selectedRows[0];
			row.item_starttime = dateFormatter(row.item_starttime);
			row.item_deadline = dateFormatter(row.item_deadline);
			//打开对话框并且设置标题
			$("#dlg").dialog("open").dialog("setTitle", "编辑项目申报信息");
			//将数组回显对话框中
			$("#fm").form("load", row);//会自动识别name属性，将row中对应的数据，填充到form表单对应的name属性中
			//document.getElementById("user_name").disabled = true;
			url = "${pageContext.request.contextPath }/apply/updateApply.do";
		}
		
		//定义全局url，用于修改和添加操作
		var url;
		// 添加或者修改
		function saveDialog() {
			$("#fm").form("submit", {
				url : url,
				onSubmit : function() {
					var item_description = UE.getEditor("editor").getContent();
					//alert($("#item_description").val());
					//alert(item_description);
					$("#item_description").val(item_description); //将UEditor编辑器中的内容放到隐藏域中提交到后台
					//alert($("#item_description").val());
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					var data = JSON.parse(data);
					if (data.state) {
						$.messager.alert("系统提示", "<font size='2'>恭喜您，数据保存成功！</font>", "info");
						$("#fm").form("reset");
						$("#dlg").dialog("close"); //关闭对话框
						$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
						$("#dg").datagrid("reload"); //刷新一下
					} else {
						$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
						return;
					}
				}
			});
		}
		
		function removeApply() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","<font size='2'>请您至少选择一条要删除的数据！</font>","info");
				return;
			}
			//定义选中 选中item_id数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].item_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","<font size='2'>您是否要删除选中的<font color=red>" + selectedRows.length + "</font>条数据？</font>",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/apply/deleteApplyBatchs.do",
					{
						idsStr : ids.join(","),		//将ids数组中的所有元素转换一个字符串，传到后台
					},
					function(data) {
						if (data.state) {
							$.messager.alert("系统提示","<font size='2'>恭喜您，批量删除成功！</font>","info");
							$("#dg").datagrid("unselectAll");
							$("#dg").datagrid("reload");
						} else {
							$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
						}
					},"json");
				} else {
					$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
				}
			});
		}
		
		function submitBatchs() {
			var selectedRows = $("#dg").datagrid("getSelections");
			//判断是否有选择的行
			if (selectedRows.length == 0) {
				$.messager.alert("系统提示","<font size='2'>请至少选择一项需要提交的项目申报书！</font>","info");
				return;
			}
			//定义选中 选中item_id数组
			var ids = [];
			//循环遍历将选中行的id push进入数组
			for ( var i = 0; i < selectedRows.length; i++) {
				ids.push(selectedRows[i].item_id);
			}
			//提示是否确认删除
			$.messager.confirm("系统提示","<font size='2'>您确定要提交选中的<font color=red>" + selectedRows.length + "</font>个申报项目？</font>",
			function(flag) {
				var item_submit = "2";
				changeStatusBatchs(flag, ids, item_submit);
			});
		}
		
		function changeStatusBatchs(r, ids, item_submit) {
			if (r) {
				$.post("${pageContext.request.contextPath }/apply/submitApplyBatchs.do",
				{
					idsStr : ids.join(","),
					item_submit : item_submit
				},
				function(data) {
					//console.log(data.data);
					if (data.state) {
						$.messager.alert("系统提示","<font size='2'>恭喜您，批量提交成功！</font>","info");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
					}
				},"json");
			} else {
				$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
			}
		}
		
		function reload() {
			$("#dg").datagrid("reload");
		}
		
		function print() {
			alert("print");
		}
		
		function page_excel() {
			alert("page_excel");
		}
		
		function help() {
			alert("help");
		}
		
		function search() {
			var str = $("#searchBox").val();
			var apply_year = $("#year").combobox("getValue");
			var item_type = $("#type").combobox("getValue");
			
			if(item_type === "-----请选择项目类别-----") {
				item_type = "";
			}
    		
			$("#dg").datagrid("load",{
				str : str,
				apply_year : apply_year,
				item_type : item_type,
			});
		}
		
		function clear() {
			//$("#year").combobox("clear");
			//$("#type").combobox("clear");
			$("#year").combobox("setValue", "");
			$("#type").combobox("setValue", "-----请选择项目类别-----");
			$("#searchBox").val("");
		}
	
		function closeDialog() {
			$("#fm").form("reset");
			$("#dlg").dialog("close"); //关闭对话框
			$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
		}
		
		function item_submitFormatter(value,row,index) {
			if(value == 1) {
				return "<a href='javascript:void(0);' onclick='changeSubmit("+index+")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/mini_edit.png'/><font color='red'>未提交</font></a>";
			} else if(value == 2){
				return "<font color='green'>已提交</font>";
			} else {
				return "";
			}
		}
		
		function dateFormatter(value){
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
        
        function datetimeFormatter(value){
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
	            var hour = date.getHours();
	            if(hour < 10) {
	            	hour = "0" + hour;
	            }
	            var minute = date.getMinutes();
	            if(minute < 10) {
	            	minute = "0" + minute;
	            }
	            var second = date.getSeconds();
	            if(second < 10) {
	            	second = "0" + second;
	            }
	            return year + '-' + month + '-' + day + " " + hour + ":" + minute + ":" + second;
        	}
        }
        
		function item_statusFormatter(value,row,index) {
			if(value === "1") {
				return "<font color='purple'>等待系部审核⋯⋯</font>";
			} else if(value === "2" || value ==="3") {
				return "<font color='#2D3E50'>等待专家评审⋯⋯</font>";
			} else if(value === "4"){
				return "<font color='blue'>等待最终审批⋯⋯</font>";
			} else if(value === "5"){
				return "<font color='green'>已批准立项</font>";
			} else if(value === "6"){
				return "<font color='red'>本次申报失败</font>";
			} else {
				return "";
			}
		}
		
		function optionFormatter(value, row, index) {
			var array = [];
			if(row.item_submit === "1") {
				array.push(row.item_submit);
			}
			if(array.length != 0) {
				$("#editApply").show();
				return [
		            "<a href='javascript:void(0);' onclick='modify(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",  
		            "<a href='javascript:void(0);' onclick='destory(" + row.item_id + "," + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/cancel.png'/>删除</a>",
		        ].join("");
			} else {
				$("#editApply").hide();
				$("#submitBatchs").hide();
				$("#removeApply").hide();
				return [
		            "<a href='javascript:void(0);' onclick='look(" + index + ")'><img src='${pageContext.request.contextPath }/jquery-easyui-1.3.4/themes/icons/pencil.png'/>查看详细</a>&nbsp;&nbsp;&nbsp;",  
		        ].join("");
			}
		}
		
		function pathFormatter(value, row, index) {
			var array1 = [];
			var array2 = [];
			if(row.item_submit === "1") {
				array1.push(row.item_submit);
				if(row.path) {
					array2.push(row.path);
				}
			}
			if(array1.length != 0) {
				if(array2.length != 0) {
					return [
			            "<a href='${serverPath}"+value+"' target='_blank'>"+ "查看详细" + "</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",  
			            "<a href='javascript:importItemFile("+index+");'>"+ "重新上传" + "</a>",
			        ].join("");
				}
				return "<a href='javascript:importItemFile("+index+");'>"+ "立即上传" + "</a>";
			} else {
				return "<a href='${serverPath}"+value+"' download='' target='_blank'>"+ "点击下载" + "</a>";
			}
		}
		
		function importItemFile(index) {
			$("#ifm").form("reset");
			//上传前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//打开对话框并且设置标题
			$("#importForm").dialog("open").dialog("setTitle", "上传项目申报书");
			$("#ifm").form("load", row);
		}
		
		function item_nameFormatter(value, row, index) {
			return "<a href='${serverPath}" + row.path + "' target='_blank' color='blue'>"+ value + "</a>";
		}
		
		function changeSubmit(index) {
			//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			if(row.item_submit === "1") {
				$.messager.confirm("更改提交状态", "<font size='2'>是否提交项目申报书：<font color=red>" + row.item_name + "</font>？</font>", function(r){
					var item_submit = "2";
					changeStatus(r, row.item_id, item_submit);
				});
			}
		}
		
		function changeStatus(r, item_id, item_submit) {
			if (r) {
				$.post("${pageContext.request.contextPath }/apply/submitApply.do",
				{
					item_id : item_id,
					item_submit : item_submit
				},
				function(data) {
					if (data.state) {
						$.messager.alert("系统提示","<font size='2'>恭喜您，申报书提交成功！</font>","info");
						$("#dg").datagrid("unselectAll");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
					}
				},"json");
			} else {
				$("#dg").datagrid("unselectAll");	//关闭对话框时取消所选择的行记录
			}
		}
		
		 function modify(index){
		 	//点击修改前需要将之前选中的行取消掉，然后才能得到当前选中行
			$("#dg").datagrid("unselectAll");
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//console.log(row);
			//将时间格式化，因为当前数据的实际格式为JSON序列化的形式，而并非"yyyy-MM-dd"，只有格式化之后，数据才能够正确回填到form表格
			row.item_starttime = dateFormatter(row.item_starttime);
			row.item_deadline = dateFormatter(row.item_deadline);
			if(row) {
				$("#dlg").dialog("open").dialog("setTitle", "编辑项目申报信息");
				var ue = UE.getEditor('editor');
			    ue.ready(function() {  
			        ue.setContent(row.item_description, false);  
			    });
				$("#fm").form("load", row);
				url = "${pageContext.request.contextPath }/apply/updateApply.do";
			}
		};
		
		 function destory(item_id,index) {
		 	//获取选中行的数据(用来获取user_name属性值)
			$("#dg").datagrid("selectRow",index);
			var row = $("#dg").datagrid("getSelected");
			//提示是否确认删除
			$.messager.confirm("系统提示","<font size='2'>您是否确定要删除申报项目：<font color=red>" + row.item_name + "</font>？</font>",
			function(flag) {
				if (flag) {
					$.post("${pageContext.request.contextPath }/apply/deleteApplyById.do",
					{
						item_id : item_id,
					},
					function(data) {
						if (data.state) {
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
		
		function loadType() {
			$.ajax({
			    type: "POST",
			    url: '../../itemType/list.do',
			    dataType: "json",
			    success: function(data) {
			    	//js中的方法：unshift() 方法可向数组的开头添加一个或更多元素，并返回新的长度
			    	data.unshift({itemType_id : "", itemType_name : "-----请选择项目类别-----", "itemType_createTime" : "", "item_description" : "", "item_count" : ""});
			        $('#type').combobox({
			            data: data,
			            valueField: 'itemType_name',		//相当于数据库里的字段值
			            textField: 'itemType_name',			//显示在页面下拉列表上的字段值
			            onSelect : function(record) {
							//alert("选择一个时触发");
							//console.log(record);
						},
			        });
			        //默认选中第一项
			        $('#type').combobox('select',"-----请选择项目类别-----");
			    },
			});
		}
		
		function submitFileUpload() {
			//alert(1);
			var option={
					type : 'POST',
					url : '${pageContext.request.contextPath }/upload/uploadFile.do',
					dataType : 'text',
					data : {
						fileName : 'importFile'
					},
					success:function(data){
						//把json格式的字符串转换成json对象
						var data = $.parseJSON(data);
						//数据库保存相对路径
						$("#filePath").val(data.relativePath);
					}
				};
			$("#ifm").ajaxSubmit(option);
		}
		
		function saveImportPath() {
			$("#ifm").form("submit", {
				url : '${pageContext.request.contextPath }/apply/reUploadPath.do',
				onSubmit : function() {
					return $(this).form("validate");
				}, //进行验证，通过才让提交
				success : function(data) {
					var data = JSON.parse(data);
					if (data.state) {
						alert(1);
						$.messager.alert("系统提示","<font size='2'>恭喜您，上传文件成功！</font>", "info");
						$("#ifm").form("reset");
						$("#dg").datagrid("reload");
						$("#importForm").dialog("close"); //关闭对话框
					} else {
						alert(2);
						$.messager.alert("系统提示", "<font size='2'>" + data.message + "</font>", "error");
					}
				}
			});
		}
		
		function closeImportDialog() {
			$("#ifm").form("reset");
			$("#importForm").dialog("close"); //关闭对话框
		}
		
	</script>
	
	<body onload="loadType();">
	
		<%
			Calendar calendar=Calendar.getInstance(); 
    		int year=calendar.get(Calendar.YEAR); 
			request.getSession().setAttribute("year", year);
		 %>
	
		<div id="toolbar" style="padding:5px;">
			<!-- 工具栏 -->
			<div>
				<!-- <a id="addApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_add',plain:true" href="javascript:addApply();">新增申报</a> -->
				<a id="editApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_edit',plain:true" href="javascript:editApply();">修改项目申报书</a>
				<a id="removeApply" class="easyui-linkbutton" data-options="iconCls:'icon-item_delete',plain:true" href="javascript:removeApply();">批量删除</a>
				<a id="submitBatchs" class="easyui-linkbutton" data-options="iconCls:'icon-enabled',plain:true" href="javascript:submitBatchs();">批量提交</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" href="javascript:print();">打印文档</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-page_excel',plain:true" href="javascript:page_excel();">导出Excel</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" href="javascript:help();">帮助中心</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" href="javascript:reload();">刷新页面</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- <span>按条件查询：</span>&nbsp;&nbsp; -->
				<span>&nbsp;&nbsp;申报年份：</span>
				<select id="year" name="apply_year" class="easyui-combobox" style="width:125px;">
					<option value="">----请选择年份----</option>
					<option value="${year }">${year }</option>
					<option value="${year-1 }">${year-1 }</option>
					<option value="${year-2 }">${year-2 }</option>
					<option value="${year-3 }">${year-3 }</option>
					<option value="${year-4 }">${year-4 }</option>
					<option value="${year-5 }">${year-5 }</option>
					<option value="${year-6 }">${year-6 }</option>
					<option value="${year-7 }">${year-7 }</option>
					<option value="${year-8 }">${year-8 }</option>
					<option value="${year-9 }">${year-9 }</option>
				</select>
				<span>&nbsp;&nbsp;项目类别：</span>
				<select id="type" name="item_type" class="easyu1i-combobox" style="width:150px;" >
					<!-- <option value="">-----请选择项目类别-----</option> -->
				</select>
				<span>&nbsp;&nbsp;项目名称：</span>
				<input type="text" id="searchBox" name="str" placeholder="请输入关键字" size="20" onkeydown="if(event.keyCode==13) search()"/>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true," href="javascript:search();">开始查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-clear',plain:true," href="javascript:clear();">重置查询</a>
			</div>
		</div>
		<%--显示表的信息--%>
		<table id="dg"></table>
		<%--修改使用的div--%>
		<div id="dlg" class="easyui-dialog" style="width:900px; height:600px; padding:10px 20px" data-options="iconCls:'icon-save',closed:true,collapsible:true,minimizable:true,maximizable:true,resizable:true,buttons:'#dlg-buttons'">
			<form id="fm" method="POST">
				<input type="hidden" id="item_id" name="item_id"/>
				<table cellspacing="8px">
					<tr>
						<td>项目申报人</td>
						<td>
							<span>${user.user_name }</span>&nbsp;
						</td>
					</tr>
					<tr>
						<td>职称</td>
						<td>
							<span>${user.user_title }</span>&nbsp;
						</td>
					<tr>
						<td>所属系部</td>
						<td>
							<span>${user.user_department }</span>&nbsp;
						</td>
					</tr>
					<tr>
						<td>项目名称</td>
						<td>
							<input type="text" id="item_name" name="item_name" class="easyui-validatebox" required="true">
						</td>
					</tr>
					<tr>
						<td>项目类别</td>
						<td>
							<select id="item_type" class="easyui-combobox" name="item_type" style="width:150px;" data-options="valueField:'itemType_name',textField:'itemType_name',url:'../../itemType/list.do'" > 
								<!-- <option value="">-----请选择项目类别-----</option> -->
							</select>
						</td>
					</tr>
					<tr>
						<td>起始日期</td>
						<td>
							<input type="text" id="item_starttime" name="item_starttime" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>截止日期</td>
						<td>
							<input type="text" id="item_deadline" name="item_deadline" class="easyui-datebox" required="true">&nbsp;
						</td>
					</tr>
					<tr>
						<td>项目描述</td>
						<!-- <td>
							<input type="text" id="item_description" name="item_description" class="easyui-textbox" required="true">&nbsp;
						</td> -->
						<td>
							<!-- 加载编辑器的容器 -->
							<script id="editor" type="text/plain" style="width:700px; height:150px;" />
							<input type="hidden" id="item_description"  name="item_description"> <%-- UEditor不能作为表单的一部分提交，所以用这种隐藏域的方式 --%>
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<div id="dlg-buttons">
			<div align="center">
				<a href="javascript:saveDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">保存</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭</a>
			</div>
		</div>
		
		<div id="importForm" class="easyui-dialog" style="width:400px; height:200px; padding:10px 20px" 
			data-options="iconCls:'icon-excel_upload',closed:true,buttons:'#dlg-form'">
			<form id="ifm" action="POST">
				<input type="hidden" id="itemId" name="item_id"/>
				<font color="red">*</font><span>&nbsp;请在上传前按要求认真填写项目申报书：</span><br/><br/>
				<input type='file' id='importFile' name='importFile' class="file" onchange="submitFileUpload();"/>
		        <input type='hidden' id='filePath' name='path' value='' />
			</form>
		</div>
		
		<div id="dlg-form">
			<div align="center">
				<a href="javascript:saveImportPath()" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true">确认导入</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:closeImportDialog()" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel',plain:true">关闭窗口</a>
			</div>
		</div>
		
		<%-- 实例化编辑器 --%>
		<script type="text/javascript">
			var ue = UE.getEditor('editor');
		</script>

        </body>
</html>