<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "采购明细信息"
DeleteKey = "单号"
DeleteNote = ""
sAdd = "cgBill_add"
sEdit = "cgBill_edit"
sDetail = "cgBill_detail"
sDelete = "cgBill_delete"
tShow = "tcgBillDetail_Show"
EditUrl = "../Unit/Bill_Add.asp"
DeleteUrl = "tcgBill"
FormName = "cgbill_detail_find.asp"
KeyField = "BillCode"
EditWidth = "120"
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
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "GoodsStyle"
end if
if ordero = "" then
	ordero = "asc"
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

GoodsStyle=request("GoodsStyle")
GoodsName=request("GoodsName")
GoodsType=request("GoodsType")
TypeCode=request("TypeCode")
GoodsBrand=request("GoodsBrand")
BillCode=request("BillCode")
sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")
sqlwhere = sqlwhere & addsql("BillCode",BillCode,"like")
sqlwhere = sqlwhere & " and billtype in ('采购进货','采购退货')"
'sqlwhere = sqlwhere & " and depotname in ("&cklist&")"
sqlexcel = "select * from vBillDetail where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
'response.write sqlexcel

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

商品类别：<input type="text" class="catetree" name="GoodsType" value="<%=GoodsType%>" readonly size=12>
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<input type="hidden" name="TypeCode" value="<%=TypeCode%>">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;单击选择类别</div>
<div id=height300 style="overflow:auto;">
<%
SetBasic "商品类别","TypeCode","GoodsType",""
%>
</div>
<div id=loginDIV1>
<center>
<input type="button" value="关闭" onclick=closeselect() style="cursor: pointer;">
</center>
</div>
</div>
<!-- #include file="../public/s_select.asp" -->
<br>
商品名称：<input type="text" name="GoodsName" value="<%=GoodsName%>" size=12>
</td>
<td>
商品款号：<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12>　<br>
商品品牌：<input type="text" name="GoodsBrand" value="<%=GoodsBrand%>" size=12>
</td>
<td>
	单据日期：<input type="text" name="begindate" size="9" value="<%=begindate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(begindate,0);"> ~
<input type="text" name="enddate" size="9" value="<%=enddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(enddate,0);"><br>单号：<input type="text" name="billcode" value="<%=billcode%>" size=18>
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