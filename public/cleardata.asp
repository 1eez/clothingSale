<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
qxlist = request.cookies("qxlist")
cklist = request.cookies("cklist")
auser = request("loginname")
tablename = request("tablename")
if tablename="" then
	tablename="数据初始化"
end if
if request("submit")="数据初始化" then
	conn.BeginTrans
	on error resume next
		qxname = request("qxname")
		qxname = replace(qxname,"-|,","")
		qxname = replace(qxname,", ","")
		qxname=split(qxname,";")
		for i=0 to ubound(qxname)
			if qxname(i)<>"" then
				conn.execute qxname(i)
			end if
		next
	if err.number=0 then
		manageLog "数据初始化"
		conn.CommitTrans
		Response.Write"<script>alert('数据初始化成功！')</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/public.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script>
function checkAll(e, itemName){
	var aa = document.getElementsByName(itemName);
	for (var j=0; j<aa.length; j++)
	aa[j].checked = e.checked;
}
function checkall(){
	document.all.allcheck.checked=document.all.allcheck.checked;
	checkAll(document.all('allcheck'),'allcheck1');
}
function validate_form(){
	validity = true;
	if (!check_empty(document.form.addtreename.value)){
		validity = false; alert('添加的节点名称不能为空，请您重新录入!');
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<title><%=tablename%></title>
<fieldset style="width:auto;"><legend>【<%=tablename%>】</legend>
<form action="cleardata.asp" method="post">
<input type=hidden name=ptype value="printd">
<%
SetBasicCheckBox tablename,"treecode","treename","treecodename"
%>
</fieldset><br>
<input class=dh type=submit name="submit" value="数据初始化">
</form>
</html>