<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
if trim(request("type"))="update" then
	sql = "update tSoftInfo set "
	sql = sql & "coname='"&trim(request.form("co_short"))&"',"
	sql = sql & "contact='"&trim(request.form("co_contact"))&"',"
	sql = sql & "address='"&trim(request.form("co_address"))&"',"
	sql = sql & "phone='"&trim(request.form("co_phone"))&"',"
	sql = sql & "fax='"&trim(request.form("co_fax"))&"',"
	sql = sql & "email='"&trim(request.form("co_email"))&"'"
	conn.execute sql
	response.write "<script>alert('�޸ĳɹ���');</script>"
	manageLog "�޸Ĺ�˾�ſ���Ϣ"
end if
	
set t = server.createobject("adodb.recordset")
sql = "select * from tSoftInfo"
t.open sql, conn, 1, 1
coname = t("coname")
contact = t("contact")
address = t("address")
phone = t("phone")
fax = t("fax")
email = t("email")
t.close
set t=nothing
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
<title>��˾��Ϣ</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<div id=divTitle>��˾��Ϣ</div><hr>
<form action="co_info.asp?type=update" method="post">
<center>
<%
st1="width='20%' align=right"
st2="width='30%'"
%>
<table style="font:10pt;">
<tr><td <%=st1%>>��˾��ƣ�</td>
<td colspan=3><input type="text" name="co_short" value="<%=coname%>" size=40></td>
</tr>
<tr>
<td <%=st1%>>��˾��ַ��</td>
<td colspan=3><input type="text" name="co_address" value="<%=address%>" size=40></td>
</tr>
<tr>
<td <%=st1%>>��ϵ�ˣ�</td>
<td colspan=3><input type="text" name="co_contact" value="<%=contact%>" size=24></td>
</tr>
<tr>
<td <%=st1%>>�����ʼ���</td>
<td colspan=3><input type="text" name="co_email" value="<%=email%>" size=24></td>
</tr>
<tr>
<td <%=st1%>>��ϵ�绰��</td>
<td colspan=3><input type="text" name="co_phone" value="<%=phone%>" size=24></td>
</tr><tr>
<td <%=st1%>>��˾���棺</td>
<td colspan=3><input type="text" name="co_fax" value="<%=fax%>" size=24</td>
</tr>
</table>
<center>
<input type="submit" value="����">
<input class=dh type="reset" value="�ر�" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>