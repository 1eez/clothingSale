<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
qxlist = request.cookies("qxlist")
cklist = request.cookies("cklist")
auser = request("loginname")
tablename = request("tablename")
if tablename="" then
	tablename="商品单位"
end if
treecode = request("treecode")
treename = request("treename")
if treename<>"" then
	if treecode<>"" then
		treecodename = treecode&"-"&treename
	else
		treecodename = treename
	end if
end if
%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/public.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script>
function settreename(el){
var treecode,treename
	treecode=el.value.substr(0, el.value.indexOf("-"))
	treename=el.value.substr(el.value.indexOf("-")+1, 10000)
	document.all.treecode.value=treecode;
	document.all.treename.value=treename;
	document.all.treecodename.value=el.value
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
<title>类别管理</title>
<fieldset style="width:auto;"><legend>下拉菜单管理</legend>
<div style="padding-top:4px;">
<input class="dh" type="button" value="款式" onClick="location.href='combo.asp?tablename=款式'">
<input class="dh" type="button" value="颜色" onClick="location.href='combo.asp?tablename=颜色'">
<input class="dh" type="button" value="商品单位" onClick="location.href='combo.asp?tablename=商品单位'">
<input class="dh" type="button" value="季节管理" onClick="location.href='combo.asp?tablename=季节管理'">
<input class="dh" type="button" value="品牌" onClick="location.href='combo.asp?tablename=品牌'">

<input class="dh" type="button" value="供应商" onClick="location.href='combo.asp?tablename=供应商'">
<input class="dh" type="button" value="摘要信息" onClick="location.href='combo.asp?tablename=摘要信息'">
</div>
<div style="float:left;width:360px;height:500px;overflow:auto;border:1px solid #000000;">
<%
SetBasic tablename,"treecode","treename","treecodename"
%>
</div>
<div style="float:left;width:220px;height:500px;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="combo_save.asp?tablename=<%=tablename%>" onSubmit="return validate_form()">
原始名称：<br><input style="background=#C9C9C9;" type="text" name="treecodename" size="12" readonly value="<%=treecodename%>"><br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">新增</div>
输入节点名称：<br>
<input type="hidden" name="tablename" value="<%=tablename%>">
<input type="hidden" name="treecode" size="12" value="<%=treecode%>">
<input type="hidden" name="catetype" value="添加">
<input type="hidden" name="treename" size="12" value="<%=treename%>">
<input type="text" name="addtreename" size="12"><br>
<input class=dh type="submit" name="submit" value="保存">
</form><br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">编辑</div>
输入新名称：<br>
<input type="text" name="edittreename" size="12"><br>
<input class=dh type="button" name="save" value="保存" onclick=gocomboedit()>
<br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">删除</div>
<input class=dh type="button" name="delete" value="删除" onclick=gocombodelete()>
</div>
</html>