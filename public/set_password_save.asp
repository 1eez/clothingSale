<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
' 添加开始
	loginname = trim(request.cookies("usernamea"))
	conn.BeginTrans
	on error resume next
		set t = server.createobject("adodb.recordset")
		sql = "select * from tuser where username='" & loginname & "'"
		t.open sql, conn, 1, 1
		if request.form("pass1") <> t("password") then
			Response.Write"<script>alert('保存失败，当前密码输入错误！');history.go(-1)</SCRIPT>"
		  response.end
		end if
		if request.form("pass2") <> request.form("pass3") then
			Response.Write"<script>alert('保存失败，新密码输入不一致！');history.go(-1)</SCRIPT>"
		  response.end
		end if
		sql = "update tuser set password='" & request.form("pass2") & "'"
		sql = sql & " where username='" & loginname & "'"
		conn.execute sql
		t.close
		set t=nothing
	'--------------------------------------------------------
	if err.number=0 then
		manageLog "管理员密码修改成功"
		conn.CommitTrans
		connClose()
		Response.Write"<script>alert('修改成功！');location.href='set_password.asp'</script>"
	else
		conn.RollbackTrans '否则回滚
		Response.Write"<script>alert('保存失败，请您仔细填写相关信息！');history.go(-1)</script>"
	end if
%>