<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "VIP������Ϣ"
DeleteKey = "��Ա���"
DeleteNote = ""
sAdd = "vip_add"
sEdit = "vip_edit"
sDetail = "vip_detail"
sDelete = "vip_delete"
tShow = "tVip_Show"
EditUrl = "../Unit/Vip_Add.asp"
DeleteUrl = "tVip"
FormName = "Vip_Find.asp"
KeyField = "VipCode"
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
	orderf = "VipCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
vipcode=request("vipcode")
vipname=request("vipname")
sqlwhere = sqlwhere & addsql("vipcode",vipcode,"like")
sqlwhere = sqlwhere & addsql("vipname",vipname,"like")

sqlexcel = "select * from tVip where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
VIP���ţ�<input type="text" name="VipCode" value="<%=VipCode%>" size=12>
VIP������<input type="text" name="VipName" value="<%=VipName%>" size=12>
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