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
<base onmouseover="window.status='˫������Ʒ���롿�����ѡ�񡾻�Ʒ���ϡ�';return true">
<html>
<noscript><meta http-equiv="refresh" content="0;url=about:noscript"></noscript> 
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>�û����</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<div style="padding:0 0 20px 0">
	<h6>�û������Ǽ�</h6>
</div>
<form action="user_add_save.asp?login=<%=loginname%>" method="post">	
	<center>
	<table style="font: 14px;">
		<tr><td style=font:bold align=right>��&nbsp;¼&nbsp;����</td>
			<td>&nbsp;<%=loginname%></td>
			<td style=font:bold align=right>��&nbsp;&nbsp;&nbsp;&nbsp;�룺</td>
			<td>&nbsp;<%=password%></td>
		</tr>
		<tr>
			<td style=font:bold align=right>��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
			<td>&nbsp;<%=username%></td>
			<td style=font:bold align=right>��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
			<td>&nbsp;<%=depart%></td>
		</tr>
	</table>
</form>
</body>
</html>