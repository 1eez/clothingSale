<!-- #include file="conn.asp" -->
<%
f_do = "1"
%>
<!-- #include file="public.asp" -->
<%
una = Request.Form("username")
pws = Request.Form("password")


on error resume next
err.number=0
manageLog "�û�" & una & "��½"

if err.number<>"0" then
	response.redirect "../error.asp?reason=���ϵͳ��װ��Fat32�����£������޸ĳ������ڵ�Ŀ¼�ġ���ȫ�����ԣ�Everyone�û������ȫ����Ȩ��Ϊ����<br>�����޸�����յ��<a href='ntfserror.htm'><font color='red'>����</font></a><br>���¼������վ<a href='http://www.bzwb.net'>www.bzwb.net</a>����������"
	response.end
end if


set t = server.createobject("adodb.recordset")
q = "select * from tSoftInfo"
t.open q, conn, 1, 1
response.cookies("co_name") = t("coname")
response.cookies("version") = t("version")
t.close
sql = "select * from tUser where username='"&una&"' and password='"&pws&"'"
t.open sql, conn, 1, 1
if t.RecordCount = 0 then
	response.write "<script>alert('�û��������������������������');location.href='../login.asp'</script>"
else
	Response.cookies("loginnameb") =""   't("loginname")
	Response.cookies("usernamea") = t("username")
	session("username")=t("username")
	session("qxlist")=t("qxlist")
	session("cklist")=t("cklist")
	Response.cookies("qxlist") = t("qxlist")
	Response.cookies("cklist") = t("cklist")
	'��ʶΪ�����û�
	'session("loginnameb")="user"
	response.Redirect("../index.asp")
end if
t.close
set t = nothing
conn.close
set conn = nothing
%>