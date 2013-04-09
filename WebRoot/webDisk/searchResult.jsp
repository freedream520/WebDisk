 <%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网盘</title> 
<link style="text/css" rel="stylesheet" href="../webDisk/css/webDisk.css" />
<link id="artDialogSkin" href="../webDisk/skins/default.css" rel="stylesheet" type="text/css" />
</head>

<body>
<input type="hidden" id="userId" value="<%=session.getAttribute("userid")%>"/>
<input type="hidden" id="wddescjson" value="<s:property value="wddescjson"/>"/>
<input type="hidden" id="currentId"  value="<s:property value="currentId"/>"/>
<input type="hidden" id="rootid"  value="<%=session.getAttribute("root")%>"/>
	<div id="catalogs">
		
		<ul id="WDtoolBar">
			<li id="reBack"><a href="#" parentId="0">返回上一层</a></li>
			<li><a href="#" command="makeDir" id="newDir">新建文件夹</a></li>
		    <li><a href="#" command="upload" id="upload">上传</a></li>
		    <li><a href="#" command="makeDir" id="searchFile">搜索</a></li>
		    
			<!-- <li>排序</li> -->
		</ul>
		<ul id="catalogContent">

		</ul>
		 
		 
		 
		 
	</div>


<div id="detailWin">
<div class="data">
	<ul>
		<li class="name"><label>文件名：</label><span id="dataName"></span></li>
		<li class="size"><label>文件大小：</label><span>kb</span></li>
		<li class="time"><label>创建时间：</label><span></span></li>
		<li class="modifiedTime"><label>修改时间：</label><span></span></li>
		<li class="saveTime"><label>截止时间：</label><span></span></li>
		<li class="savePath"><label>保存路径：</label><span></span></li>
		<li class="saveLevel"><label>存储等级：</label><span></span></li>
	</ul>
</div>
<div id="dirType" class="typmoe10">
</div>
</div>
<div id="menu">
	<ul>
		<li><a href="#" command="openFile">打开</a></li>
		<li><a href="#" command="downloadFile">下载</a></li>
		<li><a href="#" command="reNameFile">重命名</a></li>
		<li><a href="#" command="removeFile">删除</a></li>
		<li id="hideMenu"><a href="#"  command="cancel">取消</a></li>
	</ul>
</div>
<script type="text/javascript" src="/hdfs/webDisk/js/jquery-1.3.1.min.js"></script>
<script type="text/javascript" src="/hdfs/webDisk/js/searchResult.js"></script>
<script type="text/javascript" src="/hdfs/webDisk/js/artDialog.js"></script>
	<script src="/hdfs/webDisk/js/artDialog.plugins.min.js"></script>
<script>

$(function(){

function getParentId(){
	var id = 0
	var last = $('#WDpath').find('li.filePath:last-child');
	if (last.length == 1){
		id = last.attr('fileId');
	}else{
		id = $('#currentId').val();
	}
	return id;
}
$('#newDir')
.bind(
		'click',
		function(event) {
			//获取对象的坐标，让对话框在按钮附近弹出
			var parentId = getParentId();
			var _html = '<form id ="createDirForm" action="" method="post">'
					+ '<label>目录名:</label>'
					+'<input type="text" id="dirName" name="dirName" placeholder="New Dir"  required="required"></input><br>'
					+'<i></i>'
					+ '<input type="hidden" name="parentID" id="parentID" value="'+parentId+'"></form>';
			var _x = event.clientX;
			var _y = event.clientY;
			var _this = this;
			art.dialog({
				id : 'menu_4834783',
				content : _html,
				left : _x + 10,
				top : _y + 10,
				title : '创建目录',
			ok: function() {
			    var flag=false;
				var currentId = $('#parentID').val();
				var filename = $('#dirName').val();
				var userId = $('#userId').val();
				var url = "mkDir?currentId=" + currentId
						+ "&filename=" + filename
						+ "&userId=" + userId;
				if ( filename =="")  {
					$("i").text("请输入目录名");
					$("i").css("color","red");
					}
				else	{
			  $('#catalogContent').find('li').each(function() {
			   if($(this).attr("filename")==filename) {
			   flag=true;
			   $("i").text("文件夹"+filename+"已存在！");
			   $("i").css("color","red");
			   }
			   });
			   if (flag==false) {
			   window.location.href = url;
					}}
				return false;
			}
			});
			return false;
		});
		/*----------------------------------------------------------------------------*/
		
		
						$('#searchFile').bind('click',function(event){
	
				//获取对象的坐标，让对话框在按钮附近弹出
			var parentId = getParentId();
			var _html = '<form id ="createDirForm" action="" method="post">'
						+'<label>输入文件名:</label><br><input type="text" id="searchFileName" name="searchFileName" placeholder="File Name"></input><br>'
						+'<i></i>'
						+'<input type="hidden" name="parentID" id="parentID" value="'+parentId+'"></form>';
			var _x = event.clientX;
			var _y = event.clientY;
			var _this = this;
			art.dialog({
				id:'menu_4834783',
				content:_html,
				left:_x+10,
				top:_y+10,
				title: '搜索文件',
				ok:function(){
						var currentId=$('#parentID').val();
						var filename=$('#searchFileName').val();
						var userId=$('#userId').val();
						var url="searchFile?currentId="+currentId+"&filename="+filename+"&userId="+userId;
						if ( filename =="")  {
							$("i").text("请输入文件名");
							$("i").css("color","red");
							}
						else {
						window.location.href=url;
						}
						return false;
				}
					}
				);
			return false;
		});
		
		
		
		/*----------------------------------------------------------------------------*/
		
						
						$('#upload')
								.bind(
										'click',
										function(event) {
											//获取对象的坐标，让对话框在按钮附近弹出
											var parentId = getParentId();
											var _x = event.clientX;
											var _y = event.clientY;
											var _this = this;
											var userId = $('#userId').val();
											var currentId = getParentId();
											var rootid = $('#rootid').val();
											var _html = '<form id ="uploadForm" action="uploadFile" method="post" enctype="multipart/form-data" >'
													+ '<input type="file" id="uploadFile" name="uploadFile" />'
													+'<i></i>'
													+ '</br>'
													+ '上传方式：'
													+ '<input type="radio" name="uploadType" checked value="0">普通上传</>'
													+ '<input type="radio" name="uploadType" value="1">加密上传</>'
													+ '</br>'
													+ '安全等级：'
													+ '<input type="radio" name="safelevel" checked value="1" >低</>'
													+ '<input type="radio" name="safelevel" value="2">中</>'
													+ '<input type="radio" name="safelevel" value="3">高</>'
													+ '</br>'
													+ '截止日期（YYYY-MM-DD）<input type="text" name="deadline" value="2014-01-01" onClick="jQuery(this).val(&quot;&quot;);"></>'
													+ '<input type="hidden" name="currentId" value="'+currentId+'"/>'
													+ '<input type="hidden" name="userId" value="'+userId+'" />'
													+ '<input type="hidden" name="rootid" value="'+rootid+'" />'
													+ '</form>';
													var filename=$('#uploadFile').val();
											artDialog({
												id : 'menu_4834783',
												content : _html,
												left : _x + 10,
												top : _y + 10,
												title : '上传文件',
												ok: function() {
													if (filename==undefined) {
														$("i").text("请选择文件！");
														$("i").css("color","red");
														return false;
													}
													else {
												$('#uploadForm')[0].submit();
												}
													
											}
											});
											return false;
										});

					});


</script>

</body>
</html>