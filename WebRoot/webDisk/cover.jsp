<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>网盘</title>

<link type="text/css" rel="stylesheet" href="../webDisk/css/webDisk.css" />
<link id="artDialogSkin" href="../webDisk/skin/aero/aero.css" rel="stylesheet" type="text/css" />

</head>
  
  <body>
  <input type="hidden" id="userId"
		value="<s:property value="userId"/>" />
	<input type="hidden" id="wddescjson"
		value="<s:property value="wddescjson"/>" />
	<!--问Action值栈中的普通属性  -->
	<input type="hidden" id="currentId"
		value="<s:property value="currentId"/>" />
	<input type="hidden" id="rootid"
		value="<%=session.getAttribute("root")%>" />
<div id="catalogs">
		<ul id="WDtoolBar">
			<li id="reBack"><a href="#" parentId="0">返回</a></li>
		</ul>
    <p style="color:red">
    已存在该文件！是否覆盖?
    </p>
    <form action = "cover" method="post">
    		<input type="radio" name="coverFile" value="yes" /> 覆盖
			<input type="radio" name="coverFile" value="no" /> 取消
    		<input type="hidden" name="currentId" value="<s:property value="currentId"/>"/>
    		<input type="hidden" name="filename" value="<s:property value="filename"/>"/>
    		<input type="hidden" name="absoluteFilePath" value="<s:property value="absoluteFilePath"/>"/>
    		<input type="hidden" name="safelevel" value="<s:property value="safelevel"/>"/>
    		<input type="hidden" name="deadline " value="<s:property value="deadline "/>"/>
    		<input type="hidden" name="userId" value="<s:property value="userId"/>"/>
    		<input type="hidden" name="uploadType" value="<s:property value="uploadType"/>"/>
    		<input type="hidden" name="fileId" value="<s:property value="fileId"/>"/>
    		<input type="submit" value="确定" >
    </form>
    </div>
    <script type="text/javascript"
		src="/hdfs/webDisk/js/jquery-1.3.1.min.js"></script>

	<script type="text/javascript" src="/hdfs/webDisk/js/wd.js"></script>
  </body>
</html>
