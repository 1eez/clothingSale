<!-- #include file="../public/conn.asp" -->
<!-- #include file="../public/public.asp" -->
<%
set rs = server.createobject("adodb.recordset")
q="select * from t_appinfo"
'rs.open q, conn, 1, 1
'if rs("notry")="True" then
 ' sql = "update t_online set online=false where username='" & request.cookies("username") & "'"
 ' conn.execute sql
'end if
manageLog "ÓÃ»§" & request.cookies("userName") & "ÍË³ö"
connClose()
session.abandon
%>
<script language='javascript'>
var strCookie = document.cookie;
var arrCookie = strCookie.split(";");
var i;
var expires = new Date();
expires.setDate(expires.getDate() - 1);
for(i=0; i <arrCookie.length; i++)
{
¡¡  document.cookie = arrCookie[i].split('=')[0]+'=null;expires=' + expires.toGMTString();
}
parent.location.href='../login.asp';
</script>