<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
' ��ӿ�ʼ
	loginname = trim(request.cookies("usernamea"))
	conn.BeginTrans
	on error resume next
		set t = server.createobject("adodb.recordset")
		sql = "select * from tuser where username='" & loginname & "'"
		t.open sql, conn, 1, 1
		if request.form("pass1") <> t("password") then
			Response.Write"<script>alert('����ʧ�ܣ���ǰ�����������');history.go(-1)</SCRIPT>"
		  response.end
		end if
		if request.form("pass2") <> request.form("pass3") then
			Response.Write"<script>alert('����ʧ�ܣ����������벻һ�£�');history.go(-1)</SCRIPT>"
		  response.end
		end if
		sql = "update tuser set password='" & request.form("pass2") & "'"
		sql = sql & " where username='" & loginname & "'"
		conn.execute sql
		t.close
		set t=nothing
	'--------------------------------------------------------
	if err.number=0 then
		manageLog "����Ա�����޸ĳɹ�"
		conn.CommitTrans
		connClose()
		Response.Write"<script>alert('�޸ĳɹ���');location.href='set_password.asp'</script>"
	else
		conn.RollbackTrans '����ع�
		Response.Write"<script>alert('����ʧ�ܣ�������ϸ��д�����Ϣ��');history.go(-1)</script>"
	end if
%>