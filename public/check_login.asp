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
manageLog "用户" & una & "登陆"

if err.number<>"0" then
	response.redirect "../error.asp?reason=请把系统安装在Fat32分区下，或者修改程序所在的目录的‘安全’属性，Everyone用户组的完全控制权限为允许。<br>具体修改请参照点击<a href='ntfserror.htm'><font color='red'>这里</font></a><br>或登录我们网站<a href='http://www.bzwb.net'>www.bzwb.net</a>常见问题解决"
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
	response.write "<script>alert('用户名或者密码错误，请您重新输入');location.href='../login.asp'</script>"
else
	Response.cookies("loginnameb") =""   't("loginname")
	Response.cookies("usernamea") = t("username")
	session("username")=t("username")
	session("qxlist")=t("qxlist")
	session("cklist")=t("cklist")
	Response.cookies("qxlist") = t("qxlist")
	Response.cookies("cklist") = t("cklist")
	'标识为测试用户
	'session("loginnameb")="user"
	response.Redirect("../index.asp")
end if
t.close
set t = nothing
conn.close
set conn = nothing
%>