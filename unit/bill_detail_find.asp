<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "������ϸ��Ϣ"
DeleteKey = "��Ʒ���"
DeleteNote = ""
sAdd = "hp_add"
sEdit = "hp_edit"
sDetail = "hp_detail"
sDelete = "hp_delete"
tShow = "tBillDetail_Show"
EditUrl = "../Unit/Bill_Add.asp"
DeleteUrl = "tBillDetail"
FormName = "bill_detail_find.asp"
KeyField = "BillCode"
KeyFieldId="BillDetailID"
EditWidth = "120"
fDo = "1"
fWidth="880"
fHeight="600"
EditTh = ""
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
sqlwhere = sqlwhere & addsql("GoodsStyle",GoodsStyle,"like")
sqlwhere = sqlwhere & addsql("GoodsName",GoodsName,"like")
sqlwhere = sqlwhere & addsql("TypeCode",TypeCode,"likecate")
sqlwhere = sqlwhere & addsql("GoodsBrand",GoodsBrand,"like")

sqlexcel = "select * from vBillDetailMx where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
%>
<html>
<title><%=dTitle%></title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=scharset%>">
<script>
function firm(el){
if(confirm('��ȷ��Ҫɾ����¼��\n���ȷ����ť������������'))
{location.href='../Unit/AllDelete.asp?tablename=<%=DeleteUrl%>&delid=' + el.delid;}  
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
��Ʒ��ţ�<input type="text" name="GoodsStyle" value="<%=GoodsStyle%>" size=12><br>
��ƷƷ�ƣ�<input type="text" name="GoodsBrand" value="<%=GoodsBrand%>" size=12>
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