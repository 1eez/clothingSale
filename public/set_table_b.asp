<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>
���ñ����ʾ
</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body style=padding-top:5px;>
<form action="set_table_save.asp" method="post">
<div id="inner-table-hpzl">
<table width="100%">
<tr>
<th align=center>�ֶ�����</th>
<th align=center>��ʾ����</th>
<th align=center>��ʾ���</th>
</tr>
<%
if request("tablename")<>"" then
	set t = server.createobject("adodb.recordset")
	q = "select * from t_fieldshow where tablename='"&request("tablename")&"' order by showid"
	t.open q, conn, 1, 1
	response.write "<input type=hidden name=intk value="""&t.recordcount&""">"
	response.write "<input type=hidden name=tablename value="""&request("tablename")&""">"
	for i=1 to t.recordcount
		f_checked=""
		if t("show")=True then
			f_checked="checked"
		end if
		response.write "<tr>"
		response.write "<td><input type=hidden name=tid"&i&" value="""&t("id")&"""><input type=text style=border:0px; readonly name=remark"&i&" value="""&t("remark")&"""></td>"
		response.write "<td><input type=text name=name"&i&" value="""&t("name")&"""></td>"
		response.write "<td><input type=text name=width"&i&" value="""&t("width")&"""></td>"
		response.write "</tr>"
		t.movenext
	next
end if
%>
</table>
</div>
<center>
	<br>
<input class=dh type="submit" value="��������">
<input class=dh type="button" value="�ر�" onclick=window.opener=null;window.close()>
</body>
</html>