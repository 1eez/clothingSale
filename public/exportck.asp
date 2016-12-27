<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Response.AddHeader "Content-Disposition", "attachment;filename=分仓汇总.xls"
Response.ContentType  =  "application/vnd.ms-excel "
%>
<%
cklist = request.cookies("cklist")
ldepot=cklist
depot = trim(Request.Querystring("depot"))
goodscode = trim(Request.Querystring("goodscode"))
goodsname = trim(Request.Querystring("goodsname"))
typecode = trim(Request.Querystring("typecode"))
goodstype = trim(Request.Querystring("goodstype"))
sqlwhere = ""
if goodscode<>"" then
	sqlwhere = sqlwhere&" and a.goodscode like '%"&goodscode&"%'"
end if
if goodsname<>"" then
	sqlwhere = sqlwhere&" and a.goodsname like '%"&goodsname&"%'"
end if
if typecode<>"" then
	sqlwhere = sqlwhere&" and a.typecode like '%"&typecode&"%'"
end if
overdate = trim(Request.Querystring("overdate"))
f_go = "1"
if overdate = "" then
	overdate = setdate(date())
end if
if depot="请选择" then
	depot = ""
end if
colspan=""
response.write "<table id='table1' style=width:1px;height:1px;font-size:9pt; border=1><tr>" 
response.write "<th rowspan=2 align=center width=110>货品编码</th>"
response.write "<th rowspan=2 align=center width=120>货品名称</th>"
response.write "<th rowspan=2 align=center width=110>货品规格</th>"
response.write "<th rowspan=2 align=center width=40>单位</th>"
response.write "<th rowspan=2 align=center width=80>货品类别</th>"
response.write "<th align=center colspan=2 width=120>库存总数</th>"
colspan = colspan&"<th align=center>数量</th><th align=center>金额</th>"
ldepot = replace(ldepot,"'请选择',","")
ldepot = replace(ldepot,"'","")
ldepot = replace(ldepot," ","")
q = "select depotname from Dict_Depot"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
ldepot=""
while not t.eof
	if ldepot="" then
		ldepot=t("depotname")
	else
		ldepot=ldepot&","&t("depotname")
	end if
	t.movenext
wend
qa = "select distinct a.goodscode,goodsname,goodsunit,units,goodstype,a0.* " 
qb = "s_depotnum a left join (select goodscode,"
qb = qb&"iif(Sum([sign]*[number])=0 or isnull(Sum([sign]*[number])),0,Sum([sign]*[number])),"
qb = qb&"iif(round(Sum([sign]*[number]),2)=0 or isnull(Sum([sign]*[number])),0,round(Sum([sign]*[number]*[price])/Sum([sign]*[number]),2))"
qb = qb&" from s_depotnum where sign<>0 and cdate(adddate)<=#"&overdate&"# group by goodscode) a0 on a.goodscode=a0.goodscode"
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
	qi = qi&") left join (select goodscode,"
	qi = qi&"iif(Sum([sign]*[number])=0 or isnull(Sum([sign]*[number])),0,Sum([sign]*[number])),"
	qi = qi&"iif(round(Sum([sign]*[number]),2)=0 or isnull(Sum([sign]*[number])),0,round(Sum([sign]*[number]*[price])/Sum([sign]*[number]),2)) "
	qi = qi&"from s_depotnum where sign<>0 and cdate(adddate)<=#"&overdate&"# and depotname='"&sdepot&"'"
	qi = qi&" group by goodscode) a"&i&" on a.goodscode=a"&i&".goodscode"
	response.write "<th colspan=2 align=center width=120>"&sdepot&"</th>"
	colspan = colspan&"<th align=center>数量</th><th align=center>金额</th>"
next
response.write "<tr>"&colspan&"</tr>"
if qt<>"" then
	qt=","&qt
end if
if f_go="1" then
	sqlexcel = qa&qt&" from "&qk&qb&qi&" where 1=1 "&sqlwhere&" and 1=1"
	Set mypage=new xdownpage
	mypage.getconn = conn
	mypage.getsql = sqlexcel
	mypage.pagesize = 200000
	set t=mypage.getrs()
	for j = 1 to mypage.pagesize
		while not t.eof
			response.write "<tr onClick=""change(this)"">"
			response.write "<td>"&t.fields(0)&"</td>"
			for i = 1 to t.fields.count - 1
				if instr(t.fields(CInt(i)).name,"goodscode")<1 then
					response.write "<td title="""&t.fields(CInt(i))&""">"&t.fields(CInt(i))&"</td>"
				end if
			next	
			Fieldcolspan=t.fields.count-sc
			response.write "</tr>"
			t.movenext
		wend
	next
	response.write "</tr>"
	response.write "</table>"
end if
%>
<script>saveCode(tableExcel);</script>
<script>history.go(-1)</script>
</body>
</html>