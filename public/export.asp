<%@ codepage="936" %>
<!-- #include file="../public/public.asp" -->
<%
set conn=Server.CreateObject("ADODB.connection") 
dtitle=request("title")&setdate(date())
if dtitle="" then
	dtitle="����Excel"
end if
Response.AddHeader "Content-Disposition", "attachment;filename="&dtitle&".xls"
Response.ContentType  =  "application/vnd.ms-excel"
reportConn()
%>
<html>
<body>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<div id="tableExcel">
<%
'ѡ����¼��
exceltable = "1" 
tshow = Request("tshow")
sqlexcel = Request("sql")
pagesize=1000000
nopage="1"
ifdo=0
SetTable tshow, sqlexcel, "0"
nopage="0"
pagesize=15
%>
</div>
</body>
</html>