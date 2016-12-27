<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%

if trim(session("loginnameb"))="user" then
	Response.Write"<script>alert('试用用户没有该权限！');history.go(-1)</SCRIPT>" 
	response.end
end if
usernamea = trim(request.cookies("usernamea"))
if usernamea <> "" then
	set t = server.createobject("adodb.recordset")
	sql = "select * from tuser where username='"&usernamea&"'"
	t.open sql, conn, 1, 1
	username = t("username")
	password = t("password")
	t.close
	set t=nothing
end if
%>
<style>
table{
	border-collapse:collapse;
	overflow:auto;
	width:100%;
	height:auto;
	border:solid 1px #CECECE;
	padding:0px;
}
td{
	background:#FFFFFF; 
	border:solid 1px #CECECE; 
	height:22px; 
}
</style>
<html>
<noscript><meta http-equiv="refresh" content="0;url=about:noscript"></noscript> 
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>操作员密码修改</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<div id=divTitle>密码修改</div><hr>
<form action="set_password_save.asp" method="post">	
<center>
<table style="font-size:10pt;">
<tr><td align=right>登录名：</td>
<td colspan=3> <%=username%></td>
</tr>
<tr>
<td align=right>当前密码：</td><td colspan=3><input type="password" name=pass1></td>
</tr>
<tr>	
<td align=right>新密码：</td><td colspan=3><input type="password" name=pass2></td>
</tr>
<tr>
<td align=right>新密码验证：</td><td colspan=3><input type="password" name=pass3></td>
</tr>
</table>
<center>
<div style="padding:10px 0;width:100%;float:left">
<% if request("detail")="" then %>
<input class=dh type="submit" value="保存" name=submit>
<% end if %>
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()>
</div>
</center>
</form>
</body>
</html>