<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
Function SetDetail(aname, avalue, caption)
	aname1 = left(aname, len(aname) - 1)
	if aname = "ftdepot1" then
		if Instr(cklist, avalue)>0 then
			f_select = "checked"
		else
			f_select = ""
		end if
	else
		if aname = "ftcustom1" then
			if Instr(custlist, avalue)>0 then
				f_select = "checked"
			else
				f_select = ""
			end if
		else
		if Instr(qxlist, avalue)>0 then
			f_select = "checked"
		else
			f_select = ""
		end if
		end if
	end if
	response.write "<tr><td class=iefile><input class=dh type=checkbox name="&aname&" value="""&avalue&""" onclick=""checkItem(this, '"&aname1&"')"" "&f_select&">"&caption&"</td></tr>"
End Function
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script>
function checkAll(e, itemName){
var aa = document.getElementsByName(itemName);
for (var j=0; j<aa.length; j++)
aa[j].checked = e.checked;
}
function checkItem(e, allName){
var all = document.getElementsByName(allName)[0];
if(!e.checked) all.checked = false;
else{
var aa = document.getElementsByName(e.name);
for (var j=0; j<aa.length; j++)
if(!aa[j].checked) return;
all.checked = true;
}
}

function findObj(theObj, theDoc)
{
var p, i, foundObj;

if(!theDoc) theDoc = document;
if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
{
theDoc = parent.frames[theObj.substring(p+1)].document;
theObj = theObj.substring(0,p);
}
if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
for (i=0; !foundObj && i < theDoc.forms.length; i++) 
foundObj = theDoc.forms[i][theObj];
for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
foundObj = findObj(theObj,theDoc.layers[i].document);
if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);

return foundObj;
}
</script>
<style type="text/css">
#dh
{
 	cursor: pointer;
}
table{
	margin:0px;
	padding:0px;
	font-size:10pt;	
}
.folder{
	font-family: gb2312;
	font-size: 10pt;
	background-image: url(../images/txt_2.gif);
	background-repeat: repeat;
	background-position: left;
	padding-left: 45px;
	cursor: hand;
}
.collapsedFolder{
	font-family: gb2312;
	font-size: 10pt;
	background-image: url(../images/txt_1.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 45px;
	cursor: hand;
}
.collapsedFolder1{
	font-family: gb2312;
	font-size: 10pt;
	background-image: url(../images/c.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 40px;
	cursor: hand;
}
.submenu{
	padding-left: 18px;
}
.iefile{
	background-image: url(../images/ie.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 20px;
	font-family: gb2312;
	font-size: 10pt;
}
.iefile1{
	background-image: url(../images/ie.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 20px;
	font-family: gb2312;
	font-size: 10pt;
}
a {
	color: #003399;
	text-decoration: none;
}
a:hover{
	color: #FF0000;
	background-color: #eeeeee;
	border: 1px solid #006699;
}
body{
	font-size:10pt;
	font-family:微软雅黑;
	margin:0px;
	padding:0px;
}
.ctrlbar{
	border: 1px inset;
}
.explorer{
	background-color:#fff;
	background-image:url(../images/left_bg.gif);
	background-position:top;
	background-repeat:repeat;
}
.ctbutton{
	font-family: gb2312;
	font-size: 10pt;
	background-color: #ffffff;
	border-width: 1px;
	width: 9px;
	height: 100px;
	margin-bottom: 100px;
}
</style>
<script>
function checkall(){
	document.all.ftdepot.checked=document.all.checka.checked;
	checkAll(document.all('ftdepot'),'ftdepot1');
	document.all.bill.checked=document.all.checka.checked;
	checkAll(document.all('bill'),'bill1');
	document.all.tkc.checked=document.all.checka.checked;
	checkAll(document.all('tkc'),'tkc1');
	document.all.thp.checked=document.all.checka.checked;
	checkAll(document.all('thp'),'thp1');
	document.all.tdepot.checked=document.all.checka.checked;
	checkAll(document.all('tdepot'),'tdepot1');
	document.all.tcustom.checked=document.all.checka.checked;
	checkAll(document.all('tcustom'),'tcustom1');
}
</script>
<title>设置权限组</title>
<div style="font:bold 13px;float:left;padding:4px 0 0 4px;width:240px;height:360px;overflow:auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">

<input class=dh type=checkbox name="checka" value="" onclick=checkall()>全选、取消
<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('ftdepotm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="ftdepot" value="ftdepot" onclick=checkAll(this,'ftdepot1')>查看仓库权限</td></tr>
<tr><td class="submenu" id="ftdepotm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<%
set t = server.createobject("adodb.recordset")
	sql = "select * from dict_depot"
t.open sql, conn, 1, 1
while not t.eof 
	SetDetail "ftdepot1", "'"&t("depotname")&"'", t("depotname")
	t.movenext
wend
%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('billm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="bill" value="bill" onClick="checkAll(this, 'bill1')">单据权限</td></tr>
<tr><td class="submenu" id="billm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "bill1", "bill_find", "单据查询"%>
<% SetDetail "bill1", "bill_detail_find", "单据明细查询"%>
<% SetDetail "bill1", "bill_edit", "单据修改"%>
<% SetDetail "bill1", "bill_delete", "单据删除"%>
<% SetDetail "bill1", "bill_detail", "单据明细"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "tkc1", "kc_m", "库存管理"%>
<% SetDetail "tkc1", "kc_warning", "库存报警"%>
<% SetDetail "tkc1", "kc_select", "库存查询"%>
<% SetDetail "tkc1", "kc_count", "库存汇总"%>
<% SetDetail "tkc1", "kc_dcount", "仓库汇总"%>
<% SetDetail "tkc1", "kc_detail", "库存明细"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('thpm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="thp" value="thp" onClick="checkAll(this, 'thp1')">货品权限</td></tr>
<tr><td class="submenu" id="thpm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "thp1", "hp_m", "货品档案管理"%>
<% SetDetail "thp1", "hp_cate", "货品分类管理"%>
<% SetDetail "thp1", "hp_add", "货品添加"%>
<% SetDetail "thp1", "hp_edit", "货品修改"%>
<% SetDetail "thp1", "hp_delete", "货品删除"%>
<% SetDetail "thp1", "hp_detail", "货品详情"%>
<% SetDetail "thp1", "hp_find", "货品查询"%>
<% SetDetail "thp1", "hp_excel", "货品Excel"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tdepotm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="tdepot" value="tdepot" onclick=checkAll(this,'tdepot1')>仓库管理权限</td></tr>
<tr><td class="submenu" id="tdepotm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "tdepot1", "depot_m", "仓库档案管理"%>
<% SetDetail "tdepot1", "depot_add", "仓库添加"%>
<% SetDetail "tdepot1", "depot_edit", "仓库修改"%>
<% SetDetail "tdepot1", "depot_delete", "仓库删除"%>
<% SetDetail "tdepot1", "depot_detail", "仓库详情"%>
<% SetDetail "tdepot1", "depot_find", "仓库查询"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tcustomm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="tcustom" value="tcustom" onclick=checkAll(this,'tcustom1')>往来单位权限</td></tr>
<tr><td class="submenu" id="tcustomm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "tcustom1", "custom_m", "客户及供应商档案管理"%>
<% SetDetail "tcustom1", "custom_cate", "客户及供应商分类管理"%>
<% SetDetail "tcustom1", "custom_add", "客户及供应商添加"%>
<% SetDetail "tcustom1", "custom_edit", "客户及供应商修改"%>
<% SetDetail "tcustom1", "custom_delete", "客户及供应商删除"%>
<% SetDetail "tcustom1", "custom_detail", "客户及供应商详情"%>
<% SetDetail "tcustom1", "custom_find", "客户及供应商查询"%>
<% SetDetail "tcustom1", "custom_excel", "客户及供应商Excel导入"%>
</table></td></tr>

<!--<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('tkcm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/e.gif)':'url(images/c.gif)'}"></span><input type=checkbox name="tkc" value="tkc" onClick="checkAll(this, 'tkc1')">库存管理权限</td></tr>
<tr><td class="submenu" id="tkcm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">

</table></td></tr>-->

</table>
</div>
<div style="float:left;width:120px;height:360px;background:#ccc;over-flow:auto;text-align:center;">
	<form name="form" method="post" action="mtreehp_save.asp?table=<%=f_table%>" onSubmit="return validate_form()">
		<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">新增</div>
		<input style="background=#C9C9C9;" type="text" name="change_name" size="12" readonly><br>
		输入节点名称：<br>
		<input type="hidden" name="change_id" size="12">
		<input type="text" name="name" size="12"><br>
		<input type="radio" name="type1" value=1 checked>同级
		<input type="radio" name="type1" value=2 checked>下级<br>
		<input type="submit" name="submit" value="保存">
		<input type="button" name="close" value="关闭" onclick=window.opener=null;window.close()>
	</form><br><br><br>
	<div style="text-align:left;margin-left:10pt;color:#0000FF;font:14px bold">编辑</div>
	<input style="background=#C9C9C9;" type="text" name="change_name1" size="12" readonly><br>
	节点新名称：<br>
	<input type="hidden" name="change_id1" size="12">
	<input type="text" name="name1" size="12"><br>
	<input type="button" name="save" value="保存" onclick=goedit()>
	<input type="button" name="delete" value="删除" onclick=godelete()>
</div>