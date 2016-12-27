<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
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
<title></title>
<fieldset style="width:auto;"><legend>用户权限设置</legend>
<div style="float:left;width:220px;height:500px;border:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="userqx.asp?username=" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='40%' align=right>用户名称：</td>
<td colspan="3">
<input name="username" type="text" value="" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td></tr>
<tr><td width='40%' align=right>密码：</td>
<td colspan="3">
<input name="password" type="password" value="" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td></tr>
<tr><td width='40%' align=right>用户类型：</td>
<td colspan="3">
<select name=type style=width:auto;><option value="用户" >用户</option><option value="权限组" >权限组</option></select>
</td></tr>
<tr><td width='40%' align=right>隶属权限：</td>
<td colspan="3">
<select name=qxgroup style=width:auto;><option></option><option value="admin" >admin</option><option value="user" >user</option><option value="PP" >PP</option><option value="1123422" >1123422</option></select>
</td></tr>
<tr><td colspan=4 align=center>

<input class=dh name="submit" type="submit" value="保存" />

<input class=dh name="close" type="button" value="关闭" onclick=window.opener=null;window.close();></td></tr>
</table>
</div>
<div style="float:left;width:360px;height:500px;overflow:auto;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">

<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a_0').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input onclick=checkall() id=allcheck type=checkbox name=qxname value=-|><a class=tree href='javascript:' value=用户权限 onclick=settreename(this,'treecode','treename','treecodename')>用户权限</a>
<tr><td class="submenu" id="a_0" style="">
<table border="0" cellspacing="0" cellpadding="0">

		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a01').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='cym;' ><a class=tree href='javascript:' value=常用查询 onclick=settreename(this,'treecode','treename','treecodename')>常用查询</a></td></tr>
