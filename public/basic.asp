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
	tablename="商品类别"
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
<fieldset style="width:auto;"><legend>类别管理</legend>
<div style="padding-top:4px;">
<input class="dh" type="button" value="商品类别管理" onClick="location.href='basic.asp?tablename=商品类别'">
<input class="dh" type="button" value="公司类别管理" onClick="location.href='basic.asp?tablename=公司类别'">
<input class="dh" type="button" value="部门管理" onClick="location.href='basic.asp?tablename=部门'">
<input class="dh" type="button" value="地区" onClick="location.href='basic.asp?tablename=地区'">
</div>
<div style="float:left;width:360px;height:500px;overflow:auto;border:1px solid #000000;">
<%
SetBasic tablename,"treecode","treename","treecodename"
%>
</div>
<div style="float:left;width:220px;height:500px;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="basic_save.asp?tablename=<%=tablename%>" onSubmit="return validate_form()">
原始名称：<br><input style="background=#C9C9C9;" type="text" name="treecodename" size="12" readonly value="<%=treecodename%>"><br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">新增</div>
输入节点名称：<br>
<input type="hidden" name="tablename" value="<%=tablename%>">
<input type="hidden" name="treecode" size="12" value="<%=treecode%>">
<input type="hidden" name="catetype" value="添加">
<input type="hidden" name="treename" size="12" value="<%=treename%>">
<input type="text" id="setfocus" name="addtreename" size="12"><br>
<input type="radio" name="type1" value=1 checked>同级
<input type="radio" name="type1" value=2 checked>下级<br>
<input class=dh type="submit" name="submit" value="保存">
</form><br><hr>
<script>
document.getElementById("setfocus").focus();
document.getElementById("setfocus").select();
</script>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">编辑</div>
输入新名称：<br>
<input type="text" name="edittreename" size="12"><br>
<input class=dh type="button" name="save" value="保存" onclick=goedit()>
<br><hr>
<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">删除</div>
<input class=dh type="button" name="delete" value="删除" onclick=godelete()>
</div>
</html>