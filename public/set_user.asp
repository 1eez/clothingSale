<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
qxlist = request.cookies("qxlist")
cklist = request.cookies("cklist")
auser = request("loginname")
Function SetDetail(aname, avalue, caption)
	response.write "<tr><td class=iefile><a href='#'>"&caption&"</a></td></tr>"
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
if(all!=undefined){
if(!e.checked)
{
all.checked = false;
}
else{
var aa = document.getElementsByName(e.name);
for (var j=0; j<aa.length; j++)
if(!aa[j].checked) return;
all.checked = true;
}
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
	document.all.sjcxm.checked=document.all.checka.checked;
	checkAll(document.all('sjcxm'),'sjcx1');
	document.all.fkcglm.checked=document.all.checka.checked;
	checkAll(document.all('fkcglm'),'kcgl1');
	document.all.kcbbm.checked=document.all.checka.checked;
	checkAll(document.all('kcbbm'),'kcbb1');
	document.all.cgbbm.checked=document.all.checka.checked;
	checkAll(document.all('cgbbm'),'cgbb1');
	document.all.lybbm.checked=document.all.checka.checked;
	checkAll(document.all('lybbm'),'lybb1');
	document.all.screport.checked=document.all.checka.checked;
	checkAll(document.all('screport'),'screp1');
	document.all.zcreport.checked=document.all.checka.checked;
	checkAll(document.all('zcreport'),'zcrep1');
	document.all.xsbbm.checked=document.all.checka.checked;
	checkAll(document.all('xsbbm'),'xsbb1');
	document.all.jczlm.checked=document.all.checka.checked;
	checkAll(document.all('jczlm'),'jczl1');
	document.all.xtszm.checked=document.all.checka.checked;
	checkAll(document.all('xtszm'),'xtsz1');
}
</script>
<title>设置权限</title>
<table width="100%" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('a01').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>数据初始化</td></tr>
<tr><td class="submenu" id="a01" style="">
<table border="0" cellspacing="0" cellpadding="0">
<%
set rs=server.createobject("adodb.recordset")
q = "select * from dict_cate where tablename='数据初始化' order by code asc"
rs.open q, conn, 1, 1
node1 = len(rs("code"))
code1 = rs("code")
name1 = rs("name")
rs.movenext
while not rs.eof	
	node2 = len(rs("code"))
	code2 = rs("code")
	name2 = rs("name")
	if node1=node2 then
		SetDetail "sjcxm1", "'"&name1&"'", name1
	end if	
	if node2-node1=2 then
		%>
        <tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('<%="a"&code1%>').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><a href='#'><%=name1%></a></td></tr>
<tr><td class="submenu" id="<%="a"&code1%>" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
        <%
	end if
	for i = 1 to (node1-node2)/2
		if i=1 then
			SetDetail "sjcxm1", "'"&name1&"'", name1
		end if
	    response.write "</table></td></tr>"
	next
	node3 = node1
	code3 = code1
	name3 = name1
	node1 = node2
	code1 = code2
	name1 = name2
	rs.movenext
wend
	if node3=node2 then
		SetDetail "sjcxm1", "'"&name2&"'", name2
	end if	
	if node3-node2=2 then
		SetDetail "sjcxm1", "'"&name2&"'", name2
	end if	
	for i = 1 to (node3-node2)/2
    	response.write "</table></td></tr>"
	next
%>
</table></td></tr>
</table>
<%
response.end
%>
<form name="form" method="post" action="set_user_save.asp">
<div style="font:bold 13px;float:left;padding:4px 0 0 4px;width:340px;height:640px;overflow:auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">

