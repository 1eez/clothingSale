<%
connstring="DBQ=" & Server.Mappath("../data/shoplog.asp")&";DRIVER={Microsoft Access Driver (*.mdb)};"
set conn = Server.CreateObject("ADODB.connection")
conn.Open connstring
%>
<!-- #include file="../public/public.asp" -->
<%
dtitle="������־��"
fDo = "0"
tshow = "tInfo_Show"
cklist = request.cookies("cklist")
qxlist = request.cookies("qxlist")
begindate = trim(Request("begindate"))
enddate = trim(Request("enddate"))
kind = trim(Request("kind"))
userName = trim(Request("userName"))
if trim(request("submit"))="ȷ��" then
  call clearLog()
end if
if begindate = "" then
	begindate = setdate(Year(now)&"-"&Month(now)&"-01")
end if
if enddate = "" then
	enddate = setdate(date())
end if
sqlwhere = sqlwhere & " and info like '%" & kind & "%' and [addtime]>=#" & begindate & "# and ([addtime]<=#"&enddate&"# or [addtime] like '%"&enddate&"%')"
if userName<>"" and userName<>"��ѡ��" then
	'sqlwhere = sqlwhere & " and chineseName='" & userName & "'"
end if
PageSize = 20
sqlexcel = "select * from tInfo where 1=1" & sqlwhere & " order by [addtime] desc"
if request("find")="ȫ�����" then
	q = "delete from tInfo"
	conn.execute q
end if
'response.write sqlexcel
'response.end
'-------------------------------------------------------------------------------------------------------------
%>
<html>
<title>������־��</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<fieldset style="width:auto;"><legend>��ѯ��Ϣ</legend>
<form name="form" method="get" action="manageLog.asp">
<div style="float:left;width:100%;height:auto;line-height:1px">
<table style="border:0px;font-size:10pt;">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
<tr>
<td style="border:0px">
�������ڣ�<input type="text" name="begindate" size="10" value="<%=begindate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(begindate,0);"><br>	
������Ϣ��<input type="text" name="kind" size="12" value="<%=kind%>">
</td>
<td style="border:0px">
~
<input type="text" name="enddate" size="10" value="<%=enddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(enddate,0);"><br>
�����ˣ�<input type="text" name="username" size="12" value="<%=username%>">
</td>
<td style="border:0px" rowspan="2">
<input class=dh type="submit" name="find" value="��ѯ">
<input class=dh type="submit" name="find" value="ȫ�����">
</td>
</form>
</tr>
</table>
</div>
</fieldset>
<fieldset style="width:auto;"><legend>������־��</legend>
<%
SetTable tshow, sqlexcel, fDo
%>
</fieldset>
</body>
</html>