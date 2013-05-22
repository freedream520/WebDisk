<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网盘</title>

<link type="text/css" rel="stylesheet" href="../webDisk/css/webDisk.css" />
<link id="artDialogSkin" href="../webDisk/skins/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../webDisk/css/uploadify.css" />
<link rel="stylesheet" href="../webDisk/css/jquery-ui.css" />
<script src="/hdfs/webDisk/js/jquery-1.9.1.min.js"></script>
<script src="/hdfs/webDisk/js/jquery.uploadify.min.js"></script>
<script src="/hdfs/webDisk/js/jquery-ui.js"></script>
<script src="/hdfs/webDisk/js/wd.js"></script>
<script src="/hdfs/webDisk/js/artDialog.js"></script>
<script src="/hdfs/webDisk/js/artDialog.plugins.min.js"></script>

</head>

<body>
	<input type="hidden" id="userId"
		value="<%=session.getAttribute("userid")%>" />
	<input type="hidden" id="wddescjson"
		value="<s:property value="wddescjson"/>" />
	<!--问Action值栈中的普通属性  -->
	<input type="hidden" id="currentId"
		value="<s:property value="currentId"/>" />
	<input type="hidden" id="rootid"
		value="<%=session.getAttribute("root")%>" />

	<div id="catalogs">

		<ul id="WDtoolBar">
			<li id="reBack"><a href="#" parentId="0">返回上一层</a></li>
			<li><a href="#" command="makeDir" id="newDir">新建文件夹</a></li>
			<li><a href="#" command="upload" id="upload">上传</a></li>
			<li><a href="#" command="makeDir" id="searchFile">搜索</a></li>
			<!-- <li>排序</li> -->
		</ul>

		<ul id="catalogContent">
			<!-- 用来显示网盘页面内容，由/hdfs/webDisk/js/wd.js插入html代码 -->

		</ul>
	</div>
	
<div id="oDIVUploadFile" title="文件上传，可批量" style="display:none">
 上传方式：
 <input type="radio" name="uploadType" checked value="0">普通上传
 <input type="radio" name="uploadType" value="1">加密上传
 <br>
 安全等级：
 <input type="radio" name="safelevel" checked value="1">低
 <input type="radio" name="safelevel"  value="2">中
 <input type="radio" name="safelevel"  value="3">高
 <br>
 截止日期(YYYY-MM-DD)
 <input type="text" id="deadline" name="deadline" value="2015-01-01" onClick='jQuery(this).val("");'>
 
 <input type="file" id="uploadFile" name="upload" />
 <a href="javascript:$('#uploadFile').uploadify('upload','*')">开始上传</a>
 
</div>


	<div id="detailWin">
		<div class="data">
			<ul>
				<li class="name"><label>文件名：</label><span id="dataName"></span>
				</li>
				<li class="size"><label>文件大小：</label><span>kb</span></li>
				<li class="time"><label>创建时间：</label><span></span></li>
				<li class="modifiedTime"><label>修改时间：</label><span></span></li>
				<li class="saveTime"><label>截止时间：</label><span></span></li>
				<li class="savePath"><label>保存路径：</label><span></span></li>
				<li class="saveLevel"><label>存储等级：</label><span></span></li>
			</ul>
		</div>
		<div id="dirType" class="type10"></div>
	</div>

	<div id="menu">
		<ul>
			<li><a href="#" command="openFile">打开</a></li>
			<li><a href="#" command="downloadFile">下载</a></li>
			<li><a href="#" command="reNameFile">重命名</a></li>
			<li><a href="#" command="removeFile">删除</a></li>
			<li id="hideMenu"><a href="#" command="cancel">取消</a></li>
		</ul>
	</div>



	<script>
		$(function() {

			function getParentId() {
				var id = 0;
				var last = $('#WDpath').find('li.filePath:last-child');
				if (last.length == 1) {
					id = last.attr('fileId');
				} else {
					id = $('#currentId').val();
				}
				return id;
			}
			$('#newDir')
					.bind(
							'click',
							function(event) {
								//获取对象的坐标，让对话框在按钮附近弹出
								var _html = '<form id ="createDirForm" action="" method="post">'
										+ '<label>目录名:</label>'
										+'<input type="text" id="dirName" name="dirName" placeholder="New Dir"  required="required"></input><br>'
										+'<i></i>'
										+ '<input type="hidden" name="parentID" id="parentID" value="'+parentId+'"></form>';
								var _x = event.clientX;
								var _y = event.clientY;
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
						+'<label>输入文件名:</label><br>'
						+'<input type="text" id="searchFileName" name="searchFileName" placeholder="File Name" required="required"></input><br>'
						+'<i></i>'
						+'<input type="hidden" name="parentID" id="parentID" value="'+parentId+'"></form>';
			var _x = event.clientX;
			var _y = event.clientY;
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
	    var deadline = $('#deadline').val();
	    var userId = $('#userId').val();
	    var currentId = getParentId();
	    var rootid = $('#rootid').val();
	        $('#uploadFile').uploadify({
	            'formData': {'uploadType':0,'safelevel':1,'userId':userId, 'currentId':currentId, 'rootid':rootid, 'deadline':deadline},
	            'buttonText': '选择文件',
	            'buttonClass': 'browser',
	            'removeCompleted': false,
	            'swf': '/hdfs/webDisk/swf/uploadify.swf', //进度条，Uploadify里面含有 
	            'debug': false,
	            'auto': false,
	            'height': 20,
	            'width': 70,
	            'multi': true,
	            'successTimeout': 99999,
	            'uploader': 'uploadFile', //一般处理程序 
	            'fileObjName': 'uploadFile',  //后台接受文件对象名，保持一致           
	            'onUploadStart': function(file) {  //动态更新uploadType和safelevel属性
	            var uploadType = GetRadioValue("uploadType");
	            var safelevel = GetRadioValue("safelevel");
	            //alert("uploadType: " + uploadType);
	            //alert("safelevel: " + safelevel);
	            $("#uploadFile").uploadify("settings",'formData',{'uploadType':uploadType,'safelevel':safelevel,'userId':userId, 'currentId':currentId, 'rootid':rootid, 'deadline':deadline});
	            },
	            'onQueueComplete' : function(queueData) {
          //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
    	  if (queueData.uploadsErrored > 0) {
    		  window.location.href="upload/error.jsp?errorNum="+ queueData.uploadsErrored;
    	  }else {
    	  window.location.href="/hdfs/webDisk/TestJsp.jsp";
    	  }
      },
      'onSelectError': function(file, errorCode, errorMsg){ //file选择失败后触发
          alert(errorMsg);
      },
      'onFallback': function(){ //flash报错触发
          alert("请您先安装flash控件");
      },
      'onUploadSuccess': function(file, data, response){ //上传成功后触发
          if("sizeError" == data){
              alert("文件大小不能超过10M");
          } else if("typeError" == data){
              alert("不支持的文件类型");
          }
      }
	        });
	        
	        $('#oDIVUploadFile').dialog({
	            modal: true,
	            height: 300,
	            width: 470,
	            autoOpen: false,
	            close: function (event, ui) {
	                $('a.ui-dialog-titlebar-close').show();
	            }
	        });
	        $("#upload").click(function () {
	            $("#oDIVUploadFile").dialog("open");
	        });
	    


		});
		
			    //获取单选框的值
	    function GetRadioValue(RadioName){
    var obj;    
    obj=document.getElementsByName(RadioName);
    if(obj!=null){
        var i;
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                return obj[i].value;            
            }
        }
    }
    return null;
}
	</script>

</body>
</html>