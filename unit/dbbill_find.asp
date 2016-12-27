<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "调拨单据信息"
DeleteKey = "调拨单号"
DeleteNote = ""
sAdd = "xsbill_add"
sEdit = "xsbill_edit"
sDetail = "xsbill_detail"
sDelete = "xsbill_delete"
tShow = "tdbBill_Show"
EditUrl = "../Unit/xsBill_Add.asp"
HpUrl = "../Unit/Bill_Hp.asp"
DeleteUrl = "tcgBill"
FormName = "dbBill_Find.asp"
KeyField = "BillCode"
EditWidth = "160"
fDo = "1"
fWidth="880"
fHeight="600"
EditTh = ""
if InStr(qxlist, sEdit)>0 or 1=1 then
	EditTh = EditTh&"Edit"
end if
if InStr(qxlist, sDetail)>0 or 1=1 then
	EditTh = EditTh&"Detail"
end if
if InStr(qxlist, sDelete)>0 or 1=1 then
	EditTh = EditTh&"Delete"
end if
if InStr(qxlist, "SizeHp")>0 or 1=1 then
	EditTh = EditTh&"SizeHp"
end if
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "BillCode"
end if
if ordero = "" then
	ordero = "Desc"
end if
BeginDate = request("BeginDate")
EndDate = request("EndDate")
if BeginDate="" then
	BeginDate = setdate(year(Date())&"-"&month(date())&"-01")
end if
if EndDate="" then
	EndDate = setdate(date())
end if
sqlwhere = " and AddDate>=#"&BeginDate&"# and AddDate<=#"&EndDate&"# "
DepotName=request("DepotName")
CustName=request("CustName")
FUser=request("FUser")
OldBill=request("OldBill")
BillCode=request("BillCode")
sqlwhere = sqlwhere & addsql("DepotName",DepotName,"=")
sqlwhere = sqlwhere & addsql("CustName",CustName,"like")
sqlwhere = sqlwhere & addsql("FUser",FUser,"likecate")
sqlwhere = sqlwhere & addsql("OldBill",OldBill,"like")
sqlwhere = sqlwhere & addsql("BillCode",BillCode,"like")
sqlwhere = sqlwhere & " and billtype in ('店铺调拨')"
sqlexcel = "select * from tBill where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script>
function firm(el){
if(confirm('您确定要删除【<%=DeleteKey%>】是【' + el.showvalue + '】的记录吗？\n点击确定按钮，继续操作！'))
{location.href='../Unit/AllDelete.asp?tablename=<%=DeleteUrl%>&<%=KeyField%>=' + el.value;}  
else{}}
</script>
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
单据日期：<input type="text" name="begindate" size="9" value="<%=begindate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(begindate,0);"> ~
<input type="text" name="enddate" size="9" value="<%=enddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(enddate,0);"><br>
调入店铺：<% ComboDepot "CustName", CustName, "auto", ""%><br>
手工单号：<input type="text" name="oldbill" value="<%=oldbill%>" size=12>
</td>
<td>
店铺名称：<% ComboDepot "DepotName", DepotName, "auto", "all"%><br>
　经办人：<input type="text" name="fuser" value="<%=fuser%>" size=12><br>
　　单号：<input type="text" name="billcode" value="<%=billcode%>" size=12>
</td>
<td>
<input class=dh type=submit value="查询">
</form>
</td>
<td>

</td>
</tr></table>
</fieldset>
<fieldset style="width:auto;"><legend><%=dTitle%></legend>
<%
SetTable tshow, sqlexcel, fDo
%>
</fieldset>
</body>
</html>