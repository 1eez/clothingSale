<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "��������Ϣ�������á�"
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
		validity = false; alert('���ã������Ų���Ϊ��!');
	}
	if (!check_empty(document.form.sizename.value)){ 
		validity = false; alert('���ã��������Ʋ���Ϊ��!'); 
	}
	if (!check_empty(document.form.sizegroup.value)){ 
		validity = false; alert('���ã������鲻��Ϊ��!'); 
	}
	if (!check_empty(document.form.rowposition.value)){ 
		validity = false; alert('���ã���λ�ò���Ϊ��!'); 
	}
	if (!check_empty(document.form.colposition.value)){ 
		validity = false; alert('���ã���λ�ò���Ϊ��!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>��������Ϣ�������á�</legend>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>�����ţ�</td>
<td width='30%'>
<input type="text" name="sizecode" value="<%=sizecode%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>�������ƣ�</td>
<td width='30%'>
<input type="text" name="sizename" value="<%=SizeName%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>���������ƣ�</td>
<td width='30%' colspan="3">
	<%
	    if sizename="" and SizeGroup="" then
	        SizeGroup="�·���"
	    end if
	%>
<input type="text" name="sizegroup" value="<%=SizeGroup%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>(�磺�·��롢Ůװ�롢��װ�룩
</td>

</tr>
<tr><td width='15%' align=right>��λ�ã�</td>
<td width='30%'>
<input type="text" name="rowposition" value="<%=rowposition%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>��λ�ã�</td>
<td width='30%'>
<input type="text" name="colposition" value="<%=colposition%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
</table></fieldset><br>
<center>
<% if request("detail")<>"detail" then%>
<input class=dh type="submit" value="����" name=submit>
<input class=dh type="reset" value="����" name=reset>
<%end if%>
<input class=dh type="button" value="�ر�" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>