<!-- #include file="conn.asp" -->
<!-- #include file="public.asp" -->
<%
sqlwhere = ""
if trim(request("name")) <> "" then
	sqlwhere = "and username like '%"&trim(request("name"))&"%'"
end if
if trim(request("depart")) <> "" then
	sqlwhere = sqlwhere & "and depart like '%"&trim(request("depart"))&"%'"
end if
	getfields("f_user")
	sqlexcel = "select "&fields&" from t_user where 1=1 "&sqlwhere
	tshow = "f_user"
%>
<base onmouseover="window.status='双击选择货品';return true">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<SCRIPT LANGUAGE="JavaScript">
<!--
function getindex(){
var obj = event.srcElement
var tab=document.getElementById('table1');
if(obj.tagName != "TR")
obj = obj.parentElement;
self.opener.document.all.g_user.value = tab.rows[obj.rowIndex].cells[1].innerHTML
window.opener=null;window.close()
}
//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<title>仓库管理员选择</title>
</head>
<body>
<div style="width:100%;height:40px;line-height:25px;padding:2px 0px">
	<form action="kg_select.asp" method="post">
		<table style="display:block;border:0px;font-size:10pt;">
			<tr>
				<td style="border:0px;">
					姓名：<input type="text" name="name" size="12">
					部门：<input type="text" name="depart" size="12">
				</td>
				<td style="border:0px">
					&nbsp;&nbsp;&nbsp;<input type="submit" name="find" value="查找">
					<input type="button" value="关闭" onclick=window.opener=null;window.close()>
				</td>
			</tr>
		</table>
	</form>
</div>
<% SetTable "f_user", sqlexcel, "0"%>
</body>
</html>