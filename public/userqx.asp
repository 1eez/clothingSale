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
		validity = false; alert('��ӵĽڵ����Ʋ���Ϊ�գ���������¼��!');
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<title></title>
<fieldset style="width:auto;"><legend>�û�Ȩ������</legend>
<div style="float:left;width:220px;height:500px;border:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="userqx.asp?username=" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='40%' align=right>�û����ƣ�</td>
<td colspan="3">
<input name="username" type="text" value="" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td></tr>
<tr><td width='40%' align=right>���룺</td>
<td colspan="3">
<input name="password" type="password" value="" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td></tr>
<tr><td width='40%' align=right>�û����ͣ�</td>
<td colspan="3">
<select name=type style=width:auto;><option value="�û�" >�û�</option><option value="Ȩ����" >Ȩ����</option></select>
</td></tr>
<tr><td width='40%' align=right>����Ȩ�ޣ�</td>
<td colspan="3">
<select name=qxgroup style=width:auto;><option></option><option value="admin" >admin</option><option value="user" >user</option><option value="PP" >PP</option><option value="1123422" >1123422</option></select>
</td></tr>
<tr><td colspan=4 align=center>

<input class=dh name="submit" type="submit" value="����" />

<input class=dh name="close" type="button" value="�ر�" onclick=window.opener=null;window.close();></td></tr>
</table>
</div>
<div style="float:left;width:360px;height:500px;overflow:auto;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;">

<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a_0').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<input onclick=checkall() id=allcheck type=checkbox name=qxname value=-|><a class=tree href='javascript:' value=�û�Ȩ�� onclick=settreename(this,'treecode','treename','treecodename')>�û�Ȩ��</a>
<tr><td class="submenu" id="a_0" style="">
<table border="0" cellspacing="0" cellpadding="0">

		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a01').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='cym;' ><a class=tree href='javascript:' value=���ò�ѯ onclick=settreename(this,'treecode','treename','treecodename')>���ò�ѯ</a></td></tr>
