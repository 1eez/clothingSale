<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "��������λ�������á�"
cklist = request.cookies("cklist")
custcode = request("custcode")
action = "cust_save.asp"
if custcode <> "" then
	action = action&"?custcode="&server.urlencode(custcode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tCustom where custcode='"&custcode&"'"
	t.open sql, conn, 1, 1
		custcode= t("custcode")
		address = t("address")
		area = t("area")
		areacode = t("areacode")
		bankid = t("bankid")
		bankname = t("bankname")
		contact = t("contact")
		cotype = t("cotype")
		cotypecode = t("cotypecode")
		custcode = t("custcode")
		custname = t("custname")
		custtype = t("custtype")
		depart = t("depart")
		email = t("email")
		fax = t("fax")
		mobile = t("mobile")
		msnqq = t("msnqq")
		phone = t("phone")
		place = t("place")
		remark = t("remark")
		wangwang = t("wangwang")
		website = t("website")
	t.close
	set t=nothing
else
	CustCode=SetAutoCode("CustCode", "tCustom", "CS")
end if
st1="width='15%' align=right"
st2="width='30%'"
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<script language="JavaScript">
function validate_form(){
	validity = true;
	if (!check_empty(document.form.custcode.value)){
		validity = false; alert('���ã���˾��Ų���Ϊ��!');
	}
	if (!check_empty(document.form.custname.value)){ 
		validity = false; alert('���ã���˾���Ʋ���Ϊ��!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>��������λ�������á�</legend>
<form name="form" method="post" action="cust_save.asp" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>��λ���ͣ�</td>
<td width='30%'>
<select name=CustType style=width:auto;><option value="��Ӧ��" >��Ӧ��</option><option value="�ͻ�" >�ͻ�</option><option value="�ͻ�����Ӧ��" >�ͻ�����Ӧ��</option></select>
</td>
<td width='15%' align=right>��˾���룺</td>
<td width='30%'>
<input type="text" name="custcode" value="CS0001"><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td></tr>
<tr><td width='15%' align=right>��˾���ƣ�</td>
<td width='30%' colspan=3>
<input type="text" name="custname" value="" size=68><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>��˾���</td>
<td width='30%'>
<input type="text" class="catetree" name="CoType" value="" readonly>
<input type="hidden" name="CoTypeCode" value="">
<img id="dt_3" style="cursor:hand" src="../images/f.gif">
<div id="mbDIV" style="display: none;"></div>
<div id="loginDIV" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV">&nbsp;����ѡ�����</div>
<div id=height300 style="overflow:auto;">

<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a00').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<a class=tree href='javascript:' value=��˾��� onclick=settreename(this,'CoTypeCode','CoType','')>��˾���</a>
<tr><td class="submenu" id="a00" style="">
<table border="0" cellspacing="0" cellpadding="0">
</table></td></tr>
</table>

</div>
<div id=loginDIV1>
<center>
<input type="button" value="�ر�" onclick=closeselect() style="cursor: pointer;">
</center>
</div>
</div>
<script type="text/javascript">
  for(var i=1;i<=11;i++)
  {
    eval("var dt_" + i + " = document.getElementById('dt_" + i + "')");
  }
  var mbDIV = document.getElementById("mbDIV");
  var loginDIV = document.getElementById("loginDIV");
  var loginTopDIV = document.getElementById("loginTopDIV");
  
dt_3.onclick = function()
{
 loginDIV.style.top = "30px";
 loginDIV.style.left = "150px";
 show("loginDIV");
 mbDIV.style.width = document.body.scrollWidth;
 mbDIV.style.height = document.body.scrollHeight;
 show("mbDIV")

			for (var i = 0; i < document.all.tags('SELECT').length; i++)
			{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "hidden";
			}
}
function closes(){
	hidden("loginDIV");
	hidden("mbDIV");
}

loginTopDIV.onmousedown = Down;
var tHeight,lWidth;
function Down(e)
{
var event = window.event || e;
tHeight = event.clientY  - parseInt(loginDIV.style.top.replace(/px/,""));
lWidth  = event.clientX - parseInt(loginDIV.style.left.replace(/px/,""));
document.onmousemove = Move;
document.onmouseup   = Up;
}
function Move(e) {
var event = window.event || e;
var top = event.clientY - tHeight;
var left = event.clientX - lWidth;
top = top < 0 ? 0 : top;
top = top > document.body.offsetHeight - 150 ? document.body.offsetHeight - 150 : top;
left = left < 0 ? 0 : left;
left = left > document.body.offsetWidth - 300 ? document.body.offsetWidth - 300 : left;
loginDIV.style.top  = top + "px";
loginDIV.style.left = left +"px";
}
function Up(){
    document.onmousemove = null;
}
function closeselect(){
	hidden("loginDIV");
	hidden("mbDIV");
	 for (var i = 0; i < document.all.tags('SELECT').length; i++)
	{
		var obj = document.all.tags('SELECT')[i];
		obj.style.visibility = "visible";
	}	
}
</script>
</td>
<td width='15%' align=right>������</td>
<td width='30%'>
<input type="text" class="catetree" name="Area" value="" readonly>
<input type="hidden" name="AreaCode" value="">
<img id="dt__3" style="cursor:hand" src="../images/f.gif">
<div id="mbDIV_" style="display: none;"></div>
<div id="loginDIV_" style="top:200px;left: 300px;display: none;">
<div id="loginTopDIV_">&nbsp;����ѡ�����</div>
<div id=height300 style="overflow:auto;">

<table style="width:358px;" border="0" cellspacing="0" cellpadding="0" onselectstart="return true">
<tr><td><span class="collapsedFolder2" style="width:20px;height:20px;" onMouseUp="with(findObj('a00').style){display=display=='none'?'':'none';this.style.backgroundImage=display!='none'?'url(../images/e.gif)':'url(../images/c.gif)'}"></span>
<a class=tree href='javascript:' value=���� onclick=settreename(this,'AreaCode','Area','')>����</a>
<tr><td class="submenu" id="a00" style="">
<table border="0" cellspacing="0" cellpadding="0">
</table></td></tr>
</table>

</div>
<div id=loginDIV1_>
<center>
<input type="button" value="�ر�" onclick=closeselect_() style="cursor: pointer;">
</center>
</div>
</div>
<script type="text/javascript">
  for(var i=1;i<=11;i++)
  {
    eval("var dt__" + i + " = document.getElementById('dt__" + i + "')");
  }
  var mbDIV_ = document.getElementById("mbDIV_");
  var loginDIV_ = document.getElementById("loginDIV_");
  var loginTopDIV_ = document.getElementById("loginTopDIV_");
  
dt__3.onclick = function()
{
 loginDIV_.style.top = "30px";
 loginDIV_.style.left = "150px";
 show("loginDIV_");
 mbDIV_.style.width = document.body.scrollWidth;
 mbDIV_.style.height = document.body.scrollHeight;
 show("mbDIV_")

			for (var i = 0; i < document.all.tags('SELECT').length; i++)
			{
			var obj = document.all.tags('SELECT')[i];
			obj.style.visibility = "hidden";
			}
}
function closes(){
	hidden("loginDIV_");
	hidden("mbDIV_");
}

loginTopDIV_.onmousedown = Down;
var tHeight,lWidth;
function Down(e)
{
var event = window.event || e;
tHeight = event.clientY  - parseInt(loginDIV_.style.top.replace(/px/,""));
lWidth  = event.clientX - parseInt(loginDIV_.style.left.replace(/px/,""));
document.onmousemove = Move;
document.onmouseup   = Up;
}
function Move(e) {
var event = window.event || e;
var top = event.clientY - tHeight;
var left = event.clientX - lWidth;
top = top < 0 ? 0 : top;
top = top > document.body.offsetHeight - 150 ? document.body.offsetHeight - 150 : top;
left = left < 0 ? 0 : left;
left = left > document.body.offsetWidth - 300 ? document.body.offsetWidth - 300 : left;
loginDIV_.style.top  = top + "px";
loginDIV_.style.left = left +"px";
}
function Up(){
    document.onmousemove = null;
}
function closeselect_(){
	hidden("loginDIV_");
	hidden("mbDIV_");
	 for (var i = 0; i < document.all.tags('SELECT').length; i++)
	{
		var obj = document.all.tags('SELECT')[i];
		obj.style.visibility = "visible";
	}	
}
</script>
</td></tr>
<tr><td width='15%' align=right>��ϵ�ˣ�</td>
<td width='30%'>
<input type="text" name="Contact" value="" size=12>
</td>
<td width='15%' align=right>���ţ�</td>
<td width='30%'>
<input type="text" name="Depart" value="" size=12>
</td>
</tr>
<tr><td width='15%' align=right>ְ��</td>
<td width='30%'>
<input type="text" name="Place" value="" size=12>
</td>
<td width='15%' align=right>��ϵ�绰��</td>
<td width='30%'>
<input type="text" name="Phone" value="" size=12>
</td>
</tr>
<tr><td width='15%' align=right>�ֻ���</td>
<td width='30%'>
<input type="text" name="Mobile" value="" size=12>
</td>
<td width='15%' align=right>MSN/QQ��</td>
<td width='30%'>
<input type="text" name="MsnQQ" value="" size=12>
</td>
</tr>
<tr><td width='15%' align=right>���䣺</td>
<td width='30%'>
<input type="text" name="Email" value="" size=12>
</td>
<td width='15%' align=right>��˾���棺</td>
<td width='30%'>
<input type="text" name="Fax" value="" size=12>
</td>
</tr>
<tr><td width='15%' align=right>��˾��ַ��</td>
<td width='30%' colspan=3>
<input type="text" name="WebSite" value="" size=68>
</td>
</tr>
<tr><td width='15%' align=right>��ϵ��ַ��</td>
<td width='30%' colspan=3>
<input type="text" name="address" value="" size=68>
</td>
</tr>
<tr><td width='15%' align=right>�����У�</td>
<td width='30%'>
<input type="text" name="BankName" value="" size=12>
</td>
<td width='15%' align=right>���п��ţ�</td>
<td width='30%'>
<input type="text" name="BankID" value="" size=12>
</td>
</tr>
<tr><td width='15%' align=right>������</td>
<td width='30%'>
<input type="text" name="WangWang" value="" size=12>
</td>
<td width='15%' align=right></td>
<td width='30%'>
</td>
</tr>
<tr><td width='15%' align=right>��ע��</td>
<td colspan="3">
<textarea name="Remark" cols="60" rows="2" wrap="VIRTUAL"></textarea>
</td></tr>
</table></fieldset><br>
<center>

<input class=dh type="submit" value="����" name=submit>
<input class=dh type="reset" value="����" name=reset>

<input class=dh type="button" value="�ر�" onclick=window.opener=null;window.close()>
</center>
</form>
</body>

</html>