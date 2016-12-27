<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fBillCode = request.form("BillCode")
qBillCode = request.querystring("BillCode")
AddDate = setdate(request("AddDate"))
AddTime = request("AddTime")
BillType = request("BillType")
CustName = request("CustName")
DepotName = request("DepotName")
EditDate = now()
Editer = session("username")
Field1 = request("Field1")
Field2 = request("Field2")
Field3 = request("Field3")
Field4 = request("Field4")
Field5 = request("Field5")
FUser = request("FUser")
InOrOut = request("InOrOut")
Maker = session("username")
MakerDate = now()
MRemark = request("MRemark")
OldBill = request("OldBill")
PayType = request("PayType")
SkMoney = request("SkMoney")
VipCode = request("VipCode")
YSMoney = request("YSMoney")
ZLMoney = request("ZLMoney")
if qBillCode = "" then
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
		
		intK = request("intK")
		set rsdetail = server.createobject("adodb.recordset")
		for i=1 to intK
			q = "select * from tGoods where goodsstyle='"&trim(request("GoodsStyle_"&i))&"'"
			rsdetail.open q, conn, 1, 1
			SizeGroup = rsdetail("SizeGroup")
			dpPrice = rsdetail("dpPrice")
			rsdetail.close
			q = "select * from tColor where ColorName='"&trim(request("ColorName_"&i))&"'"
					'rsdetail.open q, conn, 1, 1
			'ColorCode = rsdetail("ColorCode")
			'rsdetail.close
			'colorcode和colorname使用相同
			ColorCode=trim(request("ColorName_"&i))
			q = "select * from tSize where SizeName='"&trim(request("SizeName_"&i))&"'"
			rsdetail.open q, conn, 1, 1
			SizeCode = rsdetail("SizeCode")
			rowPosition = rsdetail("rowPosition")
			colPosition = rsdetail("colPosition")
			rsdetail.close
			InPrice = trim(request("price_"&i))
			InMoney = InPrice*trim(request("number_"&i))
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
			q = q&"'"&BillCode&"','"&trim(request("GoodsStyle_"&i))&"','"&trim(request("GoodsName_"&i))&"',"
			q = q&"'"&trim(request("Units_"&i))&"','"&SizeGroup&"','"&ColorCode&"',"
			q = q&"'"&trim(request("ColorName_"&i))&"','','"&SizeCode&"',"
			q = q&"'"&trim(request("SizeName_"&i))&"',"&trim(request("Number_"&i))&",1,"
			q = q&""&trim(request("Price_"&i))&","&dpPrice&",0,"
			q = q&""&trim(request("Money_"&i))&","&colPosition&","&rowPosition&","
			q = q&"'"&trim(request("DRemark_"&i))&"',"&Sign&","&InPrice&","
			q = q&""&InMoney&",'"&trim(request("BarCode_"&i))&"','"&trim(request("DetailField1_"&i))&"',"
			q = q&"'"&trim(request("DetailField2_"&i))&"','"&trim(request("DetailField3_"&i))&"','"&trim(request("DetailField4"&i))&"',"
			q = q&"'"&trim(request("DetailField5_"&i))&"')"
			conn.execute q
		next
		
		set rsdetail=nothing
	if err.number=0 then
		manageLog "新增单据，单号：" &BillCode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href='qcbill_add.asp?billtype="&billtype&"&refresh=add';window.opener=null;window.close();</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qBillCode <> "" then
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
		
		sql="select * from tBill where BillCode = '"&qBillCode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("AddDate") = AddDate
			Rs("AddTime") = AddTime
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
		
		q = "delete from tBillDetail where DBillCode='"&qBillCode&"'"
		conn.execute q
		intK = request("intK")
		set rsdetail = server.createobject("adodb.recordset")
		for i=1 to intK
			q = "select * from tGoods where goodsstyle='"&trim(request("GoodsStyle_"&i))&"'"
			rsdetail.open q, conn, 1, 1
			SizeGroup = rsdetail("SizeGroup")
			dpPrice = rsdetail("dpPrice")
			rsdetail.close
			q = "select * from tColor where ColorName='"&trim(request("ColorName_"&i))&"'"
				'rsdetail.open q, conn, 1, 1
			'ColorCode = rsdetail("ColorCode")
			'rsdetail.close
			'colorcode和colorname使用相同
			ColorCode=trim(request("ColorName_"&i))
			q = "select * from tSize where SizeName='"&trim(request("SizeName_"&i))&"'"
			rsdetail.open q, conn, 1, 1
			SizeCode = rsdetail("SizeCode")
			rowPosition = rsdetail("rowPosition")
			colPosition = rsdetail("colPosition")
			rsdetail.close
			InPrice = trim(request("price_"&i))
			InMoney = InPrice*trim(request("number_"&i))
			q = ""
			q = q&"insert into tBillDetail("
			q = q&"DBillCode, GoodsStyle, GoodsName,"
			q = q&"Units,SizeGroup,ColorCode,"
			q = q&"ColorName,ColorValue,SizeCode,"
			q = q&"SizeName,[Number],Discount,"
			q = q&"Price,dpPrice,xsPrice,"
			q = q&"[Money],colPosition,rowPosition,"
			q = q&"DRemark,[Sign],InPrice,"
			q = q&"InMoney,BarCode,DetailField1,"
			q = q&"DetailField2,DetailField3,DetailField4,"
			q = q&"DetailField5)"
			q = q&"values("
			q = q&"'"&qBillCode&"','"&trim(request("GoodsStyle_"&i))&"','"&trim(request("GoodsName_"&i))&"',"
			q = q&"'"&trim(request("Units_"&i))&"','"&SizeGroup&"','"&ColorCode&"',"
			q = q&"'"&trim(request("ColorName_"&i))&"','','"&SizeCode&"',"
			q = q&"'"&trim(request("SizeName_"&i))&"',"&trim(request("Number_"&i))&",'1',"
			q = q&""&trim(request("Price_"&i))&","&dpPrice&",0,"
			q = q&""&trim(request("Money_"&i))&","&colPosition&","&rowPosition&","
			q = q&"'"&trim(request("DRemark_"&i))&"',"&Sign&","&InPrice&","
			q = q&""&InMoney&",'"&trim(request("BarCode_"&i))&"','"&trim(request("DetailField1_"&i))&"',"
			q = q&"'"&trim(request("DetailField2_"&i))&"','"&trim(request("DetailField3_"&i))&"','"&trim(request("DetailField4"&i))&"',"
			q = q&"'"&trim(request("DetailField5_"&i))&"')"
			conn.execute q
		next
		
		set rsdetail=nothing
	if err.number=0 then
		manageLog "修改单据，单号：" &qBillCode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href='qcbill_add.asp?billcode="&qBillCode&"&refresh=edit';window.opener=null;window.close();</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
%>