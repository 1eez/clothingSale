<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fVipCode = request.form("VipCode")
qVipCode = request.querystring("VipCode")
AddDate = setdate(request("AddDate"))
BirthDay = request("fmonth")&"-"&request("fday")
BirthType = request("BirthType")
Discount = request("Discount")
Phone = request("Phone")
Remark = request("Remark")
VipName = request("VipName")
VipType = request("VipType")
if qVipCode = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("vipcode", fvipcode, "tVip")=1 then
			response.write "<script>alert('VIP卡号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		if CheckRepeat("vipname", VipName, "tVip")=1 then
			response.write "<script>alert('VIP姓名重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	

		sql="select * from tVip where VipID = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("AddDate") = AddDate
			Rs("BirthDay") = BirthDay
			Rs("BirthType") = BirthType
			Rs("Discount") = Discount
			Rs("Phone") = Phone
			Rs("Remark") = Remark
			Rs("VipCode") = fVipCode
			Rs("VipName") = VipName
			Rs("VipType") = VipType
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增VIP，VIP卡号：" &	fvipcode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='vip_add.asp';</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qVipCode <> "" then
	conn.BeginTrans
	on error resume next
		if fVipCode<>qVipCode then
			if CheckRepeat("vipcode", fvipcode, "tVip")=1 then
				response.write "<script>alert('VIP卡号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tVip where VipCode = '"&qVipCode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("AddDate") = AddDate
			Rs("BirthDay") = BirthDay
			Rs("BirthType") = BirthType
			Rs("Discount") = Discount
			Rs("Phone") = Phone
			Rs("Remark") = Remark
			Rs("VipCode") = fVipCode
			Rs("VipName") = VipName
			Rs("VipType") = VipType
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改VIP，VIP卡号：" &	qVipCode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;window.opener=null;window.close();</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
%>