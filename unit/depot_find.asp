<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "店铺资料信息"
DeleteKey = "店铺名称"
DeleteNote = ""
sAdd = "depot_add"
sEdit = "depot_edit"
sDetail = "depot_detail"
sDelete = "depot_delete"
tShow = "tDepot_Show"
EditUrl = "../Unit/Depot_Add.asp"
DeleteUrl = "tDepot"
FormName = "Depot_Find.asp"
KeyField = "DepotName"
EditWidth = "120"
fDo = "1"
fWidth="640"
fHeight="480"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dhadd onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=添加记录>"
end if
if InStr(qxlist, sEdit)>0 or 1=1 then
	EditTh = EditTh&"Edit"
end if
if InStr(qxlist, sDetail)>0 or 1=1 then
	EditTh = EditTh&"Detail"
end if
if InStr(qxlist, sDelete)>0 or 1=1 then
	EditTh = EditTh&"Delete"
end if
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "seqno"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
DepotName=request("DepotName")
DepotMan=request("DepotMan")
sqlwhere = sqlwhere & addsql("DepotName",DepotName,"like")
sqlwhere = sqlwhere & addsql("DepotMan",DepotMan,"like")

sqlexcel = "select * from tDepot where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero


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
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
店铺名称：<input type="text" name="DepotName" value="<%=DepotName%>" size=12>
店铺负责人：<input type="text" name="DepotMan" value="<%=DepotMan%>" size=12>
</td>
<td>
<input class=dh type=submit value="查询">
<%=AddStr%>
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