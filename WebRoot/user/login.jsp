<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
	<title>Hello! Admin-www.mianfeimoban.com</title>
	
	<link type="text/css" href="style.css" rel="stylesheet" />
	<link type="text/css" href="css/login.css" rel="stylesheet" />
	
	<script type='text/javascript' src='js/jquery-1.4.2.min.js'></script>	<!-- jquery library -->
	<script type='text/javascript' src='js/iphone-style-checkboxes.js'></script> <!-- iphone like checkboxes -->

	<script type='text/javascript'>
		jQuery(document).ready(function() {
			jQuery('.iphone').iphoneStyle();
		});
	</script>
	

	
	
	
	<!-- [if IE 8]>
		<script type='text/javascript' src='js/excanvas.js'></script>
		<link rel="stylesheet" href="css/loginIEfix.css" type="text/css" media="screen" />
	<[endif]--> 
 
	<!--[if IE 7]>
		<script type='text/javascript' src='js/excanvas.js'></script>
		<link rel="stylesheet" href="css/loginIEfix.css" type="text/css" media="screen" />
	<![endif]--> 
	
</head>
<body  >

	<div id="background" >
		<div id="container">
		
			<div id="logo">
				<img src="assets/hadoop.png" alt="Logo" />
			</div>
			<div id="box"> 
			
				<s:fielderror cssStyle="color:red">
		          <s:param value="users.userName"></s:param>
		        </s:fielderror>
		
				<s:form action="login" namespace="/user">
					<div class="one_half">
						<p><input name="user.username" value="用户名" class="field" onBlur="if (jQuery(this).val() == '') { jQuery(this).val('username'); }" onClick="jQuery(this).val('');" /></p>
						
						<font color="red">
					
		
		
		</font>
					</div>
					<div class="one_half last">
						<p><input type="password" name="user.password" value="password" class="field" onBlur="if (jQuery(this).val() == '') { jQuery(this).val('asdf1234'); }" onClick="jQuery(this).val('');">	</p>
						
						<p><input type="submit" value="登陆" class="login" /></p>
					</div>
					<center><a><h3> </h3></a></center>
					<center><a><h3> </h3></a></center>
					<center><a><h3> </h3></a></center>
					<center><a><h3> </h3></a></center>
					<center><a href="register.jsp" class="login" ><h3>注册新用户</h3></a></center>
					<center><a href="/hdfs/admin/login.jsp" class="login" ><h3>管理员登录</h3></a></center>
				</s:form>
				
				
		</div> 
		
		</div>
	</div>
</body>
</html>