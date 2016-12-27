<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "操作员信息"
DeleteKey = "操作员名称"
DeleteNote = ""
sAdd = "userqx_add"
sEdit = "userqx_edit"
sDetail = "userqx_detail"
sDelete = "userqx_delete"
tShow = "tUser_Show"
EditUrl = "../public/userqx.asp"
DeleteUrl = "tUser"
FormName = "userqx_Find.asp"
KeyField = "username"
EditWidth = "120"
fDo = "1"
fWidth="640"
fHeight="570"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dhadd onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=添加记录>"
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
	orderf = "username"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
username=request("username")
ftype=request("type")
sqlwhere = sqlwhere & addsql("username",username,"like")
sqlwhere = sqlwhere & addsql("type",ftype,"=")

'sqlwhere = sqlwhere & " and type='用户'"
sqlexcel = "select * from tUser where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
<fieldset style="width:auto;"><legend>查询信息</legend>
<form name="form" method="get" action="<%=FormName%>">
<table><tr>
<td>
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
用户名：<input type="text" name="username" value="<%=username%>" size=12>
用户类型：<% SetCombo "type", "select name from dict_cate where tablename='用户类型'","",ftype,"auto"%>
</td>
<td>
<input class=dh type=submit value="查询">
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