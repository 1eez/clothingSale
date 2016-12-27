<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
dTitle = "【员工信息资料设置】"
cklist = request.cookies("cklist")
empcode = request("empcode")
action = "emp_save.asp"
if empcode <> "" then
	action = action&"?empcode="&server.urlencode(empcode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tEmp where empcode='"&empcode&"'"
	t.open sql, conn, 1, 1
		EmpCode = t("EmpCode")
		Address = t("Address")
		BankID = t("BankID")
		BankName = t("BankName")
		Birthday = t("Birthday")
		fmonth = Mid(Birthday, 1, instr(Birthday,"-") - 1)
		fday = Mid(Birthday, instr(Birthday,"-") + 1, len(Birthday))
		Depart = t("Depart")
		DepartCode = t("DepartCode")
		EmpName = t("EmpName")
		EmpSex = t("EmpSex")
		Job = t("Job")
		Mobile = t("Mobile")
		Native = t("Native")
		NewOrOld = t("NewOrOld")
		if NewOrOld="阴历" then
			fCheck2 = "Checked"
		else
			fCheck1 = "Checked"
		end if
		Phone = t("Phone")
		Place = t("Place")
		Remark = t("Remark")
		PassWord = t("PassWord")
		
	t.close
	set t=nothing
else
	empcode=SetAutoCode3("empcode", "tEmp", "")
	fCheck1 = "Checked"
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
	if (!check_empty(document.form.empcode.value)){
		validity = false; alert('您好，员工编号不能为空!');
	}
	if (!check_empty(document.form.empname.value)){ 
		validity = false; alert('您好，员工姓名不能为空!'); 
	}
	if (!check_empty(document.form.PassWord.value)){ 
		validity = false; alert('您好，员工密码不能为空!'); 
	}
	
	return validity;
}

function check_empty(text){
	return (text.length > 0); 
}
</script>
</head>
<body>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<fieldset style="width:auto;"><legend>【员工信息资料设置】</legend>
<table align="center" valign="center" width="100%">
<tr>
<td width='15%' align=right>员工编号：</td>
<td width='30%'>
<input type="text" name="empcode" value="<%=empcode%>"><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>部门：</td>
<td width='30%'>
	<% ComboDepot "Depart", Depart, "auto", ""%>
	</td>
</tr>
<tr><td width='15%' align=right>员工姓名：</td>
<td width='30%'>
<input type="text" name="empname" value="<%=empname%>" size=12><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td><td width='15%' align=right>密码：</td>
<td width='30%'>
<input type="text" name="PassWord" value="<%=PassWord%>"><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>联系电话：</td>
<td width='30%'>
<input type="text" name="phone" value="<%=phone%>" size=12>
</td>
<td width='15%' align=right>手机：</td>
<td width='30%'>
<input type="text" name="mobile" value="<%=mobile%>" size=12>
</td>
</tr>
<tr><td width='15%' align=right>籍贯：</td>
<td width='30%' colspan=3>
<input type="text" name="native" value="<%=native%>" size=68>
</td>
</tr><tr><td width='15%' align=right>家庭住址：</td>
<td width='30%' colspan=3>
<input type="text" name="address" value="<%=address%>" size=68>
</td>
</tr>
<!--
<tr><td width='15%' align=right>职位：</td>
<td width='30%'>
<input type="text" name="job" value="<%=job%>" size=12>
</td>
<td width='15%' align=right>职称：</td>
<td width='30%'>
<input type="text" name="place" value="<%=place%>" size=12>
</td>
</tr><tr><td width='15%' align=right>银行：</td>
<td width='30%'>
<input type="text" name="bankname" value="<%=bankname%>" size=12>
</td>
<td width='15%' align=right>银行卡号：</td>
<td width='30%'>
<input type="text" name="bankid" value="<%=bankid%>" size=24>
</td>
</tr>
<tr><td width='15%' align=right>生日：</td>
<td width='30%'>
<select name=fmonth style=width:auto;><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option><option value="12" >12</option></select>-<select name=fday style=width:auto;><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option><option value="12" >12</option><option value="13" >13</option><option value="14" >14</option><option value="15" >15</option><option value="16" >16</option><option value="17" >17</option><option value="18" >18</option><option value="19" >19</option><option value="20" >20</option><option value="21" >21</option><option value="22" >22</option><option value="23" >23</option><option value="24" >24</option><option value="25" >25</option><option value="26" >26</option><option value="27" >27</option><option value="28" >28</option><option value="29" >29</option><option value="30" >30</option><option value="31" >31</option></select>
</td>
<td width='15%' align=right>阴历阳历：</td>
<td width='30%'>
<input type="radio" name="NewOrOld" value="阳历" Checked>阳历
<input type="radio" name="NewOrOld" value="阴历" >阴历
</td>
</tr>
<tr><td width='15%' align=right>备注：</td>
<td colspan="3">
<textarea name="Remark" cols="60" rows="2" wrap="VIRTUAL"><%=Remark%></textarea>
</td></tr>
-->
</table></fieldset><br>
<center>
<% if request("detail")<>"detail" then%>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>
<%end if%>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
</body>

</html>