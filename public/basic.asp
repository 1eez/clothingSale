<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
qxlist = request.cookies("qxlist")
cklist = request.cookies("cklist")
auser = request("loginname")
tablename = request("tablename")
treecode = request("treecode")
treename = request("treename")
if treename<>"" then
	if treecode<>"" then
		treecodename = treecode&"-"&treename
	else
		treecodename = treename
	end if
end if
if tablename="" then
	tablename="��Ʒ���"
end if
%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/public.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script>
function validate_form(){
	validity = true;
	if (!check_empty(document.form.addtreename.value)){
		validity = false; alert('��ӵĽڵ����Ʋ���Ϊ�գ���������¼��!');
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<title>������</title>
<fieldset style="width:auto;"><legend>������</legend>
<div style="padding-top:4px;">
<input class="dh" type="button" value="��Ʒ������" onClick="location.href='basic.asp?tablename=��Ʒ���'">
<input class="dh" type="button" value="��˾������" onClick="location.href='basic.asp?tablename=��˾���'">
<input class="dh" type="button" value="���Ź���" onClick="location.href='basic.asp?tablename=����'">
<input class="dh" type="button" value="����" onClick="location.href='basic.asp?tablename=����'">
</div>
<div style="float:left;width:360px;height:500px;overflow:auto;border:1px solid #000000;">
<%
SetBasic tablename,"treecode","treename","treecodename"
%>
</div>
<div style="float:left;width:220px;height:500px;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="basic_save.asp?tablename=<%=tablename%>" onSubmit="return validate_form()">
ԭʼ���ƣ�<br><input style="background=#C9C9C9;" type="text" name="treecodename" size="12" readonly value="<%=treecodename%>"><br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">����</div>
����ڵ����ƣ�<br>
<input type="hidden" name="tablename" value="<%=tablename%>">
<input type="hidden" name="treecode" size="12" value="<%=treecode%>">
<input type="hidden" name="catetype" value="���">
<input type="hidden" name="treename" size="12" value="<%=treename%>">
<input type="text" id="setfocus" name="addtreename" size="12"><br>
<input type="radio" name="type1" value=1 checked>ͬ��
<input type="radio" name="type1" value=2 checked>�¼�<br>
<input class=dh type="submit" name="submit" value="����">
</form><br><hr>
<script>
document.getElementById("setfocus").focus();
document.getElementById("setfocus").select();
</script>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">�༭</div>
���������ƣ�<br>
<input type="text" name="edittreename" size="12"><br>
<input class=dh type="button" name="save" value="����" onclick=goedit()>
<br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">ɾ��</div>
<input class=dh type="button" name="delete" value="ɾ��" onclick=godelete()>
</div>
</html>