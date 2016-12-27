<%
qxlist = request.cookies("qxlist")
%>
<?xml version="1.0" encoding="gb2312"?>
<div style="padding:0px;float:left;height:100%;width:170px;overflow:auto;padding-bottom:9px;background:#039EE9;">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script>
function openwin(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
}
function openwin1(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
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
.folder{
	font-family: gb2312;
	font-size: 10pt;
	background-image: url(images/txt_2.png);
	background-repeat: repeat;
	background-position: left;
	padding-left: 45px;
	cursor: hand;
}
.collapsedFolder{
	font-family: gb2312;
	font-size: 10pt;
	color:#000;
	background-image: url(images/txt_1.png);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 45px;
	cursor: hand;
}
.collapsedFolder1{
	font-family: gb2312;
	font-size: 10pt;
	color:#000;
	background-image: url(images/txt_2.png);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 40px;
	cursor: hand;
}
.submenu{
	padding-left: 18px;
}
.iefile{
	background-image: url(images/ie.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 20px;
	font-family: gb2312;
	font-size: 10pt;
}
.iefile1{
	background-image: url(images/ie.gif);
	background-repeat: no-repeat;
	background-position: left;
	padding-left: 20px;
	font-family: gb2312;
	font-size: 10pt;
}
a {
	color: #000;
	text-decoration: none;
}
a:hover{
	color: #FF0000;
	background-color: #eeeeee;
	border: 1px solid #006699;
}
body{
	font-size:10pt;
	font-family:微软雅黑,宋体;
	margin:0px;
	padding:0px;
	color:#FFFFFF;
}
.ctrlbar{
	border: 1px inset;
}
.explorer{
	background-image:url(images/left_bg.gif);
	background-position:top;
	background-repeat:no-repeat;
}
.ctbutton{
	font-family: gb2312;
	font-size: 10pt;
	background-color: #eeeeee;
	border-width: 1px;
	width: 9px;
	height: 100px;
	margin-bottom: 100px;
}

</style>
<table width="100%" style="table-layout:fixed;background="images/left_bg1.gif" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td width="170" align="center" valign="top" class="explorer" id="menubar"><table width="100%" height="12" border="0" cellpadding="0" cellspacing="0">
<tr><td align="left" background="images/left_top.gif" >&nbsp;</td>
</tr></table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" onselectstart="return false">

<% if instr(qxlist,"cym")>0 then %>
<tr><td height="30" class="collapsedFolder1" onmouseup="with(findObj('usefuld').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">常用查询</td></tr>
<tr><td class="submenu" id="usefuld" style="">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"stockfind")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/stock_find.asp'>库存查询</a></a></td></tr>
<% end if %>

<% if instr(qxlist,"stockcount")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/stock_count.asp'>进销存汇总</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"billfind")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/bill_find.asp'>单据查询</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"billdetailfind")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/bill_detail_find.asp'>单据明细查询</a></a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<% if instr(qxlist,"cgm")>0 then %>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('cgd').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">采购管理</td></tr>
<tr><td class="submenu" id="cgd" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"cgbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/cgbill_Add.asp?billtype=采购进货',880,600)>新增进货单</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"cgbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/cgbill_Add.asp?billtype=采购退货',880,600)>新增退货单</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"cgbill_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/cgbill_find.asp'>采购单管理</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"cgbilldetail_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/cgbill_detail_find.asp'>采购明细查询</a></a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<% if instr(qxlist,"xsm")>0 then %>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('xsd').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">销售管理</td></tr>
<tr><td class="submenu" id="xsd" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"xsbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/xsbill_Add.asp?billtype=销售出货',880,600)>新增销售单</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"xsbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/xsbill_Add.asp?billtype=销售退货',880,600)>新增销售退货单</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"xsbill_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/xsbill_find.asp'>销售单管理</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"xsbilldetail_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/xsbill_detail_find.asp'>销售明细查询</a></a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<% if instr(qxlist,"dbm")>0 then %>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('dbd').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">调拨管理</td></tr>
<tr><td class="submenu" id="dbd" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"dbbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/xsbill_Add.asp?billtype=店铺调拨',880,600)>新增调拨单</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"dbbill_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/dbbill_find.asp'>调拨单管理</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"dbbilldetail_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/dbbill_detail_find.asp'>调拨明细查询</a></a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<%
'if instr("abc","qcm")>0 then 
 if instr(qxlist,"qcm")>0 then 
 	
 	%>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('pdd').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">期初管理</td></tr>