<tr><td class="submenu" id="a01" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockfind;" ><a class=tree href='javascript:' value=����ѯ onclick=settreename(this,'treecode','treename','treecodename')>����ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockhpfind;" ><a class=tree href='javascript:' value=����ѯ-������� onclick=settreename(this,'treecode','treename','treecodename')>����ѯ-�������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="stockcount;" ><a class=tree href='javascript:' value=��������� onclick=settreename(this,'treecode','treename','treecodename')>���������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="billfind;" ><a class=tree href='javascript:' value=���ݲ�ѯ onclick=settreename(this,'treecode','treename','treecodename')>���ݲ�ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="billdetailfind;" ><a class=tree href='javascript:' value=������ϸ��ѯ onclick=settreename(this,'treecode','treename','treecodename')>������ϸ��ѯ</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a02').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='cgm;' ><a class=tree href='javascript:' value=�ɹ����� onclick=settreename(this,'treecode','treename','treecodename')>�ɹ�����</a></td></tr>
<tr><td class="submenu" id="a02" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_add;" ><a class=tree href='javascript:' value=�����ɹ��� onclick=settreename(this,'treecode','treename','treecodename')>�����ɹ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_edit;" ><a class=tree href='javascript:' value=�޸Ĳɹ��� onclick=settreename(this,'treecode','treename','treecodename')>�޸Ĳɹ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_del;" ><a class=tree href='javascript:' value=ɾ���ɹ��� onclick=settreename(this,'treecode','treename','treecodename')>ɾ���ɹ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbill_find;" ><a class=tree href='javascript:' value=�ɹ�����ѯ onclick=settreename(this,'treecode','treename','treecodename')>�ɹ�����ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cgbilldetail_find;" ><a class=tree href='javascript:' value=�ɹ�����ϸ��ѯ onclick=settreename(this,'treecode','treename','treecodename')>�ɹ�����ϸ��ѯ</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a03').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='xsm;' ><a class=tree href='javascript:' value=���۹��� onclick=settreename(this,'treecode','treename','treecodename')>���۹���</a></td></tr>
<tr><td class="submenu" id="a03" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_add;" ><a class=tree href='javascript:' value=�������۵� onclick=settreename(this,'treecode','treename','treecodename')>�������۵�</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_edit;" ><a class=tree href='javascript:' value=�޸����۵� onclick=settreename(this,'treecode','treename','treecodename')>�޸����۵�</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_del;" ><a class=tree href='javascript:' value=ɾ�����۵� onclick=settreename(this,'treecode','treename','treecodename')>ɾ�����۵�</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbill_find;" ><a class=tree href='javascript:' value=���۵���ѯ onclick=settreename(this,'treecode','treename','treecodename')>���۵���ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="xsbilldetail_find;" ><a class=tree href='javascript:' value=������ϸ��ѯ onclick=settreename(this,'treecode','treename','treecodename')>������ϸ��ѯ</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a04').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='dbm;' ><a class=tree href='javascript:' value=�������� onclick=settreename(this,'treecode','treename','treecodename')>��������</a></td></tr>
<tr><td class="submenu" id="a04" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_add;" ><a class=tree href='javascript:' value=���������� onclick=settreename(this,'treecode','treename','treecodename')>����������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_edit;" ><a class=tree href='javascript:' value=�޸ĵ����� onclick=settreename(this,'treecode','treename','treecodename')>�޸ĵ�����</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_del;" ><a class=tree href='javascript:' value=ɾ�������� onclick=settreename(this,'treecode','treename','treecodename')>ɾ��������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbill_find;" ><a class=tree href='javascript:' value=��������ѯ onclick=settreename(this,'treecode','treename','treecodename')>��������ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="dbbilldetail_find;" ><a class=tree href='javascript:' value=��������ϸ��ѯ onclick=settreename(this,'treecode','treename','treecodename')>��������ϸ��ѯ</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a05').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='qcm;' ><a class=tree href='javascript:' value=�ڳ����� onclick=settreename(this,'treecode','treename','treecodename')>�ڳ�����</a></td></tr>
<tr><td class="submenu" id="a05" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_add;" ><a class=tree href='javascript:' value=�����ڳ�¼�� onclick=settreename(this,'treecode','treename','treecodename')>�����ڳ�¼��</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_edit;" ><a class=tree href='javascript:' value=�޸��ڳ�¼�� onclick=settreename(this,'treecode','treename','treecodename')>�޸��ڳ�¼��</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_del;" ><a class=tree href='javascript:' value=ɾ���ڳ�¼�� onclick=settreename(this,'treecode','treename','treecodename')>ɾ���ڳ�¼��</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbill_find;" ><a class=tree href='javascript:' value=�ڳ�����ѯ onclick=settreename(this,'treecode','treename','treecodename')>�ڳ�����ѯ</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="qcbilldetail_find;" ><a class=tree href='javascript:' value=�ڳ���ϸ��ѯ onclick=settreename(this,'treecode','treename','treecodename')>�ڳ���ϸ��ѯ</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a06').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='jcm;' ><a class=tree href='javascript:' value=�������� onclick=settreename(this,'treecode','treename','treecodename')>��������</a></td></tr>
<tr><td class="submenu" id="a06" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="depotm;" ><a class=tree href='javascript:' value=�������Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>�������Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="goodsm;" ><a class=tree href='javascript:' value=��Ʒ���Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>��Ʒ���Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="custm;" ><a class=tree href='javascript:' value=������λ���� onclick=settreename(this,'treecode','treename','treecodename')>������λ����</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="empm;" ><a class=tree href='javascript:' value=Ա�����Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>Ա�����Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="vipm;" ><a class=tree href='javascript:' value=VIP���Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>VIP���Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="colorm;" ><a class=tree href='javascript:' value=��ɫ���Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>��ɫ���Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="sizem;" ><a class=tree href='javascript:' value=�������Ϲ��� onclick=settreename(this,'treecode','treename','treecodename')>�������Ϲ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="catem;" ><a class=tree href='javascript:' value=������� onclick=settreename(this,'treecode','treename','treecodename')>�������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="combom;" ><a class=tree href='javascript:' value=���������� onclick=settreename(this,'treecode','treename','treecodename')>����������</a></td></tr></table></td></tr>
		<tr><td><span class="collapsedFolder1" style="width:20px;height:20px;" onMouseUp="with(findObj('a07').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
        <input id=allcheck1 type=checkbox name=qxname value='xtsz;' ><a class=tree href='javascript:' value=ϵͳ���� onclick=settreename(this,'treecode','treename','treecodename')>ϵͳ����</a></td></tr>
<tr><td class="submenu" id="a07" style="display:none">
<table border="0" cellspacing="0" cellpadding="0">
		<tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="userm;" ><a class=tree href='javascript:' value=����Ա���� onclick=settreename(this,'treecode','treename','treecodename')>����Ա����</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="cleardata;" ><a class=tree href='javascript:' value=ϵͳ��ʼ�� onclick=settreename(this,'treecode','treename','treecodename')>ϵͳ��ʼ��</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="changepass;" ><a class=tree href='javascript:' value=�޸����� onclick=settreename(this,'treecode','treename','treecodename')>�޸�����</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="backup;" ><a class=tree href='javascript:' value=���ݱ��� onclick=settreename(this,'treecode','treename','treecodename')>���ݱ���</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="optionset;" ><a class=tree href='javascript:' value=ѡ������ onclick=settreename(this,'treecode','treename','treecodename')>ѡ������</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="mangelog;" ><a class=tree href='javascript:' value=������־ onclick=settreename(this,'treecode','treename','treecodename')>������־</a></td></tr><tr><td class=iefile><input id=allcheck1 type=checkbox name=qxname value="coinfo;" ><a class=tree href='javascript:' value=��˾�ſ� onclick=settreename(this,'treecode','treename','treecodename')>��˾�ſ�</a></td></tr></table></td></tr></table></td></tr>
</table>

</div>
</fieldset>
<br>
</form>
</html>
