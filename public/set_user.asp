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
	font-family:΢���ź�;
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
<title>����Ȩ��</title>
<table width="100%" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('a01').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>���ݳ�ʼ��</td></tr>
<tr><td class="submenu" id="a01" style="">
<table border="0" cellspacing="0" cellpadding="0">
<%
set rs=server.createobject("adodb.recordset")
q = "select * from dict_cate where tablename='���ݳ�ʼ��' order by code asc"
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

<input class=dh type=checkbox name="checka" value="" onclick=checkall()>ȫѡ��ȡ��
<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('ftdepotm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="ftdepot" value="ftdepot" onclick=checkAll(this,'ftdepot1') <% if instr(cklist,"ftdepot")>0 then response.write "checked" end if %>>�鿴�ֿ�Ȩ��</td></tr>
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

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('sjcxm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="sjcx1" value="sjcx1" onClick="checkAll(this, 'sjcx1')" <% if instr(qxlist,"sjcx1")>0 then response.write "checked" end if %>>���ݲ�ѯ</td></tr>
<tr><td class="submenu" id="sjcxm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "sjcx1", "sjcx_m", "���ݲ�ѯ����"%>
<% SetDetail "sjcx1", "kc_find", "����ѯ"%>
<% SetDetail "sjcx1", "bill_find", "���ݲ�ѯ"%>
<% SetDetail "sjcx1", "bill_detail_find", "������ϸ��ѯ"%>
<% SetDetail "sjcx1", "bill_ddetail_find", "������ϸ���ѯ"%>
<% SetDetail "sjcx1", "bill_edit", "�����޸�"%>
<% SetDetail "sjcx1", "see_money", "�鿴���ۡ����"%>
<% SetDetail "sjcx1", "bill_delete", "����ɾ��"%>
<% SetDetail "sjcx1", "bill_detail", "��������"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('fkcglm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="kcgl1" value="kcgl" onClick="checkAll(this, 'kcgl1')" <% if instr(qxlist,"kcgl")>0 then response.write "checked" end if %>>������</td></tr>
<tr><td class="submenu" id="fkcglm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "kcgl1", "kc_m", "������"%>
<% SetDetail "kcgl1", "rk_add", "������ⵥ"%>
<% SetDetail "kcgl1", "ck_add", "�������ⵥ"%>
<% SetDetail "kcgl1", "db_add", "����������"%>
<% SetDetail "kcgl1", "pd_add", "�����̵㵥"%>
<% SetDetail "kcgl1", "zz_add", "������װ��"%>
<% SetDetail "kcgl1", "cx_add", "������ж��"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('kcbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="kcbb1" value="kcbb" onClick="checkAll(this, 'kcbb1')" <% if instr(qxlist,"kcbb")>0 then response.write "checked" end if %>>��汨��</td></tr>
<tr><td class="submenu" id="kcbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "kcbb1", "kc_bm", "��汨�����"%>
<% SetDetail "kcbb1", "kc_ph", "���ƽ���"%>
<% SetDetail "kcbb1", "kc_count", "������"%>
<% SetDetail "kcbb1", "kc_warning", "��汨��"%>
<% SetDetail "kcbb1", "kc_cfind", "�ֲֻ���"%>
<% SetDetail "kcbb1", "kc_nfind", "�ֲֿ�����"%>
<% SetDetail "kcbb1", "kc_parentKind", "���������"%>
<% SetDetail "kcbb1", "kc_depot", "�ֿ����"%>
<% SetDetail "kcbb1", "kc_detail", "�����ϸ"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('cgbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="cgbb1" value="cgbb" onClick="checkAll(this, 'cgbb1')" <% if instr(qxlist,"cgbb")>0 then response.write "checked" end if %>>�ɹ�����</td></tr>
<tr><td class="submenu" id="cgbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "cgbb1", "cg_bbm", "�ɹ��������"%>
<% SetDetail "cgbb1", "supply_count", "��Ӧ�̲ɹ����ܱ�"%>
<% SetDetail "cgbb1", "supply_detail", "��Ӧ�̲ɹ���ϸ��"%>
<% SetDetail "cgbb1", "goods_count", "��Ʒ�ɹ����ܱ�"%>
<% SetDetail "cgbb1", "goods_detail", "��Ʒ�ɹ���ϸ��"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('xsbbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xsbb1" value="xsbb" onClick="checkAll(this, 'xsbb1')" <% if instr(qxlist,"xsbb")>0 then response.write "checked" end if %>>���۱���</td></tr>
<tr><td class="submenu" id="xsbbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xsbb1", "xs_bbm", "���۱������"%>
<% SetDetail "xsbb1", "custom_count", "�ͻ����ۻ��ܱ�"%>
<% SetDetail "xsbb1", "custom_detail", "�ͻ�������ϸ��"%>
<% SetDetail "xsbb1", "goods1_count", "��Ʒ���ۻ��ܱ�"%>
<% SetDetail "xsbb1", "goods1_detail", "��Ʒ������ϸ��"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('lybbm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="lybb1" value="lybb" onClick="checkAll(this, 'lybb1')" <% if instr(qxlist,"lybb")>0 then response.write "checked" end if %>>���ñ���</td></tr>
<tr><td class="submenu" id="lybbm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "lybb1", "ly_bbm", "���ñ������"%>
<% SetDetail "lybb1", "depart_count", "�������û��ܱ�"%>
<% SetDetail "lybb1", "depart_detail", "����������ϸ��"%>
<% SetDetail "lybb1", "goodsly_count", "��Ʒ���û��ܱ�"%>
<% SetDetail "lybb1", "goodsly_detail", "��Ʒ������ϸ��"%>
<% SetDetail "lybb1", "db_count", "��Ʒ�������ܱ�"%>
<% SetDetail "lybb1", "db_detail", "��Ʒ������ϸ��"%>

</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('screport').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input class=dh type=checkbox name="screp1" value="screp" onClick="checkAll(this, 'screp1')" <% if instr(qxlist,"screp")>0 then response.write "checked" end if %>>��������</td></tr>
<tr><td class="submenu" id="screport" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "screp1", "sc_rm", "���ɱ������"%>
<% SetDetail "screp1", "sc_count", "�����������ܱ�"%>
<% SetDetail "screp1", "sc_detail", "����������ϸ��"%>
<% SetDetail "screp1", "sc_goodsCount", "��Ʒ�������ܱ�"%>
<% SetDetail "screp1", "sc_goodsDetail", "��Ʒ������ϸ��"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('zcreport').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input class=dh type=checkbox name="zcrep1" value="zcrep" onClick="checkAll(this, 'zcrep1')" <% if instr(qxlist,"zcrep")>0 then response.write "checked" end if %>>��װ����ж����</td></tr>
<tr><td class="submenu" id="zcreport" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "zcrep1", "zc_rm", "���ɱ������"%>
<% SetDetail "zcrep1", "zc_count", "�顢���Ʒ���ܱ�"%>
<% SetDetail "zcrep1", "zc_detail", "�顢���Ʒ��ϸ��"%>
<% SetDetail "zcrep1", "zc1_count", "�顢��ԭ�ϻ��ܱ�"%>
<% SetDetail "zcrep1", "zc1_detail", "�顢��ԭ����ϸ��"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('jczlm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="jczl" onClick="checkAll(this, 'jczl1')" <% if instr(qxlist,"jczl")>0 then response.write "checked" end if %>>��������</td></tr>
<tr><td class="submenu" id="jczlm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "jczl_m", "�������Ϲ���"%>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('hpzl_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="hpzl_m" <% if instr(qxlist,"hpzl_m")>0 then response.write "checked" end if %>>��Ʒ����</td></tr>
<tr><td class="submenu" id="hpzl_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "hp_add", "������Ʒ"%>
<% SetDetail "jczl1", "hp_edit", "�޸Ļ�Ʒ"%>
<% SetDetail "jczl1", "hp_detail", "��Ʒ����"%>
<% SetDetail "jczl1", "hp_delete", "��Ʒɾ��"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('wldw_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="wldw_m" <% if instr(qxlist,"wldw_m")>0 then response.write "checked" end if %>>������λ</td></tr>
<tr><td class="submenu" id="wldw_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "custom_add", "����������λ"%>
<% SetDetail "jczl1", "custom_edit", "�޸�������λ"%>
<% SetDetail "jczl1", "custom_detail", "������λ����"%>
<% SetDetail "jczl1", "custom_delete", "������λɾ��"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('ck_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="ck_m" <% if instr(qxlist,"ck_m")>0 then response.write "checked" end if %>>�ֿ�</td></tr>
<tr><td class="submenu" id="ck_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "depot_add", "�����ֿ�"%>
<% SetDetail "jczl1", "depot_edit", "�޸Ĳֿ�"%>
<% SetDetail "jczl1", "depot_detail", "�ֿ�����"%>
<% SetDetail "jczl1", "depot_delete", "�ֿ�ɾ��"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('emp_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="jczl1" value="emp_m" <% if instr(qxlist,"emp_m")>0 then response.write "checked" end if %>>Ա��</td></tr>
<tr><td class="submenu" id="emp_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "jczl1", "emp_add", "����Ա��"%>
<% SetDetail "jczl1", "emp_edit", "�޸�Ա��"%>
<% SetDetail "jczl1", "emp_detail", "Ա������"%>
<% SetDetail "jczl1", "emp_delete", "Ա��ɾ��"%>
</table></td></tr>

<% SetDetail "jczl1", "jc_m", "������Ϣ"%>
<% SetDetail "jczl1", "zz_mb", "��װģ��"%>
<% SetDetail "jczl1", "hp_start", "�ڳ�¼��"%>
<% SetDetail "jczl1", "hp_export", "Excel��Ʒ��������"%>
</table></td></tr>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('xtszm').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xtsz1" value="xtsz" onClick="checkAll(this, 'xtsz1')" <% if instr(qxlist,"xtsz")>0 then response.write "checked" end if %>>ϵͳ����</td></tr>
<tr><td class="submenu" id="xtszm" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xtsz1", "xtsz_m", "ϵͳ���ù���"%>

<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onmouseup="with(findObj('czy_f_m').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span><input class=dh type=checkbox name="xtsz1" value="czy_m" <% if instr(qxlist,"czy_m")>0 then response.write "checked" end if %>>����Ա����</td></tr>
<tr><td class="submenu" id="czy_f_m" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
<% SetDetail "xtsz1", "user_add", "��������Ա"%>
<% SetDetail "xtsz1", "user_edit", "�޸Ĳ���Ա"%>
<% SetDetail "xtsz1", "user_detail", "����Ա����"%>
<% SetDetail "xtsz1", "user_delete", "����Աɾ��"%>
<% SetDetail "xtsz1", "user_qx", "����ԱȨ��"%>
</table></td></tr>

<% SetDetail "xtsz1", "year_carry_m", "���ս�ת"%>
<% SetDetail "xtsz1", "oldbill_find", "�������ݲ�ѯ"%>
<% SetDetail "xtsz1", "xtcsh_m", "ϵͳ��ʼ��"%>
<% SetDetail "xtsz1", "ywzdy_m", "���õ���"%>
<% SetDetail "xtsz1", "xgmm_m", "�޸�����"%>
<% SetDetail "xtsz1", "sjbf_m", "���ݱ���"%>
<% SetDetail "xtsz1", "xxsz_m", "ѡ������"%>
<% SetDetail "xtsz1", "gsgk_m", "��˾�ſ�"%>
<% SetDetail "xtsz1", "manageLog", "������־"%>
<% SetDetail "xtsz1", "f_column", "��������ʾ"%>

</table></td></tr>

</table>
</div>
<div style="float:left;width:120px;height:640px;background:#ccc;over-flow:auto;text-align:center;">
<br>
<input type=hidden name=loginname value="<%=request("loginname")%>">
<input class=dh type="submit" name="submit" value="����">
<input class=dh type="button" name="close" value="�ر�" onclick=window.opener=null;window.close()>
</form>
</div>