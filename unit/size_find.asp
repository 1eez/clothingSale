<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "����������Ϣ"
DeleteKey = "������"
DeleteNote = ""
sAdd = "size_add"
sEdit = "size_edit"
sDetail = "size_detail"
sDelete = "size_delete"
tShow = "tSize_Show"
EditUrl = "../Unit/Size_Add.asp"
DeleteUrl = "tSize"
FormName = "Size_Find.asp"
KeyField = "SizeCode"
EditWidth = "120"
fDo = "1"
fWidth="640"
fHeight="480"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dhadd onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=��Ӽ�¼>"
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
	orderf = "SizeCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
sizecode=request("sizecode")
sizename=request("sizename")
sizegroup=request("sizegroup")
sqlwhere = sqlwhere & addsql("sizecode",sizecode,"like")
sqlwhere = sqlwhere & addsql("sizename",sizename,"like")
sqlwhere = sqlwhere & addsql("sizegroup",sizegroup,"like")

sqlexcel = "select * from tSize where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
�����ţ�<input type="text" name="sizecode" value="<%=sizecode%>" size=8>
�������ƣ�<input type="text" name="sizename" value="<%=sizename%>" size=8>
�����飺<input type="text" name="sizegroup" value="<%=sizegroup%>" size=8>
</td>
<td>
<input class=dh type=submit value="��ѯ">
<%=AddStr%>
<input class=dh type=button value="�������" onclick=openwin('size_hp.asp',640,480)>
</form>
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