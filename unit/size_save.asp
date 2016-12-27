<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
fsizecode = request.form("sizecode")
qsizecode = request.querystring("sizecode")
colPosition = request("colPosition")
rowPosition = request("rowPosition")
SizeGroup = request("SizeGroup")
SizeName = request("SizeName")
if qsizecode = "" then
	conn.BeginTrans
	on error resume next
		if CheckRepeat("sizecode", fsizecode, "tSize")=1 then
			response.write "<script>alert('尺码编号重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		if CheckRepeat("sizename", colorname, "tSize")=1 then
			response.write "<script>alert('尺码名称重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if	
		
		set Rs = server.createobject("adodb.recordset")
		q = "select * from tSize where colPosition="&colPosition&" and rowPosition="&rowPosition&""
		rs.open q, conn, 1, 1
		if not rs.eof then
			response.write "<script>alert('行位置列位置重复，请您重新输入！');history.go(-1);</script>"
			response.end
		end if
		rs.close
		set rs=nothing		

		sql="select * from tSize where SizeID = null"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
		Rs.addnew
			Rs("colPosition") = colPosition
			Rs("rowPosition") = rowPosition
			Rs("SizeGroup") = SizeGroup
			Rs("SizeCode") = fsizecode
			Rs("SizeName") = SizeName
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "新增尺码，尺码编号：" &	fsizecode
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>self.opener.location.href=self.opener.location.href;location.href='size_add.asp';</SCRIPT>" 
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if

if qsizecode <> "" then
	conn.BeginTrans
	on error resume next
		if fsizecode<>qsizecode then
			if CheckRepeat("sizecode", fsizecode, "tSize")=1 then
				response.write "<script>alert('尺码编号重复，请您重新输入！');history.go(-1);</script>"
				response.end
			end if	
		end if
		sql="select * from tSize where sizecode = '"&qsizecode&"'"
		set Rs = server.createobject("adodb.recordset")
		Rs.open sql,conn,1,3
			Rs("colPosition") = colPosition
			Rs("rowPosition") = rowPosition
			Rs("SizeGroup") = SizeGroup
			Rs("SizeCode") = fsizecode
			Rs("SizeName") = SizeName
		Rs.update
		Rs.close
		set Rs = nothing
	if err.number=0 then
		manageLog "修改尺码，尺码编号：" &	qsizecode
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