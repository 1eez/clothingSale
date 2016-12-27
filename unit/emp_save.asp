<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fEmpCode = request.form("EmpCode")
qEmpCode = request.querystring("EmpCode")
Address = request("Address")
BankID = request("BankID")
BankName = request("BankName")
Birthday = request("fmonth")&"-"&request("fday")
Depart = request("Depart")
DepartCode = request("DepartCode")
EmpName = request("EmpName")
EmpSex = request("EmpSex")
Job = request("Job")
Mobile = request("Mobile")
Native = request("Native")
NewOrOld = request("NewOrOld")
Phone = request("Phone")
Place = request("Place")
Remark = request("Remark")
PassWord = request("PassWord")

if qEmpCode = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("empcode", fEmpCode, "tEmp")=1 then
			response.write "<script>alert('员工编号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		if CheckRepeat("empname", EmpName, "tEmp")=1 then
			response.write "<script>alert('员工姓名重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	

		sql="select * from tEmp where EmpID = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("Address") = Address
			Rs("BankID") = BankID
			Rs("BankName") = BankName
			Rs("Birthday") = Birthday
			Rs("Depart") = Depart
			Rs("DepartCode") = DepartCode
			Rs("EmpCode") = fEmpCode
			Rs("EmpName") = EmpName
			Rs("EmpSex") = EmpSex
			Rs("Job") = Job
			Rs("Mobile") = Mobile
			Rs("Native") = Native
			Rs("NewOrOld") = NewOrOld
			Rs("Phone") = Phone
			Rs("Place") = Place
			Rs("Remark") = Remark
			Rs("PassWord") = PassWord
			
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增员工，员工编号：" &	fempcode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='emp_add.asp';</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qEmpCode <> "" then
	conn.BeginTrans
	on error resume next
		if fEmpCode<>qEmpCode then
			if CheckRepeat("empcode", fEmpCode, "tEmp")=1 then
				response.write "<script>alert('员工遍号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tEmp where EmpCode = '"&qEmpCode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("Address") = Address
			Rs("BankID") = BankID
			Rs("BankName") = BankName
			Rs("Birthday") = Birthday
			Rs("Depart") = Depart
			Rs("DepartCode") = DepartCode
			Rs("EmpCode") = fEmpCode
			Rs("EmpName") = EmpName
			Rs("EmpSex") = EmpSex
			Rs("Job") = Job
			Rs("Mobile") = Mobile
			Rs("Native") = Native
			Rs("NewOrOld") = NewOrOld
			Rs("Phone") = Phone
			Rs("Place") = Place
			Rs("Remark") = Remark
			Rs("PassWord") = PassWord
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改员工，员工编号：" &	qEmpCode
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