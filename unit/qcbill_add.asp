<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
if request("refresh")="add" then
%>
<script>
if(self.opener.parent.main.location.href.indexOf('xsbill_find.asp')>0){
	self.opener.parent.main.location.href=self.opener.parent.main.location.href;
}else{
	self.opener.parent.main.location.href='qcbill_find.asp';
}
</script>
<%
end if
if request("refresh")="edit" then
	response.write "<script>self.opener.location.href=self.opener.location.href;</script>"
end if
billtype = request("billtype")
cklist = request.cookies("cklist")
BillCode = request("BillCode")
action = "qcbill_add_save.asp"
if BillCode <> "" then
	action = action&"?BillCode="&server.urlencode(BillCode)
	set t = server.createobject("adodb.recordset")
	sql = "select * from tBill where BillCode='"&BillCode&"'"
	t.open sql, conn, 1, 1
	BillCode = t("BillCode")
	AddDate = setdate(t("AddDate"))
	AddTime = t("AddTime")
	BillType = t("BillType")
	CustName = t("CustName")
	DepotName = t("DepotName")
	EditDate = now()
	Editer = session("username")
	Field1 = t("Field1")
	Field2 = t("Field2")
	Field3 = t("Field3")
	Field4 = t("Field4")
	Field5 = t("Field5")
	FUser = t("FUser")
	InOrOut = t("InOrOut")
	Maker = session("username")
	MakerDate = now()
	MRemark = t("MRemark")
	OldBill = t("OldBill")
	PayType = t("PayType")
	SkMoney = t("SkMoney")
	VipCode = t("VipCode")
	YSMoney = t("YSMoney")
	ZLMoney = t("ZLMoney")
	t.close
	
	q = "select count(*) from tBillDetail where DBillCode='"&BillCode&"'"
	t.open q, conn, 1, 1
	reK = t.fields(0).value
	t.close
	set t=nothing
else
	q = "select * from dict_bill where name='"&billtype&"'"
	set t = Server.CreateObject("adodb.recordset")
	t.open q, conn, 1, 1
	code = t("code")
	t.close
	set t=nothing
	billcode = SetCode(code, setdate(date()), "tBill")
	adddate = setdate(date())
	reK = 0
end if
dTitle = "【"&billtype&"单】"
st1="width='15%' align=right"
st2="width='30%'"
depotnamecaption = "店铺名称：" 
custnamecaption = "客户："
custnameinput = ""
if billtype="店铺调拨" then
	depotnamecaption = "调出店铺：" 
	custnamecaption = "调入店铺："
end if
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/qcbill_add.js'></script>
<style>
table{
	border-collapse:collapse;
	border:#92B7D0 1px solid;
}
td{
	border:#92B7D0 1px solid;
}
</style>
</head>
<form onKeyPress="if(event.keyCode==13){return false;}" name="form" method="post" action=<%=action%> onSubmit="return validate_form()" target="_blank">
<div id=billTitle><center>【单】</center></div>
<center>预计单号：<font color=clred><b><%=billcode%></b></font></center>
<table align="center" valign="center" width="100%">
<tr><td width='15%' align=right>店铺名称：</td>
<td width='30%'>
<% ComboDepot "CustName", CustName, "auto", ""%><%=RedPoint%> 
</td><td width='15%' align=right>单据日期：</td>
<td width='30%'>
<input type="text" name="adddate" size="12" value="<%=adddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(adddate,0);"><font style=color:#ff0000;font-size:12pt;font-weight:bold;>*</font>
</td>
</tr>
<tr><td width='15%' align=right>经办人：</td>
<td width='30%'>
<% SetCombo "FUser", "select EmpName from tEmp", "no", FUser, "auto"%>
</td><td width='15%' align=right>手工单号：</td>
<td width='30%'>
<INPUT name=oldbill size=12 value="<%=oldbill%>">
</td>
</tr>
<tr><td width='15%' align=right>备注：</td>
<td colspan="3">
<TEXTAREA wrap=VIRTUAL cols=60 name=MRemark><%=MRemark%></TEXTAREA>
</td></tr>
</table><div style="marging:4px 0;">
	<INPUT name=intK value=0 type=hidden> 
	<INPUT name=billtype value="<%=billtype%>" type=hidden> 