<tr><td class="submenu" id="a01" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockfind;" ><a class=tree href='javascript:' value=库存查询 onclick=settreename(this,'treecode','treename','treecodename')>库存查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockhpfind;" ><a class=tree href='javascript:' value=库存查询-尺码横排 onclick=settreename(this,'treecode','treename','treecodename')>库存查询-尺码横排</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockcount;" ><a class=tree href='javascript:' value=进销存汇总 onclick=settreename(this,'treecode','treename','treecodename')>进销存汇总</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="billfind;" ><a class=tree href='javascript:' value=单据查询 onclick=settreename(this,'treecode','treename','treecodename')>单据查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="billdetailfind;" ><a class=tree href='javascript:' value=单据明细查询 onclick=settreename(this,'treecode','treename','treecodename')>单据明细查询</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a02').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='cgm;' ><a class=tree href='javascript:' value=采购管理 onclick=settreename(this,'treecode','treename','treecodename')>采购管理</a></td></tr>
<tr><td class="submenu" id="a02" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_add;" ><a class=tree href='javascript:' value=新增采购单 onclick=settreename(this,'treecode','treename','treecodename')>新增采购单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_edit;" ><a class=tree href='javascript:' value=修改采购单 onclick=settreename(this,'treecode','treename','treecodename')>修改采购单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_del;" ><a class=tree href='javascript:' value=删除采购单 onclick=settreename(this,'treecode','treename','treecodename')>删除采购单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_find;" ><a class=tree href='javascript:' value=采购单查询 onclick=settreename(this,'treecode','treename','treecodename')>采购单查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbilldetail_find;" ><a class=tree href='javascript:' value=采购单明细查询 onclick=settreename(this,'treecode','treename','treecodename')>采购单明细查询</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a03').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='xsm;' ><a class=tree href='javascript:' value=销售管理 onclick=settreename(this,'treecode','treename','treecodename')>销售管理</a></td></tr>
<tr><td class="submenu" id="a03" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_add;" ><a class=tree href='javascript:' value=新增销售单 onclick=settreename(this,'treecode','treename','treecodename')>新增销售单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_edit;" ><a class=tree href='javascript:' value=修改销售单 onclick=settreename(this,'treecode','treename','treecodename')>修改销售单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_del;" ><a class=tree href='javascript:' value=删除销售单 onclick=settreename(this,'treecode','treename','treecodename')>删除销售单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_find;" ><a class=tree href='javascript:' value=销售单查询 onclick=settreename(this,'treecode','treename','treecodename')>销售单查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbilldetail_find;" ><a class=tree href='javascript:' value=销售明细查询 onclick=settreename(this,'treecode','treename','treecodename')>销售明细查询</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a04').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='dbm;' ><a class=tree href='javascript:' value=调拨管理 onclick=settreename(this,'treecode','treename','treecodename')>调拨管理</a></td></tr>
<tr><td class="submenu" id="a04" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_add;" ><a class=tree href='javascript:' value=新增调拨单 onclick=settreename(this,'treecode','treename','treecodename')>新增调拨单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_edit;" ><a class=tree href='javascript:' value=修改调拨单 onclick=settreename(this,'treecode','treename','treecodename')>修改调拨单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_del;" ><a class=tree href='javascript:' value=删除调拨单 onclick=settreename(this,'treecode','treename','treecodename')>删除调拨单</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_find;" ><a class=tree href='javascript:' value=调拨单查询 onclick=settreename(this,'treecode','treename','treecodename')>调拨单查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbilldetail_find;" ><a class=tree href='javascript:' value=调拨单明细查询 onclick=settreename(this,'treecode','treename','treecodename')>调拨单明细查询</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a05').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='qcm;' ><a class=tree href='javascript:' value=期初管理 onclick=settreename(this,'treecode','treename','treecodename')>期初管理</a></td></tr>
<tr><td class="submenu" id="a05" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_add;" ><a class=tree href='javascript:' value=新增期初录入 onclick=settreename(this,'treecode','treename','treecodename')>新增期初录入</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_edit;" ><a class=tree href='javascript:' value=修改期初录入 onclick=settreename(this,'treecode','treename','treecodename')>修改期初录入</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_del;" ><a class=tree href='javascript:' value=删除期初录入 onclick=settreename(this,'treecode','treename','treecodename')>删除期初录入</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_find;" ><a class=tree href='javascript:' value=期初单查询 onclick=settreename(this,'treecode','treename','treecodename')>期初单查询</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbilldetail_find;" ><a class=tree href='javascript:' value=期初明细查询 onclick=settreename(this,'treecode','treename','treecodename')>期初明细查询</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a06').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='jcm;' ><a class=tree href='javascript:' value=基础资料 onclick=settreename(this,'treecode','treename','treecodename')>基础资料</a></td></tr>
<tr><td class="submenu" id="a06" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="depotm;" ><a class=tree href='javascript:' value=店铺资料管理 onclick=settreename(this,'treecode','treename','treecodename')>店铺资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="goodsm;" ><a class=tree href='javascript:' value=商品资料管理 onclick=settreename(this,'treecode','treename','treecodename')>商品资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="custm;" ><a class=tree href='javascript:' value=往来单位管理 onclick=settreename(this,'treecode','treename','treecodename')>往来单位管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="empm;" ><a class=tree href='javascript:' value=员工资料管理 onclick=settreename(this,'treecode','treename','treecodename')>员工资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="vipm;" ><a class=tree href='javascript:' value=VIP资料管理 onclick=settreename(this,'treecode','treename','treecodename')>VIP资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="colorm;" ><a class=tree href='javascript:' value=颜色资料管理 onclick=settreename(this,'treecode','treename','treecodename')>颜色资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="sizem;" ><a class=tree href='javascript:' value=尺码资料管理 onclick=settreename(this,'treecode','treename','treecodename')>尺码资料管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="catem;" ><a class=tree href='javascript:' value=类别设置 onclick=settreename(this,'treecode','treename','treecodename')>类别设置</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="combom;" ><a class=tree href='javascript:' value=下拉框设置 onclick=settreename(this,'treecode','treename','treecodename')>下拉框设置</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a07').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='xtsz;' ><a class=tree href='javascript:' value=系统设置 onclick=settreename(this,'treecode','treename','treecodename')>系统设置</a></td></tr>
<tr><td class="submenu" id="a07" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="userm;" ><a class=tree href='javascript:' value=操作员管理 onclick=settreename(this,'treecode','treename','treecodename')>操作员管理</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cleardata;" ><a class=tree href='javascript:' value=系统初始化 onclick=settreename(this,'treecode','treename','treecodename')>系统初始化</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="changepass;" ><a class=tree href='javascript:' value=修改密码 onclick=settreename(this,'treecode','treename','treecodename')>修改密码</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="backup;" ><a class=tree href='javascript:' value=数据备份 onclick=settreename(this,'treecode','treename','treecodename')>数据备份</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="optionset;" ><a class=tree href='javascript:' value=选项设置 onclick=settreename(this,'treecode','treename','treecodename')>选项设置</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="mangelog;" ><a class=tree href='javascript:' value=操作日志 onclick=settreename(this,'treecode','treename','treecodename')>操作日志</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="coinfo;" ><a class=tree href='javascript:' value=公司概况 onclick=settreename(this,'treecode','treename','treecodename')>公司概况</a></td></tr></table></td></tr></table></td></tr>
</table>

</div>
</fieldset>
<br>
</form>
</html>
