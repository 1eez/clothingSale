<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>
<%=request("dtitle")%>设置表格显示
</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body style=padding-top:5px;>
<form action="set_table_save.asp" method="post">
<div id="inner-table-hpzl">
<table width="100%">
<tr>
<th align=center>字段名称</th>
<th align=center>显示宽度</th>
<th align=center>是否可见</th>
<th align=center>显示顺序</th>
</tr>
<%
if request("tablename")<>"" then
	set t = server.createobject("adodb.recordset")
	q = "select * from tfieldshow where tablename='"&request("tablename")&"' order by showid"
	t.open q, conn, 1, 1
	response.write "<input type=hidden name=intk value="""&t.recordcount&""">"
	response.write "<input type=hidden name=tablename value="""&request("tablename")&""">"
	for i=1 to t.recordcount
		f_checked=""
		if t("show")=True then
			f_checked="checked"
		end if
		response.write "<tr>"
		response.write "<td><input type=hidden name=tid"&i&" value="""&t("id")&"""><input type=text style=width:100%; name=name"&i&" value="""&t("name")&"""></td>"
		response.write "<td><input type=text style=width:100%; name=width"&i&" value="""&t("width")&"""></td>"
		response.write "<td><input type=checkbox name=show"&i&" value="""&t("show")&""" "&f_checked&"></td>"
		response.write "<td><input type=text style=width:100%; name=showid"&i&" value="""&t("showid")&"""></td>"
		response.write "</tr>"
		t.movenext
	next
end if
%>
</table>
</div>
<center>
	<br>
<input class=dh type="submit" value="保存">
<input class=dh type="reset" value="重置">
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</body>
</html>