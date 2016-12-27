<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Response.AddHeader "Content-Disposition", "attachment;filename=库存平衡表.xls"
Response.ContentType  =  "application/vnd.ms-excel "
%>
<%
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
cklist = request.cookies("cklist")
ldepot=cklist
begindate = trim(Request.Querystring("begindate"))
enddate = trim(Request.Querystring("enddate"))
if begindate = "" then
	f_go = " and isnull(a.goodscode)"
	begindate = setdate(Year(now)&"-"&Month(now)&"-01")
end if
if enddate = "" then
	enddate = setdate(date())
end if
depotname = trim(request("depotname"))
depot = trim(Request.Querystring("depot"))
goodscode = trim(Request.Querystring("goodscode"))
goodsname = trim(Request.Querystring("goodsname"))
typecode = trim(Request.Querystring("typecode"))
goodstype = GetType("goods", typecode)
sqlwhere = ""
if goodscode<>"" then
	sqlwhere = sqlwhere&" and a.goodscode like '%"&goodscode&"%'"
end if
if goodsname<>"" then
	sqlwhere = sqlwhere&" and a.goodsname like '%"&goodsname&"%'"
end if
if typecode<>"" then
	sqlwhere = sqlwhere&" and a.typecode like '"&typecode&"%'"
end if
if depotname<>"" then
	depotname = Split(depotname,"、")
	k = UBound(depotname)
	sqld = ""
	For j = LBound(depotname) To UBound(depotname)-1
		sqld = sqld & "'"&depotname(j)&"',"
	next
	sqld = left(sqld, len(sqld)-1)
	sqld = " and depotname in ("&sqld&")"
	sqlwhere = sqlwhere & sqld
end if
overdate = trim(Request.Querystring("overdate"))
f_go = "1"
if overdate = "" then
	f_go = "0"
	overdate = setdate(date())
end if
if depot="请选择" then
	depot = ""
end if
response.write "<script>"
response.write "var currentActiveRow;"
response.write "function change(el)"
response.write "{"
response.write "var x = el.rowIndex;"
response.write "if(currentActiveRow)currentActiveRow.style.backgroundColor='';" 
response.write "currentActiveRow=el;"
response.write "el.style.backgroundColor = ++d[x]%2 ? '#D5D5D5' : '#D5D5D5';"
response.write "}"
response.write "</script>"
%>
<html>
<title>库存平衡表查询</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table id='table1' style=width:1px;height:1px;font-size:9pt; border=1>
<%
colspan=""
response.write "<tr><th colspan=2 width=150 align=center>项目名称</th>"
ldepot = replace(ldepot,"'请选择',","")
ldepot = replace(ldepot,"'","")
ldepot = replace(ldepot," ","")
q = "select depotname from Dict_Depot where depotname in (" & cklist &") "&sqld&" order by depotname"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
ldepot=""
while not t.eof	
	if ldepot="" then
		ldepot=t("depotname")
	else
		ldepot=ldepot&","&t("depotname")
	end if	
	response.write "<th align=center width=110>"&t.fields(0).value&"</th>"
	t.movenext
wend
t.close
response.write "<th align=center width=110>合计</th></tr>"
q = "select a.depotname,b.startmoney,c.inmoney from (dict_depot a left join ("
q = q&"select iif(isnull(sum(money*sign)),0,sum(money*sign)) as startmoney,depotname "
q = q&"from s_goodsnum where cdate(adddate)<#"&begindate&"# "
q = q&"group by depotname) b on a.depotname=b.depotname) left join ("
q = q&"select iif(isnull(sum(money)),0,sum(money)) as inmoney,depotname "
q = q&"from s_goodsnum where sign=1 and cdate(adddate)>=#"&begindate&"# "
q = q&"and cdate(adddate)<=#"&enddate&"# group by depotname) c on a.depotname=c.depotname order by a.depotname"
t.open q, conn, 1, 1
s_startmoney = "<td colspan=2 align=center>期初金额</td>"
s_inmoney = "<td colspan=2 align=center>入库金额</td>"
i_startmoney = 0
i_inmoney = 0
while not t.eof
	startmoney = FormatNumber(t("startmoney"), cint(dotmoney), -1,false,false) 
	inmoney = FormatNumber(t("inmoney"), cint(dotmoney), -1,false,false) 
	i_startmoney  = FormatNumber(t("startmoney"), cint(dotmoney), -1,false,false) + i_startmoney
	i_inmoney  = FormatNumber(t("inmoney"), cint(dotmoney), -1,false,false) + i_inmoney
	s_startmoney = s_startmoney&"<td style=text-align:center>"&startmoney&"</td>"
	s_inmoney = s_inmoney&"<td style=text-align:center>"&inmoney&"</td>"
	t.movenext
wend
i_startmoney = FormatNumber(i_startmoney, cint(dotmoney), -1,false,false)
i_inmoney = FormatNumber(i_inmoney, cint(dotmoney), -1,false,false)
s_startmoney = "<tr onclick=change(this)>"&s_startmoney&"<td style=text-align:center>"&i_startmoney&"</td></tr>"
s_inmoney = "<tr onclick=change(this)>"&s_inmoney&"<td style=text-align:center>"&i_inmoney&"</td></tr>"
response.write s_startmoney
response.write s_inmoney
t.close

