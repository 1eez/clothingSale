<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "��Ʒ������Ϣ"
DeleteKey = "��Ʒ���"
DeleteNote = ""
sAdd = "hp_add"
sEdit = "hp_edit"
sDetail = "hp_detail"
sDelete = "hp_delete"
tShow = "tGoods_Show"
EditUrl = "../Unit/Hp_Add.asp"
DeleteUrl = "tGoods"
FormName = "Hp_Find.asp"
KeyField = "GoodsStyle"
EditWidth = "120"
fDo = "1"
fWidth="640"
fHeight="480"
EditTh = ""
if InStr(qxlist, sAdd)>0 or 1=1 then
	AddStr = "<input class=dhadd onClick=openwin('"&EditUrl&"',"&fWidth&","&fHeight&") type='button' name='add' value=���Ӽ�¼>"
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
	orderf = "GoodsStyle"
end if
if ordero = "" then
	ordero = "asc"
end if

sqlwhere = ""
GoodsStyle=request("GoodsStyle")
GoodsName=request("GoodsName")
GoodsType=request("GoodsType")
TypeCode=request("TypeCode")
GoodsBrand=request("GoodsBrand")
Supply=request("Supply")
sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")
sqlwhere = sqlwhere & addsql("Supply",Supply,"like")
sqlexcel = "select * from tGoods where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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
��Ʒ���<input type="text" class="catetree" name="GoodsType" value="<%=GoodsType%>" readonly size=12>
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<input type="hidden" name="TypeCode" value="<%=TypeCode%>">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;����ѡ�����</div>
<div id=height300 style="overflow:auto;">
<%
SetBasic "��Ʒ���","TypeCode","GoodsType",""
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
��Ʒ���ƣ�<input type="text" name="GoodsName" value="<%=GoodsName%>" size=12>
</td>
<td>
��Ʒ��ţ�<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12>&nbsp;&nbsp;��Ӧ��:<%SetCombo "Supply","select name from dict_cate where tablename='��Ӧ��' order by code", "all", Supply, "auto"%><br>
��ƷƷ�ƣ�<input type="text" name="GoodsBrand" value="<%=GoodsBrand%>" size=12>
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