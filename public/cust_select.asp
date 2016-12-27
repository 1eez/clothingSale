<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
co_type = Request.Querystring("co_type")
f_flag=0
orderf = request("orderf")
ordero = request("ordero")
if orderf = "" then
	orderf = "custname"
end if
if ordero = "" then
	ordero = "asc"
end if
field = Request("field")
cklist = request.cookies("cklist")
if Trim(Request("keyword"))<>"" then
	f_flag=1
end if
if f_flag<>0 then
	sqlwhere = sqlwhere&"and "&field&" like '%"&Request("keyword")&"%' "
end if
getfields("custom")
sqlexcel = "select "&fields&" from t_custom where co_type like '%"&co_type&"%' and 1=1 "&sqlwhere&" order by "&orderf&" "&ordero
tshow = "custom"
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
self.opener.document.all.supply.value = tab.rows[obj.rowIndex].cells[1].innerHTML
window.opener=null;window.close()
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>
<%
if co_type="custom" then
	response.write "客户信息选择"
else
	response.write "供应商信息选择"
end if
%>
</title>
</head>
<body>
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px">
<form name=form action="cust_select.asp?co_type=<%=co_type%>" method="get">
<table style="display:block;border:0px;font-size:10pt;">
<input type="hidden" value="<%=request("orderf")%>" name=orderf>
<input type="hidden" value="<%=request("ordero")%>" name=ordero>
<input type=hidden name=co_type value="<%=co_type%>">
搜索字段：<% SetCombo "field", "select * from t_fieldshow where tablename='Custom' order by showid", "name", "field", ""%>
关键字：<input type="text" name="keyword" size=12>
<input class=dh type="submit" name="find" value="查找">
<input class=dh type="button" name="close" value="关闭" onclick=window.opener=null;window.close()>
</table>
</form>
</div>
<% SetTable "custselect", sqlexcel, "0"%>
</body>
</html>