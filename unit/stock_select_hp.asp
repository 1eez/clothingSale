<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "商品资料选择"
DeleteKey = "商品款号"
DeleteNote = ""
sAdd = "hp_add"
sEdit = "hp_edit"
sDetail = "hp_detail"
sDelete = "hp_delete"
tShow = "tGoodsSelect_Show"
EditUrl = "../unit/Hp_Add.asp"
DeleteUrl = "tGoods"
SelectUrl = "cgBill"
FormName = "stock_select_hp.asp"
KeyField = "GoodsStyle"
EditWidth = "120"
fDo = "0"
fWidth="640"
fHeight="480"
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

sqlwhere = ""
GoodsStyle=request("GoodsStyle")
GoodsName=request("GoodsName")
GoodsType=request("GoodsType")
TypeCode=request("TypeCode")
GoodsBrand=request("GoodsBrand")
DepotName=trim(request("DepotName"))

sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")

sqlexcel = "select * from tGoods where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
sHpSql = SetHpSql(" and 1=1")
Sqlw = ""
sqlexcel = "select * from (select "&sHpSql&" Supply, GoodsStyle, GoodsName, Units, ColorName, ColorCode, ColorValue, dpPrice, SizeGroup, Sum(Number1*Sign) AS tNum, Sum(Number1*dpPrice*Sign) AS tdpMon, Sum(Number1*Price*Sign) AS tMon, iif(Sum(Number1*Sign)=0 or Sum(Number1*Sign) is null,0,Sum(Number1*InPrice*Sign)/Sum(Number1*Sign)) AS tPrice FROM vBillDetail where 1=1 "&Sqlw&" and DepotName='"&DepotName&"' GROUP BY Supply, GoodsStyle, GoodsName, Units, ColorName, ColorCode, ColorValue, dpPrice, SizeGroup) where 1=1 "&Sqlw
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
<input type="hidden" value="<%=DepotName%>" name="DepotName">
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
商品款号：<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12><br>
商品品牌：<input type="text" name="GoodsBrand" value="<%=GoodsBrand%>" size=12>
</td>
<td>
<input class=dh type=submit value="查询">
<%=AddStr%>
</form>
</td>
<td>

</td>
</tr></table>
<div id=divTitle>【<%=dTitle%>】</div>
<hr>
<%
set t = server.createobject("adodb.recordset")
set f = server.createobject("adodb.recordset")
set rs = server.createobject("adodb.recordset")
dim sizecola()
q = "select distinct colPosition from tSize where 1=1 "&colwhere&" order by colPosition"
t.open q, conn, 1, 1
redim sizecola(t.recordcount)
sizecol = t.recordcount
for i = 0 to t.recordcount - 1
	sizecola(i) = t.fields(0).value
	t.movenext
next
t.close
q = "select distinct rowPosition from tSize where 1=1 "&rowwhere&" order by rowPosition"
t.open q, conn, 1, 1
rownum = t.recordcount
l = 0
%><div id=hpprint>
<table>
<%
while not t.eof
	if l=0 then
		response.write "<tr><th colspan=8 rowspan="&rownum&">商品尺码横排信息</th>"
	else
		response.write "<tr>"
	end if
	q = "select * from tSize where rowPosition="&t.fields(0).value&" "&colwhere&" order by colPosition"
	f.open q, conn, 1, 1
	j = 0
	for i = 0 to f.recordcount - 1
		if f("colPosition")=sizecola(j) then
			response.write "<th width=25><b>"&f("SizeName")&"</th>"
			j = j + 1
		else
			response.write "<th></th>"
			do while f("colPosition")<>sizecola(j)
				j = j + 1
				if f("colPosition")=sizecola(j) then
					response.write "<th width=40 align=center><b>"&f("SizeName")&"</th>"
					j = j + 1
					exit do
				else
					response.write "<th></th>"
				end if
			loop			
		end if
		f.movenext
	next
	f.close
	response.write "</tr>"
	l = l +1
	t.movenext
wend
t.close
response.write "<tr>"
response.write "<th width=30>序号</th>"
response.write "<th width=80>商品款号</th>"
response.write "<th width=100>商品名称</th>"
response.write "<th width=30>单位</th>"
response.write "<th width=40>颜色</th>"
response.write "<th width=50>合计</th>"
response.write "<th width=70>单价</th>"
response.write "<th width=70>金额</th>"
for i = 1 to sizecol
	response.write "<th>数量</th>"
next
response.write "</tr>"

sqlexcel = "select * from (select "&sHpSql&" Supply, GoodsStyle, GoodsName, Units, ColorName, ColorCode, ColorValue, dpPrice, SizeGroup, Sum(Number1*Sign) AS tNum, Sum(Number1*dpPrice*Sign) AS tdpMon, Sum(Number1*Price*Sign) AS tMon, iif(Sum(Number1*Sign)=0 or Sum(Number1*Sign) is null,0,Sum(Number1*InPrice*Sign)/Sum(Number1*Sign)) AS tPrice FROM vBillDetail where 1=1 "&Sqlw&" and DepotName='"&DepotName&"' GROUP BY Supply, GoodsStyle, GoodsName, Units, ColorName, ColorCode, ColorValue, dpPrice, SizeGroup) where 1=1 "&Sqlw
Set mypage=new xdownpage
'response.write sqlexcel
'response.end
mypage.getconn = conn
mypage.getsql = sqlexcel
mypage.pagesize = 20
set rs=mypage.getrs()
strwarning = ""
if rs.eof then
	strwarning = "此查询没有记录"
end if
for n = 1 to mypage.pagesize
if not rs.eof then
	price=rs("dpprice")
	if trim(""&rs("dpprice"))="" then
	 price=0
	end if
	tdpMon=rs("tdpMon")
	if trim(""&rs("tdpMon"))="" then
	 tdpMon=0
	end if
	
	
	if request("page")="" then
		recno = n
	else
		recno = n + (request("page")-1)*mypage.pagesize
	end if
	response.write "<tr>"
	response.write "<th align=center><b>"&recno&"</b></th>"
	response.write "<td>"&rs("goodsstyle")&"</td>"
	response.write "<td>"&rs("goodsname")&"</td>"
	response.write "<td>"&rs("units")&"</td>"
	response.write "<td>"&rs("colorname")&"</td>"
	response.write "<td align=center>"&FormatNumber(rs("tnum"), dotnumber, -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(price, dotprice, -1,false,false)&"</td>"
	response.write "<td align=center>"&FormatNumber(tdpMon, dotmoney, -1,false,false)&"</td>"
	for i = 0 to sizecol - 1
		if isnull(rs("a"&sizecola(i))) then
			response.write "<td></td>"
		else
			response.write "<td style=text-align:center;>"&FormatNumber(rs("a"&sizecola(i)), dotnumber, -1,false,false)&"</td>"
		end if
	next
	response.write "</tr>"
else
  exit for
end if
	rs.movenext
next

		response.write("<tr><th style=text-align:left; colspan="&8+sizecol&">")
		mypage.showpage()
		response.write "执行时间："&FormatNumber(chaetime, 4, -1,false,false)&"(秒)"
		if instr(qxlist,"f_column")>0 or 1=1 then
			response.write "&nbsp;&nbsp;<a href=javascript: class=ulink onclick=openwin('../public/set_table_n.asp?tablename="&tshow&"&dtitle="&dtitle&"',480,360) >设置列显示</a>"&ExportExcel
		end if
		response.write("</th></tr>")
rs.close
set rs=nothing
conn.close
set conn=nothing
response.write "</table></div>"
%>
</body>
</html>