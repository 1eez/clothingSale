<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
	gusername = trim(request.querystring("gusername"))
	if gusername <> "" then
		set t = server.createobject("adodb.recordset")
		sql = "select * from t_guser where gusername='"&gusername&"'"
		t.open sql, conn, 1, 1
		gusername = t("gusername")
		memo = t("memo")
		depart = t("depart")
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
<title>用户添加</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<div style="padding:0 0 20px 0">
	<center><h2>用户权限组登记</h2></center>
</div>
<form action="guser_add_save.asp?login=<%=loginname%>" method="post">	
	<center>
	<table style="font:bold 14px;">
		<tr><td align=right>权限组名：</td>
			<td><input type="text" name="gusername" value="<%=gusername%>"></td>
			<td align=right>部&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
			<td><input type="text" name="depart" size="14" value="<%=depart%>">
				<img style="cursor:hand" src="../images/f.gif" onclick=openwin("../public/mtreehp.asp?table=depart",340,300)>
				<input type="hidden" name="departcode">
			</td>
		</tr>
		<tr>
			<td align=right>备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
			<td colspan=3><input type="text" name="memo" value="<%=memo%>" size=80></td>
		</tr>

		<tr align=center>
			<td colspan=4><input type="submit" value="保存">
			<input type="button" value="取消"></td>
		</tr>
	</table>
</form>
</body>
</html>