<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【尺码信息资料设置】"
cklist = request.cookies("cklist")
sizecode = request("sizecode")
action = "size_save.asp"
if sizecode <> "" then
	action = action&"?sizecode="&server.urlencode(sizecode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tSize where sizecode='"&sizecode&"'"
	t.open sql, conn, 1, 1
		sizecode = t("sizecode")
		colPosition = t("colPosition")
		rowPosition = t("rowPosition")
		SizeGroup = t("SizeGroup")
		SizeName = t("SizeName")
	t.close
	set t=nothing
else
	sizecode=SetAutoCode3("sizecode", "tSize", "")
end if
st1="width='15%' align=right"
st2="width='30%'"
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<script language="JavaScript">
function validate_form(){
	validity = true;
	if (!check_empty(document.form.sizecode.value)){
		validity = false; alert('您好，尺码编号不能为空!');
	}
	if (!check_empty(document.form.sizename.value)){ 
		validity = false; alert('您好，尺码名称不能为空!'); 
	}
	if (!check_empty(document.form.sizegroup.value)){ 
		validity = false; alert('您好，尺码组不能为空!'); 
	}
	if (!check_empty(document.form.rowposition.value)){ 
		validity = false; alert('您好，行位置不能为空!'); 
	}
	if (!check_empty(document.form.colposition.value)){ 
		validity = false; alert('您好，列位置不能为空!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>【尺码信息资料设置】</legend>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>尺码编号：</td>
<td width='30%'>
<input type="text" name="sizecode" value="<%=sizecode%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>尺码名称：</td>
<td width='30%'>
<input type="text" name="sizename" value="<%=SizeName%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>尺码组名称：</td>
<td width='30%' colspan="3">
	<%
	    if sizename="" and SizeGroup="" then
	        SizeGroup="衣服码"
	    end if
	%>
<input type="text" name="sizegroup" value="<%=SizeGroup%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>(如：衣服码、女装码、男装码）
</td>

</tr>
<tr><td width='15%' align=right>行位置：</td>
<td width='30%'>
<input type="text" name="rowposition" value="<%=rowposition%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>列位置：</td>
<td width='30%'>
<input type="text" name="colposition" value="<%=colposition%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
</table></fieldset><br>
<center>
<% if request("detail")<>"detail" then%>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>
<%end if%>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>