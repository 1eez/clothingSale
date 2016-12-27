<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<%
f_flag=0
cx = request.querystring("type")
if cx<>"" then
	cx = "cx"
else
	cx = "zz"
end if
cpdepot = request.querystring("depot")
sqlwhere = ""
if request("goodscode")<>"" then
	sqlwhere = " and goodscode like '%"&request("goodscode")&"%'"
end if
if request("goodsname")<>"" then
	sqlwhere = " and goodsname like '%"&request("goodsname")&"%'"
end if
if request("barcode")<>"" then
	sqlwhere = " and barcode like '%"&request("barcode")&"%'"
end if
if request("typecode")<>"" then
	sqlwhere = " and typecode like '"&request("typecode")&"%'"
end if
getfields("SelectMB")
tshow = "SelectMB"
q = "select * from t_zz where cpdepot='"&request("depot")&"' "&sqlwhere&" order by goodscode"
sqlexcel = q
%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>
<!--
function getindex(){
	var obj = event.srcElement
	var k = window.g
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	window.opener.location.href='../unit/<%=cx%>_add.asp?lldepot='+tab.rows[obj.rowIndex].cells[6].innerHTML+'&mbcode='+tab.rows[obj.rowIndex].cells[1].innerHTML+'&cpdepot='+tab.rows[obj.rowIndex].cells[7].innerHTML;
	window.opener=null;window.close()
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script src="../js/public.js"  type="text/javascript"/></script>
<script type="text/javascript" src="../js/jquery-1.3.2.min.js" ></script>
<script type="text/javascript" src="../js/mln.colselect.js"></script>
<link href="../style/mln-main.css" rel="stylesheet" type="text/css"/>
<link href="../style/mln.colselect.css" rel="stylesheet" type="text/css">
<title>货品资料信息</title>
</head>
<body>
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px 20px 0px;">
<form action="hpmb_select.asp?depot=<%=cpdepot%>" method="get">
<table style="display:block;border:0px;font-size:10pt;">
<tr>
<td style="border:0px;">
<input type="hidden" name=depot value=<%=request("depot")%>>
货品编码：<input type="text" name="goodscode" size="12">
</td>
<td style="border:0px">货品类别：</td>
<td><% SetCate "goods", "typecode", goodstype, typecode %></td>
<td style="border:0px" rowspan=2>
&nbsp;&nbsp;&nbsp;<input type="submit" name="find" value="查找">
<input type="button" value="关闭" onclick=window.opener=null;window.close()>
</td>
</tr>
<tr>
<td>货品名称：<input type="text" name="goodsname" size="12"></td>
<td>货品条码：</td>
<td><input type="text" name="barcode" size="12"></td>
</tr>
</table>
</form>
</div>
<% SetTable "SelectMB", sqlexcel, "0"%>
</body>
</html>