<input class=dh type=button onclick=checkdepot(0) name="addnew" value=增行>

	<!--<input class=dh type=button onclick=checkdepothp(0) name="addnew" value=增行-横排>-->
	<INPUT class=dh onclick=showbarcode() name=btnBarCode value=条码扫描 type=button>
<DIV style="DISPLAY: none" id=divbarcode>
	&nbsp;&nbsp;&nbsp;&nbsp;条形码：
	<INPUT onkeyup=setbarcode() name=barcode size=16> 
	数量：<INPUT class=number name=number value=1 size=8>
</DIV></DIV>
<DIV id=inner-table-hpzl>
<TABLE id=t136>
  <TBODY>
  <TR>
    <TH width=28 align=center></TH>
    <TH width=30 align=center>序号</TH>
    <TH width=110 align=center>商品款号</TH>
    <TH width=120 align=center>商品名称</TH>
    <TH width=40 align=center>单位</TH>
    <TH width=60 align=center>尺码</TH>
    <TH width=60 align=center>颜色</TH>
    <TH width=60 align=center>数量</TH>
    <TH width=60 align=center>单价</TH>
    <TH width=60 align=center>金额</TH>
    <TH width=120 align=center>条码</TH>
    <TH width=80 align=center>备注</TH></TR>
 <%
if BillCode<>"" then
	set t = server.createobject("adodb.recordset")
	q = "select * from tBillDetail where DBillCode='"&BillCode&"' order by BillDetailID"
	t.open q, conn, 1, 1
	for i = 0 to t.recordcount - 1
		j = i + 1
		%>
<tr height=25>
<td><a class=delete href=javascript:void(0) onclick=del()>删除</a></td>
<td><%=j%></td>
<td>
<input style=width:100%;border:0px; readonly type=text name="goodsstyle_<%=j%>" value="<%=t("goodsstyle")%>">
</td>
<td>
<input style=width:100%;border:0px; readonly type=text name="goodsname_<%=j%>" value="<%=t("goodsname")%>">
</td>
<td><input style=width:100%;border:0px; readonly type=text name="units_<%=j%>" value="<%=t("units")%>"></td>
<td><select name="sizename_<%=j%>" style=width:100%;>
<% SetCombojs "SizeName", "select * from tSize where SizeGroup = '"&t("sizegroup")&"' order by colPosition", "SizeName", "SizeName", t("sizename")%>
</select></td>
<td><select name="colorname_<%=j%>" style=width:100%;><% SetCombojs "colorname", "select * from tColor", "colorname", "colorname", t("colorname")%></select></td>
<td><input class=number onFocus="this.select()" onkeyup=changenumber(<%=j%>) style=width:100%; type=text name="number_<%=j%>" value="<%=t("number")%>"></td>
<td><input class=number onFocus="this.select()" onkeyup=changeprice(<%=j%>) style=width:100%; type=text name="price_<%=j%>" value="<%=t("price")%>"></td>
<td><input class=number onFocus="this.select()" onkeyup=changemoney(<%=j%>) style=width:100%; type=text name="money_<%=j%>" value="<%=t("money")%>"></td>
<td><input style=width:100%; type=text name="barcode_<%=j%>" value="<%=t("barcode")%>"></td>
<td><input style=width:100%; type=text name="dremark_<%=j%>" value="<%=t("dremark")%>"></td>
</tr>
        <%
		t.movenext
	next
	response.write "<script>document.all.intK.value="&t.recordcount&"</script>"
	t.close
	set t=nothing
end if
%>
</table>
<table style=border-top:0px #ff0000 solid;>
<tr>
<th clospan=2 width=58 style=border-top:0px #ff0000 solid; align=center>合计：</th>
<th colspan=5 width=390 style=border-top:0px #ff0000 solid;><div id=moneyd style=font-weight:normal>零</div></th>
<th colspan=2 width=120 style=border-top:0px #ff0000 solid;><div id=numbera style=font-weight:normal>0</div></th>
<th colspan=2 width=260 style=border-top:0px #ff0000 solid;><div id=moneyx style=font-weight:normal>0</div></th>
</tr>
</table>
</div>
</fieldset>
<center>
<% if request("detail")="" then %>
<input class=dh type="submit" value="保存" name=submit>
<input class=dh type="reset" value="重置" name=reset>
<% else %>
<input class=dh type="button" value="单据横排" onclick=location.href='bill_hp.asp?billcode=<%=BillCode%>'>
<% end if %>
<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()>
</center>
</form>
<script>changevalue();</script>
</body>
</html>