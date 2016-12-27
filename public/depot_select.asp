<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<!-- #include file="isuser.asp" -->
<%
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "depotname"
end if
if ordero = "" then
	ordero = "asc"
end if
field = Request("field")
if Trim(Request("keyword"))<>"" then
	sqlwhere = "and "&field&" like '%"&Request("keyword")&"%' "
end if
getfields("depotselect")
sqlexcel = "select * from dict_depot where 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
tshow = "depotselect"
%>
<base onmouseover="window.status='双击选择货品';return true">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<SCRIPT LANGUAGE="JavaScript">
<!--
function getindex(){
var obj = event.srcElement
var tab=document.getElementById('table1');
if(obj.tagName != "TR")
obj = obj.parentElement;
self.opener.document.all.depotname.value = self.opener.document.all.depotname.value + tab.rows[obj.rowIndex].cells[1].innerHTML + '、'
tab.deleteRow(obj.rowIndex);
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>经办人选择</title>
</head>
<body>
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px">
<form name=form action="depot_select.asp" method="post">
<table style="display:block;border:0px;font-size:10pt;">
<tr>
<td style="border:0px;">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
搜索字段：<% SetCombo "field", "select * from t_fieldshow where tablename='depotselect' and show=true order by showid", "name", "field", ""%>
关键字：<input type="text" name="keyword" size=12 value="<%=keyword%>">
</td>
<td style="border:0px">
&nbsp;&nbsp;&nbsp;<input class=dh type="submit" name="find" value="查找">
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</td>
</tr>
</table>
</form>
</div>
<% SetTable "depotselect", sqlexcel, "0"%>
</body>
</html>