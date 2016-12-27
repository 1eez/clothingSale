<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【颜色信息资料设置】"
cklist = request.cookies("cklist")
colorcode = request("colorcode")
action = "color_save.asp"
if colorcode <> "" then
	action = action&"?colorcode="&server.urlencode(colorcode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tColor where colorcode='"&colorcode&"'"
	t.open sql, conn, 1, 1
		colorcode = t("colorcode")
		colorname = t("colorname")
	t.close
	set t=nothing
else
	colorcode=SetAutoCode3("colorcode", "tcolor", "")
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
	if (!check_empty(document.form.colorcode.value)){
		validity = false; alert('您好，颜色编号不能为空!');
	}
	if (!check_empty(document.form.colorname.value)){ 
		validity = false; alert('您好，颜色名称不能为空!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>【颜色信息资料设置】</legend>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>颜色编号：</td>
<td width='30%'>
<input type="text" name="colorcode" value="<%=colorcode%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>颜色名称：</td>
<td width='30%'>
<input type="text" name="colorname" value="<%=colorname%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
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