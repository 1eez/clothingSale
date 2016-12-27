<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fcustcode = request.form("custcode")
qcustcode= request.querystring("custcode")
address = request("address")
area = request("area")
areacode = request("areacode")
bankid = request("bankid")
bankname = request("bankname")
contact = request("contact")
cotype = request("cotype")
cotypecode = request("cotypecode")
custcode = request("custcode")
custname = request("custname")
custtype = request("custtype")
depart = request("depart")
email = request("email")
fax = request("fax")
mobile = request("mobile")
msnqq = request("msnqq")
phone = request("phone")
place = request("place")
remark = request("remark")
wangwang = request("wangwang")
website = request("website")
if qcustcode = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("custcode", fcustcode, "tcustom")=1 then
			response.write "<script>alert('公司编号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		if CheckRepeat("custname", custname, "tcustom")=1 then
			response.write "<script>alert('公司名称重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	

		sql="select * from tCustom where customid = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("address") = address
			Rs("area") = area
			Rs("areacode") = areacode
			Rs("bankid") = bankid
			Rs("bankname") = bankname
			Rs("contact") = contact
			Rs("cotype") = cotype
			Rs("cotypecode") = cotypecode
			Rs("custcode") = fcustcode
			Rs("custname") = custname
			Rs("custtype") = custtype
			Rs("depart") = depart
			Rs("email") = email
			Rs("fax") = fax
			Rs("mobile") = mobile
			Rs("msnqq") = msnqq
			Rs("phone") = phone
			Rs("place") = place
			Rs("remark") = remark
			Rs("wangwang") = wangwang
			Rs("website") = website
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增公司，公司编号：" &	fcustcode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='cust_add.asp';</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qcustcode <> "" then
	conn.BeginTrans
	on error resume next
		if fcustcode<>qcustcode then
			if CheckRepeat("custcode", fcustcode, "tcustom")=1 then
				response.write "<script>alert('商品款号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tCustom where custcode = '"&qcustcode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("address") = address
			Rs("area") = area
			Rs("areacode") = areacode
			Rs("bankid") = bankid
			Rs("bankname") = bankname
			Rs("contact") = contact
			Rs("cotype") = cotype
			Rs("cotypecode") = cotypecode
			Rs("custcode") = fcustcode
			Rs("custname") = custname
			Rs("custtype") = custtype
			Rs("depart") = depart
			Rs("email") = email
			Rs("fax") = fax
			Rs("mobile") = mobile
			Rs("msnqq") = msnqq
			Rs("phone") = phone
			Rs("place") = place
			Rs("remark") = remark
			Rs("wangwang") = wangwang
			Rs("website") = website
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改公司，公司编号：" &	qcustcode
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