<input class=dh type=checkbox name="checka" value="" onclick=checkall()>全选、取消
<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('ftdepotm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="ftdepot" value="ftdepot" onclick=checkAll(this,'ftdepot1') <% if instr(cklist,"ftdepot")>0 then response.write "checked" end if %>>查看仓库权限</td></tr>
<tr><td class="submenu" id="ftdepotm" style="">
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

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('sjcxm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="sjcx1" value="sjcx1" onClick="checkAll(this, 'sjcx1')" <% if instr(qxlist,"sjcx1")>0 then response.write "checked" end if %>>数据查询</td></tr>
<tr><td class="submenu" id="sjcxm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "sjcx1", "sjcx_m", "数据查询管理"%>
<% SetDetail "sjcx1", "kc_find", "库存查询"%>
<% SetDetail "sjcx1", "bill_find", "单据查询"%>
<% SetDetail "sjcx1", "bill_detail_find", "单据明细查询"%>
<% SetDetail "sjcx1", "bill_ddetail_find", "单据明细表查询"%>
<% SetDetail "sjcx1", "bill_edit", "单据修改"%>
<% SetDetail "sjcx1", "see_money", "查看单价、金额"%>
<% SetDetail "sjcx1", "bill_delete", "单据删除"%>
<% SetDetail "sjcx1", "bill_detail", "单据详情"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('fkcglm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="kcgl1" value="kcgl" onClick="checkAll(this, 'kcgl1')" <% if instr(qxlist,"kcgl")>0 then response.write "checked" end if %>>库存管理</td></tr>
<tr><td class="submenu" id="fkcglm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "kcgl1", "kc_m", "库存管理"%>
<% SetDetail "kcgl1", "rk_add", "新增入库单"%>
<% SetDetail "kcgl1", "ck_add", "新增出库单"%>
<% SetDetail "kcgl1", "db_add", "新增调拨单"%>
<% SetDetail "kcgl1", "pd_add", "新增盘点单"%>
<% SetDetail "kcgl1", "zz_add", "新增组装单"%>
<% SetDetail "kcgl1", "cx_add", "新增拆卸单"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('kcbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="kcbb1" value="kcbb" onClick="checkAll(this, 'kcbb1')" <% if instr(qxlist,"kcbb")>0 then response.write "checked" end if %>>库存报表</td></tr>
<tr><td class="submenu" id="kcbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "kcbb1", "kc_bm", "库存报表管理"%>
<% SetDetail "kcbb1", "kc_ph", "库存平衡表"%>
<% SetDetail "kcbb1", "kc_count", "库存汇总"%>
<% SetDetail "kcbb1", "kc_warning", "库存报警"%>
<% SetDetail "kcbb1", "kc_cfind", "分仓汇总"%>
<% SetDetail "kcbb1", "kc_nfind", "分仓库存汇总"%>
<% SetDetail "kcbb1", "kc_parentKind", "库存大类汇总"%>
<% SetDetail "kcbb1", "kc_depot", "仓库汇总"%>
<% SetDetail "kcbb1", "kc_detail", "库存明细"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('cgbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="cgbb1" value="cgbb" onClick="checkAll(this, 'cgbb1')" <% if instr(qxlist,"cgbb")>0 then response.write "checked" end if %>>采购报表</td></tr>
<tr><td class="submenu" id="cgbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "cgbb1", "cg_bbm", "采购报表管理"%>
<% SetDetail "cgbb1", "supply_count", "供应商采购汇总表"%>
<% SetDetail "cgbb1", "supply_detail", "供应商采购明细表"%>
<% SetDetail "cgbb1", "goods_count", "货品采购汇总表"%>
<% SetDetail "cgbb1", "goods_detail", "货品采购明细表"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('xsbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xsbb1" value="xsbb" onClick="checkAll(this, 'xsbb1')" <% if instr(qxlist,"xsbb")>0 then response.write "checked" end if %>>销售报表</td></tr>
<tr><td class="submenu" id="xsbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xsbb1", "xs_bbm", "销售报表管理"%>
<% SetDetail "xsbb1", "custom_count", "客户销售汇总表"%>
<% SetDetail "xsbb1", "custom_detail", "客户销售明细表"%>
<% SetDetail "xsbb1", "goods1_count", "货品销售汇总表"%>
<% SetDetail "xsbb1", "goods1_detail", "货品销售明细表"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('lybbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="lybb1" value="lybb" onClick="checkAll(this, 'lybb1')" <% if instr(qxlist,"lybb")>0 then response.write "checked" end if %>>领用报表</td></tr>
<tr><td class="submenu" id="lybbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "lybb1", "ly_bbm", "领用报表管理"%>
<% SetDetail "lybb1", "depart_count", "部门领用汇总表"%>
<% SetDetail "lybb1", "depart_detail", "部门领用明细表"%>
<% SetDetail "lybb1", "goodsly_count", "货品领用汇总表"%>
<% SetDetail "lybb1", "goodsly_detail", "货品领用明细表"%>
<% SetDetail "lybb1", "db_count", "货品调拨汇总表"%>
<% SetDetail "lybb1", "db_detail", "货品调拨明细表"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('screport').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input class=dh type=checkbox name="screp1" value="screp" onClick="checkAll(this, 'screp1')" <% if instr(qxlist,"screp")>0 then response.write "checked" end if %>>生产报表</td></tr>
<tr><td class="submenu" id="screport" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "screp1", "sc_rm", "生成报表管理"%>
<% SetDetail "screp1", "sc_count", "部门生产汇总表"%>
<% SetDetail "screp1", "sc_detail", "部门生产明细表"%>
<% SetDetail "screp1", "sc_goodsCount", "货品生产汇总表"%>
<% SetDetail "screp1", "sc_goodsDetail", "货品生产明细表"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('zcreport').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input class=dh type=checkbox name="zcrep1" value="zcrep" onClick="checkAll(this, 'zcrep1')" <% if instr(qxlist,"zcrep")>0 then response.write "checked" end if %>>组装、拆卸报表</td></tr>
<tr><td class="submenu" id="zcreport" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "zcrep1", "zc_rm", "生成报表管理"%>
<% SetDetail "zcrep1", "zc_count", "组、拆成品汇总表"%>
<% SetDetail "zcrep1", "zc_detail", "组、拆成品明细表"%>
<% SetDetail "zcrep1", "zc1_count", "组、拆原料汇总表"%>
<% SetDetail "zcrep1", "zc1_detail", "组、拆原料明细表"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('jczlm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="jczl" onClick="checkAll(this, 'jczl1')" <% if instr(qxlist,"jczl")>0 then response.write "checked" end if %>>基础资料</td></tr>
<tr><td class="submenu" id="jczlm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "jczl_m", "基础资料管理"%>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('hpzl_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="hpzl_m" <% if instr(qxlist,"hpzl_m")>0 then response.write "checked" end if %>>货品资料</td></tr>
<tr><td class="submenu" id="hpzl_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "hp_add", "新增货品"%>
<% SetDetail "jczl1", "hp_edit", "修改货品"%>
<% SetDetail "jczl1", "hp_detail", "货品详情"%>
<% SetDetail "jczl1", "hp_delete", "货品删除"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('wldw_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="wldw_m" <% if instr(qxlist,"wldw_m")>0 then response.write "checked" end if %>>往来单位</td></tr>
<tr><td class="submenu" id="wldw_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "custom_add", "新增往来单位"%>
<% SetDetail "jczl1", "custom_edit", "修改往来单位"%>
<% SetDetail "jczl1", "custom_detail", "往来单位详情"%>
<% SetDetail "jczl1", "custom_delete", "往来单位删除"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('ck_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="ck_m" <% if instr(qxlist,"ck_m")>0 then response.write "checked" end if %>>仓库</td></tr>
<tr><td class="submenu" id="ck_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "depot_add", "新增仓库"%>
<% SetDetail "jczl1", "depot_edit", "修改仓库"%>
<% SetDetail "jczl1", "depot_detail", "仓库详情"%>
<% SetDetail "jczl1", "depot_delete", "仓库删除"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('emp_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="emp_m" <% if instr(qxlist,"emp_m")>0 then response.write "checked" end if %>>员工</td></tr>
<tr><td class="submenu" id="emp_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "emp_add", "新增员工"%>
<% SetDetail "jczl1", "emp_edit", "修改员工"%>
<% SetDetail "jczl1", "emp_detail", "员工详情"%>
<% SetDetail "jczl1", "emp_delete", "员工删除"%>
</table></td></tr>

<% SetDetail "jczl1", "jc_m", "基础信息"%>
<% SetDetail "jczl1", "zz_mb", "组装模板"%>
<% SetDetail "jczl1", "hp_start", "期初录入"%>
<% SetDetail "jczl1", "hp_export", "Excel货品分析导入"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('xtszm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xtsz1" value="xtsz" onClick="checkAll(this, 'xtsz1')" <% if instr(qxlist,"xtsz")>0 then response.write "checked" end if %>>系统设置</td></tr>
<tr><td class="submenu" id="xtszm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xtsz1", "xtsz_m", "系统设置管理"%>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('czy_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xtsz1" value="czy_m" <% if instr(qxlist,"czy_m")>0 then response.write "checked" end if %>>操作员管理</td></tr>
<tr><td class="submenu" id="czy_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xtsz1", "user_add", "新增操作员"%>
<% SetDetail "xtsz1", "user_edit", "修改操作员"%>
<% SetDetail "xtsz1", "user_detail", "操作员详情"%>
<% SetDetail "xtsz1", "user_delete", "操作员删除"%>
<% SetDetail "xtsz1", "user_qx", "操作员权限"%>
</table></td></tr>

<% SetDetail "xtsz1", "year_carry_m", "年终结转"%>
<% SetDetail "xtsz1", "oldbill_find", "过往单据查询"%>
<% SetDetail "xtsz1", "xtcsh_m", "系统初始化"%>
<% SetDetail "xtsz1", "ywzdy_m", "配置单据"%>
<% SetDetail "xtsz1", "xgmm_m", "修改密码"%>
<% SetDetail "xtsz1", "sjbf_m", "数据备份"%>
<% SetDetail "xtsz1", "xxsz_m", "选项设置"%>
<% SetDetail "xtsz1", "gsgk_m", "公司概况"%>
<% SetDetail "xtsz1", "manageLog", "操作日志"%>
<% SetDetail "xtsz1", "f_column", "设置列显示"%>

</table></td></tr>

</table>
</div>
<div style="float:left;width:120px;height:640px;background:#ccc;over-flow:auto;text-align:center;">
<br>
<input type=hidden name=loginname value="<%=request("loginname")%>">
<input class=dh type="submit" name="submit" value="保存">
<input class=dh type="button" name="close" value="关闭" onclick=window.opener=null;window.close()>
</form>
</div>