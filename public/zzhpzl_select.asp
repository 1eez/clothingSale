<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<%
sqlwhere=""
if Trim(Request.querystring("goodscode"))<>"" then
	sqlwhere = "and a.goodscode like '%"&Request.querystring("goodscode")&"%' "
end if
if Trim(Request.querystring("goodsname"))<>"" then
	sqlwhere = sqlwhere&"and goodsname like '%"&Request.querystring("goodsname")&"%' "
end if
if Trim(Request.querystring("typecode"))<>"" then
	sqlwhere = sqlwhere&"and typecode like '"&Request.querystring("typecode")&"%' "
    goodsType= GetType("goods", Trim(Request.querystring("typecode")))
end if
if Trim(Request.querystring("barcode"))<>"" then
	sqlwhere = sqlwhere&"and barcode like '%"&Request.querystring("barcode")&"%' "
end if
depot = Request.querystring("depot")
id = request.querystring("id")
if depot<>"" then
	depotgroup = ",depotname "
	depotfield = " depotname, "
	depotsql = " and depotname='"&depot&"'"
end if
tshow = "SelectzzGoods"
getfields("SelectzzGoods")
	q = "select a.*,b.t_num,b.avgprice"
	q = q&" from t_goods a left join (select goodscode, "
	q = q&" iif(isnull(Sum([sign]*[number])), 0, Sum([sign]*[number])) AS [t_num],"
	q = q&" iif(Sum([sign]*[number])=0 or isnull(sum([sign]*[number])),0,Sum([sign]*[number]*[price])/Sum([sign]*[number])) AS Avgprice"	
	q = q&" from S_GoodsNum where 1=1 "
	q = q&depotsql
	q = q&" group by goodscode) b on a.goodscode=b.goodscode "
	q = q&" where 1=1 "&sqlwhere
	sqlexcel = q
%>
<base onmouseover="window.status='双击选择货品';return true">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
window.g=<% response.write(id) %>
function getindex(){
	window.g=<% response.write(id) %>
	var obj = event.srcElement
	var k = window.g
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	if(window.g!=<%=id%>){self.opener.addNew();}
	if(window.g=='0'){self.opener.addNew();k=self.opener.document.all.intK.value;}
	self.opener.document.all('goodscode'+k).value = tab.rows[obj.rowIndex].cells[1].innerHTML
	self.opener.document.all('goodsname'+k).value = tab.rows[obj.rowIndex].cells[2].innerHTML
	self.opener.document.all('goodsunit'+k).value = tab.rows[obj.rowIndex].cells[3].innerHTML
	self.opener.document.all('units'+k).value = tab.rows[obj.rowIndex].cells[4].innerHTML
	self.opener.document.all('price'+k).value = tab.rows[obj.rowIndex].cells[6].innerHTML
	self.opener.document.all('number'+k).value = 1
	self.opener.document.all('cmoney'+k).value = tab.rows[obj.rowIndex].cells[6].innerHTML
	tab.deleteRow(obj.rowIndex);
	if(window.g!='0'){window.opener=null;window.close()}
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../js/jquery-1.3.2.min.js" ></script>
<script type="text/javascript" src="../js/mln.colselect.js"></script>
<link href="../style/mln-main.css" rel="stylesheet" type="text/css"/>
<link href="../style/mln.colselect.css" rel="stylesheet" type="text/css">
<title>【<%=request("depot")%>】货品资料信息</title>
</head>
<body style="overflow-y:auto;">
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px;">
<form action="zzhpzl_select.asp?id=<%=id%>&depot=<%=depot%>" method="get">
<table style="display:block;border:0px;font-size:10pt;">
<tr>
<td style="border:0px;">
货品编码：<input type="text" name="goodscode" size="12">
</td>
<td style="border:0px">货品类别：</td>
<td><% SetCate "goods", "typecode", goodstype, typecode %></td>
<td style="border:0px" rowspan=2>
&nbsp;&nbsp;&nbsp;<input type="submit" name="find" value="查找">
<input class=dh onclick=openwin("../public/set_table_n.asp?tablename=<%=tshow%>",480,360) type="button" name="expert" value="设置列显示">
<input type="button" value="关闭" onclick=window.opener=null;window.close()>
</td>
</tr>
<tr>
<td>
货品名称：<input type="text" name="goodsname" size="12">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="depot" value="<%=depot%>">
</td>
<td style="border:0px">货品条码：</td>
<td style="border:0px"><input type="text" name="barcode" size="12"></td>
</tr>
</table>
</form>
</div>
<div style="overflow-y:auto;">
<% SetTable "SelectzzGoods", sqlexcel, "0"%>
</div>
</body>
</html>