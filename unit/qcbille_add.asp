<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<!-- #include file="../public/isuser.asp" -->
<%
if request("refresh")="add" then
%>
<script>
if(self.opener.parent.main.location.href.indexOf('qcbill_find.asp')>0){
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
response.write request("sbumit")
action = "qcbille_add.asp?billtype=�ڳ�¼��"
if request("submit")="����" then
	response.write request("sbumit")
	AddDate = setdate(request("AddDate"))
	DepotName = request("DepotName")
	BillType = request("BillType")
	EditDate = now()
	Editer = session("username")
	FUser = request("FUser")
	Maker = session("username")
	MakerDate = now()
	MRemark = request("MRemark")
	OldBill = request("OldBill")
	PayType = request("PayType")
	conn.BeginTrans
	on error resume next
		set t = server.createobject("adodb.recordset")
		q = "select * from dict_bill where name='"&BillType&"'"
		t.open q, conn, 1, 1
			Code = t("code")
			inorout = t("inorout")
			Sign = t("sign")
		t.close
		set t=nothing
		BillCode=SetCode(Code, AddDate, "tBill")
		sql="select * from tBill where BillID = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("BillCode") = BillCode
			Rs("AddDate") = AddDate
			Rs("BillType") = BillType
			Rs("CustName") = CustName
			Rs("DepotName") = DepotName
			Rs("EditDate") = EditDate
			Rs("Editer") = Editer
			Rs("Field1") = Field1
			Rs("Field2") = Field2
			Rs("Field3") = Field3
			Rs("Field4") = Field4
			Rs("Field5") = Field5
			Rs("FUser") = FUser
			Rs("InOrOut") = InOrOut
			Rs("Maker") = Maker
			Rs("MakerDate") = MakerDate
			Rs("MRemark") = MRemark
			Rs("OldBill") = OldBill
			Rs("PayType") = PayType
			Rs("SkMoney") = SkMoney
			Rs("VipCode") = VipCode
			Rs("YSMoney") = YSMoney
			Rs("ZLMoney") = ZLMoney
		Rs.update
		Rs.close		
		set Rs = nothing
	
		text = trim(request("excelin"))
		text = myReplace(text)
		dedearr=split(text,chr(13))		
		for dede=0 to ubound(dedearr)-1
			a1 = split(dedearr(dede)," ")
			goodsstyle = replace(trim(a1(0)),chr(13),"")
			goodsstyle = replace(trim(a1(0)),chr(10),"")
			goodsname = trim(a1(1))
			units = trim(a1(2))
			sizename = trim(a1(3))
			colorname = trim(a1(4))
			number = trim(a1(5))
			price = trim(a1(6))
			money = trim(a1(7))
			barcode = trim(a1(8))
			dremark = trim(a1(9))
			set rsdetail = server.createobject("adodb.recordset")
			q = "select * from tGoods where goodsstyle='"&GoodsStyle&"'"
			rsdetail.open q, conn, 1, 1
			if not rsdetail.eof then
			SizeGroup = rsdetail("SizeGroup")
			dpPrice = rsdetail("dpPrice")
		  else
		  	  conn.RollbackTrans
		  		Response.Write "GoodsStyle["&GoodsStyle&"]������"
	        response.end
			end if
			rsdetail.close
			q = "select * from tColor where ColorName='"&ColorName&"'"
					'rsdetail.open q, conn, 1, 1
			'ColorCode = rsdetail("ColorCode")
			'rsdetail.close
			'colorcode��colornameʹ����ͬ
			ColorCode=trim(request("ColorName_"&i))
			
			q = "select * from tSize where SizeName='"&SizeName&"'"
			rsdetail.open q, conn, 1, 1
			if not rsdetail.eof then
			SizeCode = rsdetail("SizeCode")
			rowPosition = rsdetail("rowPosition")
			colPosition = rsdetail("colPosition")
		else
			    conn.RollbackTrans
		  		Response.Write "SizeName["&SizeName&"]������"
	        response.end
			end if
			rsdetail.close
			set rsdetail=nothing
			InPrice = price
			'response.write "GoodsStyle"&GoodsStyle &",msg:"&dedearr(dede)
			InMoney = price*number
			q = ""
			q = q&"insert into tBillDetail("
			q = q&"DBillCode, GoodsStyle, GoodsName,"
			q = q&"Units,SizeGroup,ColorCode,"
			q = q&"ColorName,ColorValue,SizeCode,"
			q = q&"SizeName,[Number],Discount,"
			q = q&"[Price],dpPrice,xsPrice,"
			q = q&"[Money],colPosition,rowPosition,"
			q = q&"DRemark,[Sign],InPrice,"
			q = q&"InMoney,BarCode,DetailField1,"
			q = q&"DetailField2,DetailField3,DetailField4,"
			q = q&"DetailField5)"
			q = q&"values("
			q = q&"'"&BillCode&"','"&GoodsStyle&"','"&GoodsName&"',"
			q = q&"'"&Units&"','"&SizeGroup&"','"&ColorCode&"',"
			q = q&"'"&ColorName&"','','"&SizeCode&"',"
			q = q&"'"&SizeName&"',"&Number&",1,"
			q = q&""&Price&","&dpPrice&",0,"
			q = q&""&Money&","&colPosition&","&rowPosition&","
			q = q&"'"&DRemark&"',"&Sign&","&InPrice&","
			q = q&""&InMoney&",'"&BarCode&"','',"
			q = q&"'','','',"
			q = q&"'')"
			'response.write q
			conn.execute q
			
		next
	if err.number=0 then
		manageLog "�����ڳ����ݣ����ţ�" &BillCode
		conn.CommitTrans
		'conn.close
		'set conn=nothing
		Response.Write"<script>alert('����ɹ���');</SCRIPT>" 
	else
		conn.RollbackTrans
	  	Response.Write err.description
	  response.end
	end if
else
	adddate = setdate(date())
	BillCode=SetCode("QC", setdate(date()), "tBill")
end if
dTitle = "��"&billtype&"����"
st1="width='15%' align=right"
st2="width='30%'"
depotnamecaption = "�������ƣ�" 
custnamecaption = "�ͻ���"
custnameinput = ""
if billtype="���̵���" then
	depotnamecaption = "�������̣�" 
	custnamecaption = "������̣�"
end if
%>
<html>
<title><%=dTitle%></title>
<head><meta http-equiv="Content-Type" content="text/html; charset=<%=scharser%>">
<script type='text/javascript' src='../js/public.js'></script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<link href="../calendar.css" rel="stylesheet" type="text/css" media="all" />
<script type='text/javascript' src='../js/calendar.js'></script>
<script type='text/javascript' src='../js/xsbill_add.js'></script>
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
Excel����������裺<br>
1.����excel����ֶ�˳�����·������ֶ�˳�򣬱��밴��һ һ��Ӧ���򣬲��ɶ�Ҳ�����١�<br>
2.¼�����ݺ󣬸���excel�����е���¼��õ����ݣ���ͷ���⣬Ȼ�����·���ע����ճ����<br>
3.������棬���������ɡ�<br>
4.���ڵ������Ʒ����������Ʒ�������м��ص���Ʒ��<br>
<form onKeyPress="if(event.keyCode==13){return false;}" name="form" method="post" action="<%=action%>" onSubmit="return validate_form()">
<div id=billTitle><center><%=dTitle%></center></div>
<center>Ԥ�Ƶ��ţ�<font color=clred><b><%=BillCode%></b></font></center>
<table align="center" valign="center" width="100%">
<tr><td <%=st1%>><%=depotnamecaption%></td>
<td <%=st2%>>
<% ComboDepot "DepotName", DepotName, "auto", "no"%><%=RedPoint%>
</td><td <%=st1%>>�������ڣ�</td>
<td <%=st2%>>
<input type="text" name="adddate" size="12" value="<%=adddate%>">
<img src="../images/calendar.gif" class=dh align="absmiddle" onClick="javascript:showCalendar(adddate,0);"><%=RedPoint%>
</td>
</tr>
<tr><td <%=st1%>>�����ˣ�</td>
<td <%=st2%>>
<% SetCombo "FUser", "select EmpName from tEmp", "no", FUser, "auto"%>
</td><td <%=st1%>>�ֹ����ţ�</td>
<td <%=st2%>>
<input type="text" name="oldbill" size="12" value="<%=oldbill%>">
</td>
</tr>
<tr><td <%=st1%>>��ע��</td>
<td colspan="3">
<textarea name="MRemark" cols="60" rows="2" wrap="VIRTUAL"><%=MRemark%></textarea>
</td></tr>
</table><div id="inner-table-hpzl" style="padding-top:4px;">
<table id=t136>
<tr>
<th width=110 align=center>��Ʒ���</th>
<th width=120 align=center>��Ʒ����</th>
<th width=40 align=center>��λ</th>
<th width=60 align=center>����</th>
<th width=60 align=center>��ɫ</th>
<th width=60 align=center>����</th>
<th width=60 align=center>����</th>
<th width=60 align=center>���</th>
<th width=120 align=center>����</th>
<th width=80 align=center>��ע</th>
</tr>
<tr>
<td colspan=10>
<textarea name="excelin" style="background-color:#CCC;width:770px;overflow:scroll;" rows="10" wrap="VIRTUAL"><%=excelin%></textarea>
</td>
</tr>
</table>
</div>
<center>
<% if request("detail")="" then %>
<input class=dh type="submit" value="����" name=submit>
<input class=dh type="reset" value="����" name=reset>
<% else %>
<input class=dh type="button" value="���ݺ���" onclick=location.href='bill_hp.asp?billcode=<%=BillCode%>'>
<% end if %>
<input class=dh type="button" value="�ر�" onclick=window.opener=null;window.close()>
</center>
</form>
</body>
</html>