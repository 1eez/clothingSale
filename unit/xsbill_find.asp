<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "���۵�����Ϣ"
DeleteKey = "���۵���"
DeleteNote = ""
sAdd = "xsbill_add"
sEdit = "xsbill_edit"
sDetail = "xsbill_detail"
sDelete = "xsbill_delete"
tShow = "txsBill_Show"
EditUrl = "../Unit/xsBill_Add.asp"
HpUrl = "../Unit/Bill_Hp.asp"
DeleteUrl = "tcgBill"
FormName = "xsBill_Find.asp"
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
sqlwhere = sqlwhere & " and billtype in ('���۳���','�����˻�')"
'sqlwhere = sqlwhere & " and depotname in ("&cklist&")"
sqlexcel = "select * from tBill where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script>
function firm(el){
if(confirm('��ȷ��Ҫɾ����<%=DeleteKey%>���ǡ�' + el.showvalue + '���ļ�¼��\n���ȷ����ť������������'))
{location.href='../Unit/AllDelete.asp?tablename=<%=DeleteUrl%>&<%=KeyField%>=' + el.value;}  
else{}}
</script>
</head>
<body>
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/public.js'></script>


<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<fieldset style="width:auto;"><legend>��ѯ��Ϣ</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
�������ڣ�<input type="text" name="begindate" size="9" value="<%=begindate%>">
<input type="button" name="btnbgCalendarUI" class="btn_01" onclick="javascript:showCalendar(begindate,0);" style="width:17px; height:18px; background: url(../images/calendar.gif) no-repeat; padding:0; border:none; border:0; cursor:pointer;"/> 
<img src="../images/blank.png" width="1"> ~
<input type="text" name="enddate" size="9" value="<%=enddate%>">
<input type="button" name="btnendCalendarUI" class="btn_01" onclick="javascript:showCalendar(enddate,0);" style="width:17px; height:18px; background: url(../images/calendar.gif) no-repeat; padding:0; border:none; border:0; cursor:pointer;"/> 
<img src="../images/blank.png" width="1"><br>
�����ͻ���<input type="text" name="custname" value="<%=custname%>" size=24><br>
�ֹ����ţ�<input type="text" name="oldbill" value="<%=oldbill%>" size=12>
</td>
<td>
�������ƣ�<% ComboDepot "DepotName", DepotName, "auto", "all"%><br>
�������ˣ�<input type="text" name="fuser" value="<%=fuser%>" size=12><br>
�������ţ�<input type="text" name="billcode" value="<%=billcode%>" size=12>
</td>
<td>
<input class=dh type=submit value="��ѯ">
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