<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Response.AddHeader "Content-Disposition", "attachment;filename=�ֲֿ�����.xls"
Response.ContentType  =  "application/vnd.ms-excel "
%>
<%
qxlist = request.cookies("qxlist")
if instr(qxlist,"kc_cfind")=0 then 
	response.write "<script>alert('�Բ�����û�иò���Ȩ�ޣ�');history.go(-1);</script>"
	response.end
end if
cklist = request.cookies("cklist")
ldepot=cklist
depot = trim(Request.Querystring("depot"))
goodscode = trim(Request.Querystring("goodscode"))
goodsname = trim(Request.Querystring("goodsname"))
typecode = trim(Request.Querystring("typecode"))
overdate = trim(Request.Querystring("overdate"))
goodstype = GetType("goods", typecode)
sqlwhere = ""
if goodscode<>"" then
	sqlwhere = sqlwhere&" and goodscode like '%"&goodscode&"%'"
end if
if goodsname<>"" then
	sqlwhere = sqlwhere&" and goodsname like '%"&goodsname&"%'"
end if
if typecode<>"" then
	sqlwhere = sqlwhere&" and typecode like '"&typecode&"%'"
end if
if overdate<>"" then
	sqlwhere = sqlwhere&" and adddate<=#"&overdate&"#"
end if
f_go = "1"
if overdate = "" then
	f_go = "0"
	overdate = setdate(date())
end if
if depot="��ѡ��" then
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
<title>�ֿ�����ܲ�ѯ</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<%
	sqlexcel = "TRANSFORM iif(isnull(sum(number*sign)),0,sum(number*sign)) select goodscode as ��Ʒ����,goodsname as ��Ʒ����,goodsunit as ��Ʒ���,units as ��Ʒ��λ,goodstype as ��Ʒ��� from s_goodsnum where 1=1 "&sqlwhere&" group by goodscode,goodsname,goodsunit,units,goodstype PIVOT depotname"
	Set mypage=new xdownpage
	mypage.getconn = conn
	mypage.getsql = sqlexcel
	mypage.pagesize = 100000
	set t=mypage.getrs()
	response.write "<table id='table1' style=width:1px;height:1px;font-size:9pt; border=1><tr>"
	response.write "<th width=40 align=center>���</th>"
	for i = 0 to t.fields.count - 1
		response.write "<th width=80 align=center>"&t.fields(i).name&"</th>"
	next 
	response.write "</tr>"
	for j = 1 to mypage.pagesize
		if not t.eof then
			response.write "<tr>"
			response.write "<td>"&j&"</td>"
			for i = 0 to t.fields.count - 1
				response.write "<td>"&t.fields(i).value&"</td>"
			next
			response.write "</tr>"
			t.movenext
		end if
	next
	response.write "</tr>"
	response.write "</table>"
%>
<script>saveCode(tableExcel);</script>
<script>history.go(-1)</script>
</body>
</html>