<%
connstring="DBQ=" & Server.Mappath("../data/shoplog.asp")&";DRIVER={Microsoft Access Driver (*.mdb)};"
set conn = Server.CreateObject("ADODB.connection")
conn.Open connstring
%>
<!-- #include file="../public/public.asp" -->
<%
dtitle="操作日志表"
fDo = "0"
tshow = "tInfo_Show"
cklist = request.cookies("cklist")
qxlist = request.cookies("qxlist")
begindate = trim(Request("begindate"))
enddate = trim(Request("enddate"))
kind = trim(Request("kind"))
userName = trim(Request("userName"))
if trim(request("submit"))="确定" then
  call clearLog()
end if
if begindate = "" then
	begindate = setdate(Year(now)&"-"&Month(now)&"-01")
end if
if enddate = "" then
	enddate = setdate(date())
end if
sqlwhere = sqlwhere & " and info like '%" & kind & "%' and [addtime]>=#" & begindate & "# and ([addtime]<=#"&enddate&"# or [addtime] like '%"&enddate&"%')"
if userName<>"" and userName<>"请选择" then
	'sqlwhere = sqlwhere & " and chineseName='" & userName & "'"
end if
PageSize = 20
sqlexcel = "select * from tInfo where 1=1" & sqlwhere & " order by [addtime] desc"
if request("find")="全部清除" then
	q = "delete from tInfo"
	conn.execute q
end if
'response.write sqlexcel
'response.end
'-------------------------------------------------------------------------------------------------------------
%>
<html>
<title>操作日志表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="manageLog.asp">
<div style="float:left;width:100%;height:auto;line-height:1px">
<table style="border:0px;font-size:10pt;">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
<tr>
<td style="border:0px">
操作日期：<input type="text" name="begindate" size="10" value="<%=begindate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(begindate,0);"><br>	
操作信息：<input type="text" name="kind" size="12" value="<%=kind%>">
</td>
<td style="border:0px">
~
<input type="text" name="enddate" size="10" value="<%=enddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(enddate,0);"><br>
操作人：<input type="text" name="username" size="12" value="<%=username%>">
</td>
<td style="border:0px" rowspan="2">
<input class=dh type="submit" name="find" value="查询">
<input class=dh type="submit" name="find" value="全部清除">
</td>
</form>
</tr>
</table>
</div>
</fieldset>
<fieldset style="width:auto;"><legend>操作日志表</legend>
<%
SetTable tshow, sqlexcel, fDo
%>
</fieldset>
</body>
</html>