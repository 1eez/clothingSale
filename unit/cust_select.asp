<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "往来单位资料信息"
DeleteKey = "公司编号"
DeleteNote = ""
sAdd = "cust_add"
sEdit = "cust_edit"
sDetail = "cust_detail"
sDelete = "cust_delete"
tShow = "tCustom_Show"
SelectUrl = "cust_select"
EditUrl = "../Unit/Cust_Add.asp"
DeleteUrl = "tCustom"
FormName = "Cust_Select.asp?custtype="&request("custtype")
KeyField = "CustCode"
EditWidth = "120"
fDo = "0"
fWidth="640"
fHeight="480"
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
sqlwhere = sqlwhere & addsql("CustType",CustType,"like")

sqlexcel = "select * from tCustom where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
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

function getonevalue(fonevalue, fallvalue){
	fonevalue = fallvalue.substr(fallvalue.indexOf(fonevalue) + fonevalue.length,10000)
	fonevalue = fonevalue.substr(0,fonevalue.indexOf("|-;"))
	return fonevalue
}

function custselect(){
	var obj = event.srcElement
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	var obj = event.srcElement
	var tab=document.getElementById('table1');
	if(obj.tagName != "TR")
	obj = obj.parentElement;
	allvalue=tab.rows[obj.rowIndex].cells[0].innerHTML
	self.opener.document.all.CustName.value = getonevalue("custname:", allvalue)
	window.opener=null;window.close();
}
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
公司类别：<input type="text" class="catetree" name="CoType" value="<%=CoType%>" readonly size=12>
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<input type="hidden" name="CoTypeCode" value="<%=CoTypeCode%>">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;单击选择类别</div>
<div id=height300 style="overflow:auto;">
<%
SetBasic "公司类别","CoTypeCode","CoType",""
%>
</div>
<div id=loginDIV1>
<center>
<input type="button" value="关闭" onclick=closeselect() style="cursor: pointer;">
</center>
</div>
</div>
<!-- #include file="../public/s_select.asp" -->
<br>
公司类型：<% SetCombo "CustType", "select name from dict_combo where tablename='单位类型'", "no", CustType, "auto"%>
</td>
<td>
公司编号：<input type="text" name="CustCode" value="<%=CustCode%>" size=12><br>
公司名称：<input type="text" name="CustName" value="<%=CustName%>" size=12>
</td>
<td>
<input class=dh type=submit value="查询">
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