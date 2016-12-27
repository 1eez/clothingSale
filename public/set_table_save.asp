<!-- #include file="../public/conn.asp" -->
<%
intk=request.form("intk")
tablename=request.form("tablename")
for i = 1 to intk
	if request.form("show"&i)<>"" then
		show="1"	
	else
		show="0"
	end if
	q = "update tfieldshow set "
	q = q&"name='"&request.form("name"&i)&"',"
	q = q&"width='"&request.form("width"&i)&"',"
	q = q&"showid='"&request.form("showid"&i)&"',"
	q = q&"show="&show&" where id="&request.form("tid"&i)
	conn.execute q
next
q = "select * from tfieldshow where tablename='"&tablename&"' order by showid"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
for i = 0 to t.recordcount - 1
	q = "update tfieldshow set "
	q = q&"showid='"&i&"' "
	q = q&"where id="&t("id")
	conn.execute q
	t.movenext
next
Response.Write"<script>history.go(-1);</SCRIPT>" 
%>