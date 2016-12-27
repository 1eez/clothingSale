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
else

end if
tshow = "SelectzzGoods"
getfields("SelectzzGoods")
	q = "select a.goodscode,a.goodsname,a.goodsunit,a.units,b.t_num,b.avgprice"
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function getindex(){
	var obj = event.srcElement
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	self.opener.document.all.goodscode<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[1].innerHTML
	self.opener.document.all.goodsname<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[2].innerHTML
	self.opener.document.all.goodsunit<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[3].innerHTML
	self.opener.document.all.units<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[4].innerHTML
	self.opener.document.all.price<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[6].innerHTML
	self.opener.document.all.number<% response.write(request.querystring("id"))%>.value = 1
	self.opener.document.all.money<% response.write(request.querystring("id"))%>.value = tab.rows[obj.rowIndex].cells[6].innerHTML
	window.opener=null;window.close()
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>【<%=request("depot")%>】货品资料信息</title>
</head>
<body style="overflow-y:auto;">
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px;">
<form action="zzhpzl_select1.asp?id=<%=id%>&depot=<%=depot%>" method="get">
<table style="display:block;border:0px;font-size:10pt;">
<tr>
<td style="border:0px;">
货品编码：<input type="text" name="goodscode" size="8"><br>
货品名称：<input type="text" name="goodsname" size="8">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="depot" value="<%=depot%>">
</td>
<td style="border:0px">
货品类别：<input type="text" name="goodstype" size="8">
<img style="cursor:hand" src="../images/f.gif" onclick=openwin("../public/mtreehp.asp?table=goodstype",340,300)><br>
<input type="hidden" name="typecode">
货品条码：<input type="text" name="barcode" size="8">
</td>
<td style="border:0px">
&nbsp;&nbsp;&nbsp;<input class=dh type="submit" name="find" value="查找">
<input class=dh onclick=openwin("../public/set_table_n.asp?tablename=<%=tshow%>",480,360) type="button" name="expert" value="设置列显示">
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</td>
</tr>
</table>
</form>
</div>
<div style="overflow-y:auto;">
<% SetTable "SelectzzGoods", sqlexcel, "0"%>
</div>
</body>
</html>