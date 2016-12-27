<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【VIP信息资料设置】"
cklist = request.cookies("cklist")
vipcode = request("vipcode")
action = "vip_save.asp"
if vipcode <> "" then
	action = action&"?vipcode="&server.urlencode(vipcode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tVip where vipcode='"&vipcode&"'"
	t.open sql, conn, 1, 1
		VipCode = t("VipCode")
		AddDate = t("AddDate")
		BirthDay = t("BirthDay")
		fmonth = Mid(Birthday, 1, instr(Birthday,"-") - 1)
		fday = Mid(Birthday, instr(Birthday,"-") + 1, len(Birthday))
		BirthType = t("BirthType")
		Discount = FormatNumber(t("Discount"), 2, -1,false,false)
		Phone = t("Phone")
		Remark = t("Remark")
		VipName = t("VipName")
		VipType = t("VipType")
		if BirthType="阴历" then
			fCheck2 = "Checked"
		else
			fCheck1 = "Checked"
		end if
	t.close
	set t=nothing
else
	VipCode=SetAutoCode("vipcode", "tVip", "VP")
	AddDate = setdate(Date())
	Discount = 0
	fCheck1 = "Checked"
end if
st1="width='15%' align=right"
st2="width='30%'"
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<script type='text/javascript' src='../js/calendar.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<script language="JavaScript">
function validate_form(){
	validity = true;
	if (!check_empty(document.form.vipcode.value)){
		validity = false; alert('您好，VIP编号不能为空!');
	}
	if (!check_empty(document.form.vipname.value)){ 
		validity = false; alert('您好，VIP姓名不能为空!'); 
	}
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<fieldset style="width:auto;"><legend>【VIP信息资料设置】</legend>
<form name="form" method="post" action="vip_save.asp" onSubmit="return validate_form()">
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>VIP卡号：</td>
<td width='30%'>
<input type="text" name="vipcode" value="VP0001" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>VIP姓名：</td>
<td width='30%'>
<input type="text" name="vipname" value="" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>手机：</td>
<td width='30%'>
<input type="text" name="phone" value="" size=12>
</td>
<td width='15%' align=right>办卡日期：</td>
<td width='30%'>
<input type="text" name="adddate" size="12" value="2012-04-07">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(adddate,0);">
</td>
</tr>
<tr><td width='15%' align=right>VIP生日：</td>
<td width='30%'>
<select name=fmonth style=width:auto;><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option><option value="12" >12</option></select>-<select name=fday style=width:auto;><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option><option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option><option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option><option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option><option value="30" >30</option><option value="31" >31</option></select>
</td>
<td width='15%' align=right>阴历阳历：</td>
<td width='30%'>
<input type="radio" name="BirthType" value="阳历" Checked>阳历
<input type="radio" name="BirthType" value="阴历" >阴历
</td>
</tr>
<tr><td width='15%' align=right>VIP级别：</td>
<td width='30%'>
<input type="text" name="VipType" value="" size=12>
</td>
<td width='15%' align=right>折扣：</td>
<td width='30%'>
<input class=number type="text" name="Discount" value="0" size=12>
</td>
</tr>
<tr><td width='15%' align=right>备注：</td>
<td colspan="3">
<textarea name="Remark" cols="60" rows="2" wrap="VIRTUAL"></textarea>
</td></tr>
</table></fieldset><br>
<center>

<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>

<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>

</html>