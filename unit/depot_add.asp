<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
'Request.ServerVariables("SCRIPT_NAME") 

dTitle = "�������������á�"
cklist = request.cookies("cklist")
DepotName = request("DepotName")
action = "depot_save.asp"
if DepotName <> "" then
	action = action&"?DepotName="&server.urlencode(DepotName)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tDepot where DepotName='"&DepotName&"'"
	t.open sql, conn, 1, 1
	DepotName = t("DepotName")
	Address = t("Address")
	DepotMan = t("DepotMan")
	Mobile = t("Mobile")
	pDepotName = t("pDepotName")
	Phone = t("Phone")
	pRemark = t("pRemark")

	
	Remark = t("Remark")
	seqno=t("seqno")
	t.close
	set t=nothing
else
end if
st1="width='15%' align=right"
st2="width='30%'"


%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script language="JavaScript">
function validate_form(){
	validity = true;
	if (!check_empty(document.form.DepotName.value)){
		validity = false; alert('�������Ʋ���Ϊ��!');
	}
	if (!check_empty(document.form.pDepotName.value)){
		//validity = false; alert('СƱ��ʾ���Ʋ���Ϊ��!');
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>�������������á�</legend>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>�������ƣ�</td>
<td width='30%' colspan=3>
<input type="text" name="DepotName" value="<%=DepotName%>" size=60><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>���̸����ˣ�</td>
<td width='30%' colspan=3>
<input type="text" name="DepotMan" value="<%=DepotMan%>" size=12>
&nbsp;&nbsp;&nbsp;�������ֻ���
<input type="text" name="Mobile" value="<%=Mobile%>" size=12>
</td>
</tr>
<tr><td width='15%' align=right>��ϵ�绰��</td>
<td width='30%'>
<input type="text" name="Phone" value="<%=Phone%>" size=12>
&nbsp;&nbsp;&nbsp;�� ʾ ˳ ��<input type="text" name="seqno" value="<%=seqno%>" size=12>
<td width='30%'>
</td>
<td width='15%' align=left></td>

</td></tr>
<tr><td width='15%' align=right>���̵�ַ��</td>
<td width='30%' colspan=3>
<input type="text" name="Address" value="<%=Address%>" size=60>
</td>
</tr>
<tr><td width='15%' align=right>��ע��</td>
<td colspan="3">
<textarea name="Remark" cols="60" rows="2" wrap="VIRTUAL"><%=Remark%></textarea>
</td></tr>
<!--
<tr><td width='15%' align=right>СƱ��ʾ���ƣ�</td>
<td width='30%' colspan=3>
<input type="text" name="pDepotName" value="<%=pDepotName%>" size=60><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>СƱ��ʾ��ע��</td>
<td colspan="3">
<textarea name="pRemark" cols="60" rows="2" wrap="VIRTUAL"><%=DepotName%></textarea>
</td></tr>
-->
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