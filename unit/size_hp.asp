<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "尺码横排信息"
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script>
function firm(el){
if(confirm('您确定要删除【<%=DeleteKey%>】是【' + el.showvalue + '】的记录吗？\n点击确定按钮，继续操作！'))
{location.href='../Unit/AllDelete.asp?tablename=<%=DeleteUrl%>&<%=KeyField%>=' + el.value;}  
else{}}
</script>
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<div id=divTitle>【<%=dTitle%>】</div>
<hr>
<%
dim sizecola()
set t = server.createobject("adodb.recordset")
set f = server.createobject("adodb.recordset")
q = "select distinct colPosition from tSize order by colPosition"
t.open q, conn, 1, 1
redim sizecola(t.recordcount)
sizecol = t.recordcount
response.write "<div id=inner-table-hpzl><table><tr><th width=40 align=center>行\列</th>"
for i = 0 to t.recordcount - 1
	sizecola(i) = t.fields(0).value
	response.write "<th width=40 align=center>"&t.fields(0).value&"</th>"
	t.movenext
next
response.write "</tr>"
t.close
q = "select distinct rowPosition from tSize order by rowPosition"
t.open q, conn, 1, 1
while not t.eof
	response.write "<tr><th width=40 align=center>"&t.fields(0).value&"</th>"
	q = "select * from tSize where rowPosition="&t.fields(0).value&" order by colPosition"
	f.open q, conn, 1, 1
	j = 0
	for i = 0 to sizecol - 1
		if f("colPosition")=sizecola(j) then
			response.write "<td>"&f("SizeName")&"</td>"
			j = j + 1
		else
			response.write "<td></td>"
			do while f("colPosition")<>sizecola(j)
				j = j + 1
				if f("colPosition")=sizecola(j) then
					response.write "<td>"&f("SizeName")&"</td>"
					j = j + 1
					exit do
				else
					response.write "<td></td>"
				end if
			loop			
		end if
		if f.eof then
			response.write "<td></td>"
		end if
		f.movenext
	next
	f.close
	response.write "</tr>"
	t.movenext
wend
response.write "</table></div>"
%>
</body>
</html>