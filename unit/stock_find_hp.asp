<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "商品库存查询"
DeleteKey = "商品款号"
DeleteNote = ""
sAdd = "hp_add"
sEdit = "hp_edit"
sDetail = "hp_detail"
sDelete = "hp_delete"
tShow = "tStockFind"
EditUrl = "../unit/Hp_Add.asp"
DeleteUrl = "tGoods"
SelectUrl = "xsBill"
FormName = "stock_find.asp"
KeyField = "GoodsStyle"
EditWidth = "120"
fDo = "0"
fWidth="640"
fHeight="480"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dh onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=添加记录>"
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
	'orderf = "GoodsStyle"
	orderf = "DepotName,GoodsStyle,ColorName,SizeCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
GoodsStyle=request("GoodsStyle")
GoodsName=request("GoodsName")
GoodsType=request("GoodsType")
TypeCode=request("TypeCode")
GoodsBrand=request("GoodsBrand")
AddDate=request("AddDate")
DepotName=request("DepotName")
Supply=request("Supply")
if AddDate="" then
	AddDate = SetDate(Date())
end if
'sqlwhere = sqlwhere & " and adddate<=#"&AddDate&"# "
sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
if DepotName="" then
	 DepotName="全部"
end if
sqlwhere = sqlwhere & addsql("DepotName",DepotName,"=")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")
sqlwhere = sqlwhere & addsql("Supply",Supply,"like")
'sqlwhere = sqlwhere & " and depotname in ("&cklist&")"

'sqlexcel = "select * from vStock where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
sqlexcel = "select * from vStockShow where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
</head>
<body>
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/public.js'></script>


<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />

<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td >
	<table width="100%"><tr><td align="right">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
截止日期：<input type="text" name="AddDate" id="AddDate" size="12" value="<%=AddDate%>">
</td><td algin="left">
<input type="button" name="btnbgCalendarUI" class="btn_01" onclick="javascript:showCalendar(AddDate,0);" style="width:17px; height:18px; background: url(../images/calendar.gif) no-repeat; padding:0; border:none; border:0; cursor:pointer;"/> 
 </td> </tr></table>

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
店铺名称：<% ComboDepot "DepotName", DepotName, "auto", "all"%>&nbsp;&nbsp;供应商:<%SetCombo "Supply","select name from dict_cate where tablename='供应商' order by code", "all", Supply, "auto"%><br>
商品款号：<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12><br>
商品品牌：<input type="text" name="GoodsBrand" value="<%=GoodsBrand%>" size=12>  
</td>
<td>
<input class=dh type=submit value="查询">&nbsp;&nbsp;&nbsp;&nbsp;<input class=dh type=button onclick="window.print();" value="打印">
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