<tr><td class="submenu" id="pdd" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"qcbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/qcbill_Add.asp?billtype=期初录入',880,600)>新增期初录入</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"qcbill_add")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('unit/qcbille_Add.asp?billtype=期初录入',880,600)>期初Excel导入</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"qcbill_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/qcbill_find.asp'>期初单管理</a></a></td></tr>
<% end if %>
<% if instr(qxlist,"qcbilldetail_find")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='unit/qcbill_detail_find.asp'>期初明细查询</a></a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<% if instr(qxlist,"jcm")>0 then %>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('jczl').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">基础资料</td></tr>
<tr><td class="submenu" id="jczl" style="display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<% if instr(qxlist,"depotm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/depot_find.asp'>店铺资料</a></td></tr>
<% end if %>
<% if instr(qxlist,"goodsm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/hp_find.asp'>商品资料</a></td></tr>
<% end if %>
<% if instr(qxlist,"custm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/cust_find.asp'>往来单位</a></td></tr>
<% end if %>
<% if instr(qxlist,"empm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/emp_find.asp'>员工资料</a></td></tr>
<% end if %>
<!--
<% if instr(qxlist,"vipm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/vip_find.asp'>VIP资料</a></td></tr>
<% end if %>
-->
<% if instr(qxlist,"colorm")>0 then %>
<!--
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/color_find.asp'>颜色资料</a></td></tr>
-->
<% end if %>
<% if instr(qxlist,"sizem")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/size_find.asp'>尺码资料</a></td></tr>
<% end if %>
<% if instr(qxlist,"catem")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='public/basic.asp'>商品类别设置</a></td></tr>
<% end if %>
<% if instr(qxlist,"combom")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='public/combo.asp'>下拉框设置</a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<% if instr(qxlist,"xtsz")>0 then %>
<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('xtsz').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">系统设置</td></tr>
<tr><td class="submenu" id="xtsz" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<% if instr(qxlist,"userm")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='public/userqx_find.asp'>操作员管理</a></td></tr>
<% end if %>
<% if instr(qxlist,"cleardata")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='public/cleardata.asp'>系统初始化</a></td></tr>
<% end if %>
<% if instr(qxlist,"changepass")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('public/set_password.asp',480,320)>修改密码</a></td></tr>
<% end if %>

<% if instr(qxlist,"optionset")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=window.parent.main.location.href='public/optionset.asp'>选项设置</a></td></tr>
<% end if %>
<% if instr(qxlist,"mangelog")>0 then %>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='unit/manageLog.asp'>操作日志</a></td></tr>
<% end if %>
<% if instr(qxlist,"coinfo")>0 then %>
<tr><td class="iefile"><a href='javascript:' onclick=openwin('public/co_info.asp',480,320)>公司概况</a></td></tr>
<% end if %>
</table></td></tr>
<% end if %>

<tr><td height="30" class="collapsedFolder" onmouseup="with(findObj('help').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(images/txt_2.png)':'url(images/txt_1.png)'}">帮助文件</td></tr>
<tr><td class="submenu" id="help" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='help/帮助文档.html'>帮助文档</a></td></tr>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='help/软件架设.html'>软件架设</a></td></tr>
<tr><td class="iefile"><a href="javascript:" onclick=window.parent.main.location.href='help/修改IE页边距.html'>修改IE页边距</a></td></tr>

</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center" style="color:#000;font-size:10pt;">
</td></tr></table>
</td></tr></table>