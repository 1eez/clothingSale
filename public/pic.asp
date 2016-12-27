<!-- #include file="../public/conn.asp" -->
<%
goodscode = request("goodscode")
set t = server.createobject("adodb.recordset")
q = "select * from t_goods where goodsid="&goodscode&""
t.open q, conn, 1, 1
%>
<title><%=t("goodsname")%></title>
<%
if t("pic")<>"" then
	response.write "<img src=../upload/"&t("pic")&">"
else
	response.write "此物品没有图片"
end if
%>