<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "������λ������Ϣ"
DeleteKey = "��˾���"
DeleteNote = ""
sAdd = "cust_add"
sEdit = "cust_edit"
sDetail = "cust_detail"
sDelete = "cust_delete"
tShow = "tCustom_Show"
EditUrl = "../Unit/Cust_Add.asp"
DeleteUrl = "tCustom"
FormName = "Cust_Find.asp"
KeyField = "CustCode"
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
	orderf = "CustCode"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
CustCode=request("CustCode")
CustName=request("CustName")
CustType=request("CustType")
CoTypeCode=request("CoTypeCode")
CoType=request("CoType")
sqlwhere = sqlwhere & addsql("CustCode",CustCode,"like")
sqlwhere = sqlwhere & addsql("CustName",CustName,"like")
sqlwhere = sqlwhere & addsql("CoTypeCode",CoTypeCode,"likecate")
if CustType<>"�ͻ�����Ӧ��" then
	sqlwhere = sqlwhere & addsql("CustType",CustType,"like")
end if

sqlexcel = "select * from tCustom where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
��˾���<input type="text" class="catetree" name="CoType" value="<%=CoType%>" readonly size=12>
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<input type="hidden" name="CoTypeCode" value="<%=CoTypeCode%>">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;����ѡ�����</div>
<div id=height300 style="overflow:auto;">
<%
SetBasic "��˾���","CoTypeCode","CoType",""
%>
</div>
<div id=loginDIV1>
<center>
<input type="button" value="�ر�" onclick=closeselect() style="cursor: pointer;">
</center>
</div>
</div>
<!-- #include file="../public/s_select.asp" -->
<br>
��˾���ͣ�<% SetCombo "CustType", "select name from dict_combo where tablename='��λ����'", "no", CustType, "auto"%>
</td>
<td>
��˾��ţ�<input type="text" name="CustCode" value="<%=CustCode%>" size=12><br>
��˾���ƣ�<input type="text" name="CustName" value="<%=CustName%>" size=12>
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