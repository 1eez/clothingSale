<!-- #include file="../public/conn.asp" -->
<%
num1 = request.form("num1")
num2 = request.form("num2")
if num1<>"" and num2<>"" then
	sql = "update t_appinfo set num1="&num1&",num2="&num2&",autocode='"&autocode&"'"
	conn.execute sql
	Response.Write"<script>alert('����ɹ���');</script>"
end if
set t = server.createobject("adodb.recordset")
  sql = "select * from t_appinfo"
t.open sql, conn, 1, 1
num1 = t("num1")
num2 = t("num2")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>ϵͳ����</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<div id="find-title">
ϵͳ����
</div>
<hr>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form action="set_system.asp" method="post">
��ѯ��ҳ-ÿҳ��ʾ��¼������<input type="text" name="num1" value=<%=num1%> size=4><br>
����ѯ-ÿҳ��ʾ��¼������<input type="text" name="num2" value=<%=num2%> size=4>
�Զ��������ƣ�<input type="text" name="autocode" value=<%=autocode%> size=4>
<hr>
<input type="submit" value=����>
</form>
</body>
</html>