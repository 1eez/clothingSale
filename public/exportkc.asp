<!-- #include file="../public/public.asp" -->
<%
set conn=Server.CreateObject("ADODB.connection")
dtitle = request.form("dtitle")
tshow = request.form("tshow")
if dtitle="" then
	dtitle="库存汇总"
end if
Response.AddHeader "Content-Disposition", "attachment;filename="&dtitle&".xls"
Response.ContentType  =  "application/vnd.ms-excel"
database = request.cookies("database_abcd")
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
	sqlexcel = request("sql")
'-------------------------------------------------------------------------------------------------------------
%>
<html>
<title>库存汇总查询</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<%
response.write "<table id='table1' style=width:1px;height:1px;font-size:9pt; border=1>"
set t = server.createobject("adodb.recordset")
sql = "select * from t_fieldshow where show=true and tablename='" & tshow & "' order by showid"
t.open sql, conn, 1, 1
Fieldcolspan=t.recordcount
response.write "<tr>"
while not t.eof
	img = ""
	img1 = ""
	if orderf=t("field") then
		if ordero = "desc" then
			img = "<img src=../images/desc.gif>"
		end if
		if ordero = "asc" then
			img = "<img src=../images/asc.gif>"
		end if
	end if
	if instr("startnumber,endnumber,innumber,outnumber",t("field"))<=0 then
		span=" rowspan=2"
		order=" onclick=order(this)"
	end if
	if t("field")="StartNumber" then
		if orderf=t("field") then
			if ordero = "desc" then
				img = "<img src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img src=../images/asc.gif>"
			end if
		end if
		span=" colspan=2"
		if orderf="StartNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="StartMon" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center>数量"&img&"</th>"
		str_th=str_th&"<th width=80 align=center>金额"&img1&"</th>"
		order=""
	end if
	if t("field")="EndNumber" then
		span=" colspan=2"
		if orderf="EndNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="EndMon" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center>数量"&img&"</th>"
		str_th=str_th&"<th width=80 align=center>金额"&img1&"</th>"
		order=""
	end if
	if t("field")="InNumber" then
		span=" colspan=2"
		if orderf="InNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="InMoney" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center>数量"&img&"</th>"
		str_th=str_th&"<th width=80 align=center>金额"&img1&"</th>"
		order=""
	end if
	if t("field")="OutNumber" then
		span=" colspan=2"
		if orderf="OutNumber" then
			if ordero = "desc" then
				img = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		if orderf="OutMoney" then
			if ordero = "desc" then
				img1 = "<img border=0 src=../images/desc.gif>"
			end if
			if ordero = "asc" then
				img1 = "<img border=0 src=../images/asc.gif>"
			end if
		end if
		str_th=str_th&"<th width=80 align=center>数量"&img&"</th>"
		str_th=str_th&"<th width=80 align=center>金额"&img1&"</th>"
		order=""
	end if
	response.write "<th"&span&" align=center valign=center width="&t("width")&">"
	response.write ""&t("name")&""&img
	response.write "</th>"
	fields=fields & "," & t("field")
	t.movenext
wend
response.write "</tr>"
response.write "<tr>"&str_th&"</tr>"
Set mypage=new xdownpage
mypage.getconn = conn
mypage.getsql = sqlexcel
mypage.pagesize = 10000
set rs=mypage.getrs()
strwarning = ""
if rs.eof then
	strwarning = "此查询没有记录"
end if
for i = 1 to mypage.pagesize
	while not rs.eof
	response.write("<tr onClick=""change(this)"">")
	set t = server.createobject("adodb.recordset")
	sql = "select * from t_fieldshow where show=true and tablename='" & tshow & "' order by showid"
	sumsql = sql
	t.open sql, conn, 1, 1
	Fieldcolspan=t.recordcount
	while not t.eof
		f_field=t("field")
		f_field = replace(f_field, "a.", "")
		f_zero = rs(""&f_field&"")
		if t("dotsize")="1" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotnum), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotnum), -1,false,false)
			end if
		end if
		if t("dotsize")="2" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotprice), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotprice), -1,false,false)
			end if
		end if
		if t("dotsize")="3" then
			if isnull(f_zero) then
				f_zero = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero = FormatNumber(f_zero, cint(dotmoney), -1,false,false)
			end if
		end if
		f_zero1=""
		if t("field")="EndNumber" then
			f_zero1=rs("endmon")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="StartNumber" then
			f_zero1=rs("startmon")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="InNumber" then
			f_zero1=rs("inmoney")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if t("field")="OutNumber" then
			f_zero1=rs("outmoney")
			if isnull(f_zero1) then
				f_zero1 = FormatNumber(0, cint(dotmoney), -1,false,false)
			else
				f_zero1 = FormatNumber(f_zero1, cint(dotmoney), -1,false,false)
			end if
		end if
		if rs("t_money")<>0 then
			fcolor="style=color:#FF0000"
		end if
		response.write("<td "&fcolor&" title="""&f_zero&""">"&f_zero&"</td>")
		if f_zero1<>"" then
			response.write("<td "&fcolor&" title="""&f_zero1&""">"&f_zero1&"</td>")
		end if
		fcolor=""
		t.movenext
	wend
	rs.movenext
	wend
next
Fieldcolspan=Fieldcolspan+4
if exceltable="" then
	if strwarning<>"" then
		response.write("<tr><td align=left colspan="&Fieldcolspan&">"&strwarning&"</td></tr>")
	end if
end if
response.write("</table>")
%>
</body>
</html>