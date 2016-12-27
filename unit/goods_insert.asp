<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
action = "goods_insert.asp"
goodsstyle = request("goodsstyle")
set t = server.createobject("adodb.recordset")
q = "select * from tGoods where GoodsStyle='"&goodsstyle&"'"
t.open q, conn, 1, 1
if t.eof then
	 t.close
	 response.write "没有此商品资料["&goodsstyle&"],商品资料不能有 # % ' 等特殊符号"
	 response.end
end if
sizegroup = t("sizegroup")
goodsname = t("goodsname")
ColorGroup=t("ColorGroup")
dpprice=t("dpprice")
inprice1=t("dpprice")
'dpprice = FormatNumber(t("dpprice"), dotprice, -1,false,false)
'inprice1 = FormatNumber(dpprice*t("indiscount"), dotprice, -1,false,false)
units = t("units")
dTitle = "【"&t("goodsstyle")&"】-【"&t("goodsname")&"】-商品尺码、颜色录入"
t.close
set t=nothing
reK = 0
if request("submit")="保存" then
	l = trim(request("intK"))
	if l="" then
	  response.write "没有录入数据"
    response.end
  end if
	for z = 1 to l
	inprice = FormatNumber(request("inprice"), dotprice, -1,false,false)
	set t = server.createobject("adodb.recordset")
	set f = server.createobject("adodb.recordset")
	q = "select * from tSize where sizegroup='"&sizegroup&"' order by colPosition"
	t.open q, conn, 1, 1
	while not t.eof
		fnumber = 0
		money = 0
		colorname = ""
		sizename = t("sizename")
		fnumber = request(t("sizename")&"_"&z)
		colorname = request("ColorName"&z)
		q = "select * from tGoodsBarCode where GoodsStyle='"&GoodsStyle&"' and SizeName='"&SizeName&"' and ColorName='"&ColorName&"'"
		f.open q, conn, 1, 1
		if not f.eof then
			barcode = t("barcode")
		else
			barcode = goodsstyle&colorname&sizename
		end if
		f.close
		if fnumber<>0 then
			money = FormatNumber(fnumber*inprice, dotmoney, -1,false,false)
			%>
<script>
j = self.opener.document.all.intK.value
tr=self.opener.document.all.t136.insertRow()
tr.style.height=25
tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>' 
tr.insertCell().innerText=++j
self.opener.document.all.intK.value=j
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsstyle_'+j+' value="<%=goodsstyle%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=goodsname_'+j+' value="<%=goodsname%>">' 
tr.insertCell().innerHTML='<input style=width:100%;border:0px; readonly type=text name=units_'+j+' value="<%=units%>">' 
tr.insertCell().innerHTML='<select name=sizename_'+j+' style=width:100%;><% SetCombojs "SizeName", "select * from tSize where SizeGroup = '"&sizegroup&"' order by colPosition", "SizeName", "SizeName", t("sizename")%></select>'
tr.insertCell().innerHTML='<select name=colorname_'+j+' style=width:100%;><% SetComboColorGroup ColorGroup, ColorName%></select>'
tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changenumber('+j+') class=number style=width:100%; type=text name=number_'+j+' value="<%=fnumber%>">' 
tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changeprice('+j+') class=number style=width:100%; type=text name=price_'+j+' value="<%=inprice%>">' 
tr.insertCell().innerHTML='<input onFocus="this.select()" onkeyup=changemoney('+j+') class=number style=width:100%; type=text name=money_'+j+' value="<%=money%>">' 
tr.insertCell().innerHTML='<input style=width:100%; type=text name=barcode_'+j+' value="<%=barcode%>">' 
tr.insertCell().innerHTML='<input style=width:100%; type=text name=dremark_'+j+' value=>' 
</script>
            <%
		end if
		t.movenext
	wend
	t.close
	set t=nothing
	set f=nothing
	next
	response.write "<script>self.opener.changevalue();window.opener=null;window.close();</script>"
end if
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<script>
var k=<%=reK%>
function addNew(){
	tr=document.all.t136.insertRow()
	tr.style.height=25
	tr.insertCell().innerHTML='<a class=delete href=javascript:void(0) onclick=del()>删除</a>' 
	tr.insertCell().innerText=++k
	document.all.intK.value=k
	tr.insertCell().innerHTML='<select name=ColorName'+k+' style=width:auto;><% SetComboColorGroup ColorGroup, ColorName%></select>'
<%
set t = server.createobject("adodb.recordset")
q = "select * from tSize where sizegroup='"&sizegroup&"' order by colPosition"
t.open q, conn, 1, 1
while not t.eof
%>
tr.insertCell().innerHTML='<input class=number value=0 style=width:100%; type=text name=<%=t("SizeName")%>_'+k+'>' 
<%
	t.movenext
wend
t.close
%>
}
function del(){
	i=window.event.srcElement.parentElement.parentElement.rowIndex;
	document.all.t136.deleteRow(i);
	for(k=0;k<document.all.t136.rows.length-1;k++){
		document.all.t136.rows[k+1].cells[1].innerText=(k+1);
		document.all.t136.rows[k+1].cells[2].children[0].name='ColorName_'+(k+1);
<%
set t = server.createobject("adodb.recordset")
q = "select * from tSize where sizegroup='"&sizegroup&"' order by colPosition"
t.open q, conn, 1, 1
j = 2
while not t.eof
j = j + 1
%>
document.all.t136.rows[k+1].cells[<%=j%>].children[0].name='<%=t("SizeName")%>_'+(k+1);
<%
	t.movenext
wend
t.close
%>
	}
	document.all.intK.value=k
}
</script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form action=<%=action%> method="post">
&nbsp;&nbsp;吊牌价：<%=dpprice%>&nbsp;&nbsp;&nbsp;进货价：<input class=number type=text name=inprice size=6 value="<%=inprice1%>"><br>
<input class=dh type=button onclick=addNew() name="addnew" value=增行>
<input type=hidden name=intK>
<input type=hidden name=goodsstyle value="<%=goodsstyle%>">
<div id="inner-table-hpzl">
<table id=t136>
<tr>
<th width=28 align=center></th>
<th width=30 align=center>序号</th>
<th width=110 align=center>颜色</th>
<%
set t = server.createobject("adodb.recordset")
q = "select * from tSize where sizegroup='"&sizegroup&"' order by colPosition"
t.open q, conn, 1, 1
while not t.eof
	response.write "<th width=50 align=center>"&t("sizename")&"</th>"
	t.movenext
wend
%>
</tr>
</table>
</div>
<center>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>