<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<!-- #include file="../public/public.asp" --> 
<%
set conn=Server.CreateObject("ADODB.connection") 
dtitle=request("title")
if dtitle="" then
	dtitle="软件打印"
end if
tshow = Request("tshow")
sqlexcel = Request("sql")
reportConn()
set t = server.createobject("adodb.recordset")
sql = "select * from t_coinfo"
t.open sql, conn, 1, 1
co = t("co_long")
t.close
%>
<style media=print>
.Noprint{display:none;}
.PageNext{page-break-after: always;}
</style>
<html>
<title>单据打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body>
<div class="Noprint" style="line-height:20px;padding-top:5px;">
<OBJECT id=WebBrowser  classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2  height=0  width=0>
</OBJECT>
<input class=dh type=button value=打印单据 onclick=document.all.WebBrowser.ExecWB(6,1)>
<input class=dh type=button value=页面设置 onclick=document.all.WebBrowser.ExecWB(8,1)>
<input class=dh type=button value=打印预览 onclick=document.all.WebBrowser.ExecWB(7,1)>
<input class=dh type="reset" value="关闭" onclick=window.opener=null;window.close()><br>
您可以根据纸张大小，在【系统设置】-【选项设置】中设置每页显示记录数。<br>
首次打印时，请点击【页面设置】按钮，设置页眉、页脚为空，页边距全部设置为零已达到最佳打印效果。
<hr align="center" width="100%" size="1" noshade>
</div>
<center><label class="14 b"><%=co%></label><br><label class="12 b"><%=dtitle%></label></center><br>
<%
exceltable = "1" 
fdiv = "print-table"
pagesize=1000000
dosumsql = mid(sqlexcel, instr(sqlexcel, "from"), instr(sqlexcel, "order by")-instr(sqlexcel,"from"))
SetTable tshow, sqlexcel, "0"
pagesize=15
%>
<br>
<label class="10">打印时间：<%=now()%></label>
</body>
</html>