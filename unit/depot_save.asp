<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fDepotName = request.form("DepotName")
qDepotName = request.querystring("DepotName")
Address = request("Address")
DepotMan = request("DepotMan")
Mobile = request("Mobile")
pDepotName = request("DepotName")
Phone = request("Phone")
pRemark = request("pRemark")
Remark = request("Remark")
seqno=request("seqno")
if qDepotName = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("DepotName", fDepotName, "tDepot")=1 then
			response.write "<script>alert('店铺名称重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		sql="select * from tDepot where DepotName = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("Address") = Address
			Rs("DepotName") = fDepotName
			Rs("DepotMan") = DepotMan
			Rs("Mobile") = Mobile
			Rs("pDepotName") = pDepotName
			Rs("Phone") = Phone
			Rs("pRemark") = pRemark
			Rs("Remark") = Remark
			Rs("seqno")=seqno
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增店铺，店铺名称：" &	fDepotName
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='Depot_add.asp'</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qDepotName <> "" then
	conn.BeginTrans
	on error resume next
		if fDepotName<>qDepotName then
			if CheckRepeat("DepotName", fDepotName, "tDepot")=1 then
				response.write "<script>alert('店铺名称重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tDepot where DepotName = '"&qDepotName&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("Address") = Address
			Rs("DepotName") = fDepotName
			Rs("DepotMan") = DepotMan
			Rs("Mobile") = Mobile
			Rs("pDepotName") = pDepotName
			Rs("Phone") = Phone
			Rs("pRemark") = pRemark
			Rs("Remark") = Remark
			Rs("seqno")=seqno
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改店铺，店铺名称：" &	qDepotName
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