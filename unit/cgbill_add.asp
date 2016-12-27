<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
if request("refresh")="add" then
%>
<script>
if(self.opener.parent.main.location.href.indexOf('cgbill_find.asp')>0){
	self.opener.parent.main.location.href=self.opener.parent.main.location.href;
}else{
	self.opener.parent.main.location.href='cgbill_find.asp';
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
action = "cgbill_add_save.asp"
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
	if billtype="采购进货" then
		BillCode=SetCode("CG", setdate(date()), "tBill")
	end if
	if billtype="采购退货" then
		BillCode=SetCode("CT", setdate(date()), "tBill")
	end if
	adddate = setdate(date())
	reK = 0
end if
dTitle = "【"&billtype&"单】"
st1="width='15%' align=right"
st2="width='30%'"
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/cgbill_add.js'></script>
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
<body>
<form name="form" method="post" action="<%=action%>" onSubmit="return validate_form()" target="_blank">
<div id=billTitle><center><%=dTitle%></center></div>
<center>预计单号：<font color=clred><b><%=BillCode%></b></font></center>
<table align="center" valign="center" width="100%">
<tr><td <%=st1%>>店铺名称：</td>
<td <%=st2%>>
<% ComboDepot "DepotName", DepotName, "auto", "no"%><%=RedPoint%>
</td><td <%=st1%>>单据日期：</td>
<td <%=st2%>>
<input type="text" name="adddate" size="12" value="<%=adddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(adddate,0);"><%=RedPoint%>
<input type="hidden" name="CustName" value="无" size=60>
</td>
</tr>
<!--
<tr><td <%=st1%>>供应商：</td>
<td <%=st2%> colspan=3>
<input type="text" name="CustName" value="<%=CustName%>" size=60>
<img style="cursor:hand" src="../images/f.gif" onclick=openwin('cust_select.asp?tablename=custname&custtype=供应商',640,480)><%=RedPoint%>
</td>
</tr>
-->
<tr><td <%=st1%>>经办人：</td>
<td <%=st2%>>
<% SetCombo "FUser", "select EmpName from tEmp", "no", FUser, "auto"%>
</td><td <%=st1%>>手工单号：</td>
<td <%=st2%>>
<input type="text" name="oldbill" size="12" value="<%=oldbill%>">
</td>
</tr>
<tr><td <%=st1%>>备注：</td>
<td colspan="3">
<textarea name="MRemark" cols="60" rows="2" wrap="VIRTUAL"><%=MRemark%></textarea>
</td></tr>
</table><div style="marging:4px 0;">
<input type=hidden name=intK>
<input type=hidden name="billtype" value="<%=billtype%>">
<input class=dh type=button onclick=checkdepot(0) name="addnew" value=增行>
<!--
<input class=dh type=button name="btnBarCode" value=条码扫描 onClick="showbarcode()"><div id=divbarcode style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;条形码：<input type="text" name="barcode" size=16 onkeyup=setbarcode()>
数量：<input class=number type="text" name="number" size=8></div>-->
</div>
<fieldset style="width:auto;"><legend>明细信息</legend>
<div id="inner-table-hpzl">
<table id=t136>
<tr>
<th width=28 align=center></th>
<th width=30 align=center>序号</th>
<th width=110 align=center>商品款号</th>
<th width=120 align=center>商品名称</th>
<th width=40 align=center>单位</th>
<th width=60 align=center>尺码</th>
<th width=60 align=center>颜色</th>
<th width=60 align=center>数量</th>
<th width=60 align=center>单价</th>
<th width=60 align=center>金额</th>
<th width=120 align=center>条码</th>
<th width=80 align=center>备注</th>
</tr>
<%
if BillCode<>"" then
	set t = server.createobject("adodb.recordset")
	q = "select * from tBillDetail where DBillCode='"&BillCode&"' order by BillDetailID"
	t.open q, conn, 1, 1
	for i = 0 to t.recordcount - 1
		j = i + 1
		%>
<tr height=25>
<td>
	<% if request("detail")="" then %>
	<a class=delete href=javascript:void(0) onclick=del()>删除</a>
	<% end if %>
	</td>
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