<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<%
sqlwhere = "" 
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "goodscode"
end if
if ordero = "" then
	ordero = "desc"
end if
if Trim(Request("goodscode"))<>"" then
	sqlwhere = "and goodscode like '%"&Request("goodscode")&"%' "
end if
if Trim(Request("goodsname"))<>"" then
	sqlwhere = sqlwhere&"and goodsname like '%"&Request("goodsname")&"%' "
end if
if Trim(Request("typecode"))<>"" then
	sqlwhere = sqlwhere&"and typecode like '"&Request("typecode")&"%' "
end if
if Trim(Request("barcode"))<>"" then
	sqlwhere = sqlwhere&"and barcode like '%"&Request("barcode")&"%' "
end if
getfields("SelectGoodszzmb")
tshow = "SelectGoodszzmb"
q = "select * from t_goods where 1=1 "&sqlwhere&" "&"order by "&orderf&" "&ordero
sqlexcel = q
id = request.querystring("id")
%>
<base onmouseover="window.status='双击选择货品';return true">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type='text/javascript' src='../js/public.js'></script>
<SCRIPT LANGUAGE="JavaScript">
function getindex(){
	window.g=<%=id%>	
	var obj = event.srcElement
	var k = window.g
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	if(window.g!=<%=id%>){self.opener.addNew();}
	if(window.g=='0'){self.opener.addNew();k=self.opener.document.all.intK.value;}
	self.opener.document.all('goodscode'+k).value = 
			tab.rows[obj.rowIndex].cells[1].innerHTML
	self.opener.document.all('goodsname'+k).value = 
			(tab.rows[obj.rowIndex].cells[2].innerHTML).replace(/<\/?.+?>/g,'')
	self.opener.document.all('goodsunit'+k).value = 
			tab.rows[obj.rowIndex].cells[3].innerHTML
	self.opener.document.all('units'+k).value = 
			tab.rows[obj.rowIndex].cells[4].innerHTML
	self.opener.document.all('number'+k).value = 1
	tab.deleteRow(obj.rowIndex);
	if(window.g!='0'){window.opener=null;window.close()}
}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>货品资料信息</title>
</head>
<body>
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px;">
	<form name=form action="hpzz_select.asp?id=<%=request.querystring("id")%>" method="get">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>	
		<table style="display:block;border:0px;font-size:10pt;">
			<tr>
				<td style="border:0px;">
					货品编码：<input type="text" name="goodscode" size="12"><br>
					货品名称：<input type="text" name="goodsname" size="12">
					<input name="id" type="hidden" value="<%=request("id")%>">
				</td>
				<td style="border:0px">
					货品类别：<input type="text" name="goodstype" size="7">
					<img style="cursor:hand" src="../images/f.gif" onclick=openwin("../public/mtreehp.asp?table=goodstype",340,300)><br>
					<input type="hidden" name="typecode">
					货品条码：<input type="text" name="barcode" size="12">
				</td>
				<td style="border:0px">
					&nbsp;&nbsp;&nbsp;<input type="submit" name="find" value="查找">
					<input type="button" value="关闭" onclick=window.opener=null;window.close()>
				</td>
			</tr>
		</table>
	</form>
</div>
<% SetTable "SelectGoodszzmb", sqlexcel, "0"%>
</body>
</html>