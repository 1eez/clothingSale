<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "Ա��������Ϣ"
DeleteKey = "Ա�����"
DeleteNote = ""
sAdd = "emp_add"
sEdit = "emp_edit"
sDetail = "emp_detail"
sDelete = "emp_delete"
tShow = "tEmp_Show"
EditUrl = "../Unit/Emp_Add.asp"
DeleteUrl = "tEmp"
FormName = "Emp_Find.asp"
KeyField = "EmpCode"
EditWidth = "120"
fDo = "1"
fWidth="640"
fHeight="480"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dhadd onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=��Ӽ�¼>"
end if
if InStr(qxlist, sAdd)>0 or 1=1 then
	ExportIn = "&nbsp;<input type=button value=Excel���� class=dh onclick=openwin('excelin.asp?tablename="&DeleteUrl&"',900,660)>"
end if
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
	orderf = "EmpCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
EmpCode=request("EmpCode")
EmpName=request("EmpName")
Depart=request("Depart")
DepartCode=request("DepartCode")
Address=request("Address")
sqlwhere = sqlwhere & addsql("EmpCode",EmpCode,"like")
sqlwhere = sqlwhere & addsql("EmpName",EmpName,"like")
sqlwhere = sqlwhere & addsql("DepartCode",DepartCode,"likecate")
sqlwhere = sqlwhere & addsql("Address",Address,"like")

sqlexcel = "select * from tEmp where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script>
function firm(el){
if(confirm('��ȷ��Ҫɾ����<%=DeleteKey%>���ǡ�' + el.showvalue + '���ļ�¼��\n���ȷ����ť������������'))
{location.href='../Unit/AllDelete.asp?tablename=<%=DeleteUrl%>&<%=KeyField%>=' + el.value;}  
else{}}
</script>
</head>
<body>
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<fieldset style="width:auto;"><legend>��ѯ��Ϣ</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>

Ա�����ţ�<% ComboDepot "Depart", Depart, "auto", ""%><br>
<!-- #include file="../public/s_select.asp" -->

��ͥסַ��<input type="text" name="Address" value="<%=Address%>" size=12>
</td>
<td>
Ա����ţ�<input type="text" name="EmpCode" value="<%=EmpCode%>" size=12><br>
Ա�����ƣ�<input type="text" name="EmpName" value="<%=EmpName%>" size=12>
</td>
<td>
<input class=dh type=submit value="��ѯ">
<%=AddStr%>
<%=ExportIn%>
</form>
</td>
<td>

</td>
</tr></table>
</fieldset>
<fieldset style="width:auto;"><legend><%=dTitle%></legend>
<%
SetTable tshow, sqlexcel, fDo
%>
</fieldset>
</body>
</html>