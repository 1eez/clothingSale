<!-- #include file="../public/conn.asp" -->
<%
billcode = request("billcode")
detail = request("detail")
q = "select * from tBill where billcode='"&billcode&"'"
set t = server.createobject("adodb.recordset")
t.open q, conn, 1, 1
if instr("�ɹ������ɹ��˻�",t("billtype"))>0 then
	Response.Write"<script>location.href='cgBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
if instr("�ڳ�¼��",t("billtype"))>0 then
	Response.Write"<script>location.href='qcBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
if instr("���۳��������˻����̵���",t("billtype"))>0 then
	Response.Write"<script>location.href='xsBill_add.asp?detail="&detail&"&billcode="&billcode&"'</SCRIPT>" 	
end if
t.close
set t=nothing
conn.close
set conn=nothing
%>