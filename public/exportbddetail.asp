<!-- #include file="../public/public.asp" -->
<%
dtitle = trim(request.querystring("dtitle"))
if dtitle="" then
	dtitle="成品组装导出"
end if
Response.AddHeader "Content-Disposition", "attachment;filename=" & dtitle & ".xls"
Response.ContentType  =  "application/vnd.ms-excel"
database = request.cookies("database_abcd")
set conn=Server.CreateObject("ADODB.connection") 
reportConn()
set t = server.createobject("adodb.recordset")
sql = "select * from t_appinfo"
t.open sql, conn, 1, 1
num1 = t("num1")
num2 = t("num2")
dotnum=t("dotnumber")
dotprice=t("dotprice")
dotmoney=t("dotmoney")
t.close
set t=nothing
'-------------------------------------------------------------------------------------------------------------
	sqlexcel = request.querystring("sql")
'-------------------------------------------------------------------------------------------------------------
%>
<html>
<title>库存汇总查询</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<div id=inner-table-bill1>
<table id='table1' style=width:1px;height:1px;font-size:9pt; border=1>
<tr>
<th align="center" valign="middle" width=128>成品编码</th>
<th align="center" valign="middle" width=130>成品名称</th>
<th align="center" valign="middle" width=100>成品规格</th>
<th align="center" valign="middle" width=60>单位</th>
<th align="center" valign="middle" width=80>数量</th>
<th align="center" valign="middle" width=80>单价</th>
<th align="center" valign="middle" width=80>金额</th>
<th width=128 colspan=2></th>
</tr></table>
<%
style1 = "#B2B2B2"
set rs = server.createobject("adodb.recordset")
set t = server.createobject("adodb.recordset")
rs.open sqlexcel, conn, 1, 1
strwarning = ""
if rs.eof then
	strwarning = "此查询没有记录"
end if
while not rs.eof
	%>
	<table style=width:1px;height:1px;font-size:9pt; border=1 style=cursor:hand;border:0px; onmouseup=with(findObj('<%=rs("goodscode")%>').style){display=display=='none'?'':'none';}>
	<tr>
	<%
	response.write "<td "&style1&" width=129>"&rs("goodscode")&"</td>"
	response.write "<td "&style1&" width=130>"&rs("goodsname")&"</td>"
	response.write "<td "&style1&" width=100>"&rs("goodsunit")&"</td>"
	response.write "<td "&style1&" width=60>"&rs("units")&"</td>"
	response.write "<td "&style1&" width=80>"&rs("t_num")&"</td>"
	response.write "<td "&style1&" width=80>"&rs("t_price")&"</td>"
	response.write "<td "&style1&" width=80>"&rs("t_money")&"</td>"
	response.write "<td "&style1&" width=128 colspan=2></td>"
	response.write "</tr></table>"
	%>
<table id=<%=rs("goodscode")%> style=display:none; style=width:1px;height:1px;font-size:9pt; border=1>
<tr>
<td align="center" valign="middle" style=border:0px; width=68></td>
<th align="center" valign="middle" width=60>序号</th>
<th align="center" valign="middle" width=130>原料编码</th>
<th align="center" valign="middle" width=100>原料名称</th>
<th align="center" valign="middle" width=60>原料规格</th>
<th align="center" valign="middle" width=80>单位</th>
<th align="center" valign="middle" width=80>数量</th>
<th align="center" valign="middle" width=80>单价</th>
<th align="center" valign="middle" width=128>金额</th></tr>
	<%
	j = 0
	q = "select goodscode,goodsname,goodsunit,units,sum(number) as t_num,sum(money) as t_money,t_money/t_num as t_price from s_depotdetail where type='组装用料' and billcode1 in (select billcode from t_depot where type='组装成品'"
	q = q & sqld & ") group by goodscode,goodsname,goodsunit,units order by goodscode"
	t.open q, conn, 1, 1
	while not t.eof
		j = j + 1
		response.write "<tr>"
		response.write "<td style=border:0px></td>"
		response.write "<td>"&j&"</td>"
		response.write "<td>"&t("goodscode")&"</td>"
		response.write "<td>"&t("goodsname")&"</td>"
		response.write "<td>"&t("goodsunit")&"</td>"
		response.write "<td>"&t("units")&"</td>"
		response.write "<td>"&t("t_num")&"</td>"
		response.write "<td>"&t("t_price")&"</td>"
		response.write "<td>"&t("t_money")&"</td>"
		response.write "</tr>"
		t.movenext
	wend
	t.close
	rs.movenext
  wend
%>
</table>
</div><hr>
<%
rs.close
set t=nothing
set rs=nothing
conn.close
set conn=nothing
%>
</body>
</html>