qa = "select distinct a.custname,a0.* " 
qb = "s_goodsnum a left join (select custname,"
qb = qb&"iif(round(Sum([sign]*[number]),2)=0 or isnull(Sum([sign]*[number])),0,round(Sum([money]),2))"
qb = qb&" from s_goodsnum where sign=-1 and cdate(adddate)<=#"&overdate&"# and depotname in (" & cklist &") group by custname) a0 on a.custname=a0.custname"
qt = ""
qk = ""
qi = ""
sc=strCount(ldepot, ",")+1
for i = 1 to strCount(ldepot, ",")+1
	if qt="" then
		qt = qt&"a"&i&".*"
	else
		qt = qt&",a"&i&".*"
	end if
	if qk="" then
		qk = qk&"("
	else
		qk = qk&"("
	end if
	if instr(ldepot,",")<1 then
		sdepot = ldepot
	end if
	sdepot = mid(ldepot,1,instr(ldepot,",") - 1)
	ldepot = replace(ldepot,mid(ldepot,1,instr(ldepot,",")),"")
	qi = qi&") left join (select custname,"
	qi = qi&"iif(round(Sum([sign]*[number]),2)=0 or isnull(Sum([sign]*[number])),0,round(Sum([money]),2)) "
	qi = qi&"from s_depotdetail where sign=-1 and cdate(adddate)<=#"&overdate&"# and depotname='"&sdepot&"'"
	qi = qi&" group by custname) a"&i&" on a.custname=a"&i&".custname"
next
if qt<>"" then
	qt=","&qt
end if
sqlexcel = qa&qt&" from "&qk&qb&qi&" where 1=1 "&sqlwhere&" and a.custname<>''"
t.open sqlexcel, conn, 1, 1
sCount = t.recordcount
k = 0
while not t.eof
	response.write "<tr onClick=""change(this)"">"
	if k = 0 then
		response.write "<td rowspan="&sCount&">单<br>位<br>出<br>库<br>明<br>细</td>"
	end if
	response.write "<td align=center>"&t.fields(0)&"</td>"
	j = 0
	j_s = ""
	for i = 1 to t.fields.count - 1
		if instr(t.fields(CInt(i)).name,"custname")<1 then
			money = FormatNumber(t.fields(CInt(i)), cint(dotmoney), -1,false,false) 
			if j=0 then
				j_s = "<td title="""&money&""" align=center>"&money&"</td>"
			else
				response.write "<td title="""&money&""" align=center>"&money&"</td>"
			end if
			j = j + 1
		end if
	next
	response.write j_s
	response.write "</tr>"
	k = k + 1
	t.movenext
wend
t.close

q = "select a.depotname,b.startmoney,c.inmoney from (dict_depot a left join ("
q = q&"select iif(isnull(sum(money*sign)),0,sum(money*sign)) as startmoney,depotname "
q = q&"from s_goodsnum where cdate(adddate)<=#"&enddate&"# "
q = q&"group by depotname) b on a.depotname=b.depotname) left join ("
q = q&"select iif(isnull(sum(money)),0,sum(money)) as inmoney,depotname "
q = q&"from s_goodsnum where sign=-1 and cdate(adddate)>=#"&begindate&"# "
q = q&"and cdate(adddate)<=#"&enddate&"# group by depotname) c on a.depotname=c.depotname order by a.depotname"
t.open q, conn, 1, 1
s_inmoney = "<td colspan=2 align=center>出库金额</td>"
s_startmoney = "<td colspan=2 align=center>期末金额</td>"
i_startmoney = 0
i_inmoney = 0
while not t.eof
	startmoney = FormatNumber(t("startmoney"), cint(dotmoney), -1,false,false) 
	inmoney = FormatNumber(t("inmoney"), cint(dotmoney), -1,false,false) 
	i_startmoney  = FormatNumber(t("startmoney"), cint(dotmoney), -1,false,false) + i_startmoney
	i_inmoney  = FormatNumber(t("inmoney"), cint(dotmoney), -1,false,false) + i_inmoney
	s_startmoney = s_startmoney&"<td style=text-align:center>"&startmoney&"</td>"
	s_inmoney = s_inmoney&"<td style=text-align:center>"&inmoney&"</td>"
	t.movenext
wend
i_startmoney = FormatNumber(i_startmoney, cint(dotmoney), -1,false,false)
i_inmoney = FormatNumber(i_inmoney, cint(dotmoney), -1,false,false)
s_inmoney = "<tr onclick=change(this)>"&s_inmoney&"<td style=text-align:center>"&i_inmoney&"</td></tr>"
s_startmoney = "<tr onclick=change(this)>"&s_startmoney&"<td style=text-align:center>"&i_startmoney&"</td></tr>"
response.write s_inmoney
response.write s_startmoney
t.close
%>
</table>
<%
response.write "<script>"
response.write "var d = new Array(document.getElementById('table1').rows.length);"
response.write "for(i=0;i<d.length;i++)d[i]=0"
response.write "</script>"
%>
</body>
</html>