<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
	if loginname <> "" then
		set t = server.createobject("adodb.recordset")
		sql = "select * from t_guser where loginname='"&request("gusername")&"'"
		t.open sql, conn, 1, 1
		username = t("username")
		loginname = t("loginname")
		password = t("password")
		depart = t("depart")
	end if
%>
<style>
table{
	border-collapse:collapse;
	overflow:auto;
	width:100%;
	height:auto;
	border:solid 1px #000;
	padding:0px;
}
td{
	background:#FFFFFF; 
	border:solid 1px #000; 
	height:22px; 
}
</style>
<base onmouseover="window.status='双击【货品编码】输入框，选择【货品资料】';return true">
<html>
<noscript><meta http-equiv="refresh" content="0;url=about:noscript"></noscript> 
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>用户添加</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<div style="padding:0 0 20px 0">
	<h6>用户档案登记</h6>
</div>
<form action="user_add_save.asp?login=<%=loginname%>" method="post">	
	<center>
	<table style="font: 14px;">
		<tr><td style=font:bold align=right>登&nbsp;录&nbsp;名：</td>
			<td>&nbsp;<%=loginname%></td>
			<td style=font:bold align=right>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
			<td>&nbsp;<%=password%></td>
		</tr>
		<tr>
			<td style=font:bold align=right>姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
			<td>&nbsp;<%=username%></td>
			<td style=font:bold align=right>部&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
			<td>&nbsp;<%=depart%></td>
		</tr>
	</table>
</form>
</body>
</html>