<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "��ɫ������Ϣ"
DeleteKey = "��ɫ���"
DeleteNote = ""
sAdd = "color_add"
sEdit = "color_edit"
sDetail = "color_detail"
sDelete = "color_delete"
tShow = "tColor_Show"
EditUrl = "../Unit/Color_Add.asp"
DeleteUrl = "tColor"
FormName = "Color_Find.asp"
KeyField = "ColorCode"
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
	orderf = "ColorCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
colorcode=request("colorcode")
colorname=request("colorname")
sqlwhere = sqlwhere & addsql("colorcode",colorcode,"like")
sqlwhere = sqlwhere & addsql("colorname",colorname,"like")

sqlexcel = "select * from tColor where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
��ɫ��ţ�<input type="text" name="colorcode" value="<%=colorcode%>" size=12>
��ɫ���ƣ�<input type="text" name="colorname" value="<%=colorname%>" size=12>
</td>
<td>
<input class=dh type=submit value="��ѯ">
<%=AddStr%>
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