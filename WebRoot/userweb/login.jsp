<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>用户登录</title>
    

  </head>
  
  <body>
	<h1>登录</h1>
	<hr>
	<center>
	<s:form action="weblogin" namespace="/userweb">
		<s:textfield name="users.userName"  label="%{getText('name')}"></s:textfield>
		<s:textfield name="users.passWord" label="%{getText('password')}"></s:textfield>
		<font color="red"><s:fielderror>
		<s:param value="users.userName"></s:param>
		</s:fielderror>
		</font>
		<s:textfield name="validationCode" key="validatecode"> </s:textfield>
		<font color="red"><s:fielderror>
		<s:param value="validationCode"></s:param>
		</s:fielderror>
		</font>
		<span><s:submit key="submit"></s:submit>
		<a href="/hdfs/userweb/register.jsp">还未注册</a></span>
	</s:form>
  用户验证码：
  <img id="img" src="userweb/validate_code.action"/>
  <a href="#" onclick="refresh()">重新生成验证码</a>
  </center>
  </body>
  <script type="text/javascript">
  function refresh()
  {
   document.getElementById("img").src="userweb/validate_code.action?"+Math.random();
  }
  </script>
</html>
