<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fcolorcode = request.form("colorcode")
qcolorcode = request.querystring("colorcode")
colorname = request("colorname")
if qcolorcode = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("colorcode", fcolorcode, "tColor")=1 then
			response.write "<script>alert('颜色编号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		if CheckRepeat("colorname", colorname, "tColor")=1 then
			response.write "<script>alert('颜色名称重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	

		sql="select * from tColor where ColorID = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("colorcode") = fcolorcode
			Rs("colorname") = colorname
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增颜色，颜色编号：" &	fcolorcode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='color_add.asp';</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qcolorcode <> "" then
	conn.BeginTrans
	on error resume next
		if fcolorcode<>qcolorcode then
			if CheckRepeat("colorcode", fcolorcode, "tColor")=1 then
				response.write "<script>alert('颜色编号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tColor where colorcode = '"&qcolorcode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("colorcode") = fcolorcode
			Rs("colorname") = colorname
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改颜色，颜色编号：" &	qcolorcode
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