<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
tablename = request("tablename")
treecode = request("treecode")
treename = request("treename")
addtreename = request("addtreename")
edittreename = request("edittreename")
catetype = request("catetype")
type1 = request("type1")
if catetype = "ɾ��" then
	conn.BeginTrans
	on error resume next
		sql = "delete from dict_cate where code like '"&treecode&"%' and tablename='"&tablename&"'"
		conn.execute sql
	if err.number=0 then
		manageLog "ɾ�������" & treecode &"-"& treename
		Response.Write"<script>alert('ɾ���ɹ���');location.href='combo.asp?tablename="&tablename&"'</script>"
		conn.CommitTrans
	else
		conn.RollbackTrans
		response.write err.description
	end if
end if
if catetype="�޸�" then
	conn.BeginTrans
	on error resume next
		sql = "update dict_cate set name='"&edittreename&"' where code='"&treecode&"' and tablename='"&tablename&"'"
		conn.execute sql
	if err.number=0 then
		manageLog "�޸������" & treecode &"-"& treename
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>alert('�޸ĳɹ���');location.href='combo.asp?tablename="&tablename&"'</script>"
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
if catetype="���" then
	conn.BeginTrans
	on error resume next
		set t = server.createobject("adodb.recordset")
		q = "select max(code) from dict_cate"
		q = q&" where tablename='"&tablename&"' "
		q = q&" and len(code)=2"	
		t.open q, conn, 1, 1
		if isnull(t.fields(0).value) then
			treecode = treecode + "01"
		else
			intcode = t.fields(0).value + 1
			if (len(intcode) mod 2)<>0 then
				treecode = "0"&intcode
			else
				treecode = intcode
			end if
		end if
		t.close
		q = "select * from dict_cate where id<0"
		t.open q, conn, 1, 3
		t.addnew
			t("code") = treecode
			t("name") = addtreename
			t("qxname") = ""
			t("tablename") = tablename
		t.update
		t.close
		set t=nothing
	if err.number=0 then
		manageLog "��������" & treecode &"-"& treename
		conn.CommitTrans
		conn.close
		set conn=nothing
		Response.Write"<script>alert('��ӳɹ���');location.href='combo.asp?treecode="&request("treecode")&"&treename="&request("treename")&"&tablename="&tablename&"'</script>"
	else
		conn.RollbackTrans
		Response.Write err.description
	end if
end if
%>