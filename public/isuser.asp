<%
Response.Buffer = true
Response.ExpiresAbsolute=now()-1
Response.Expires=0
Response.CacheControl="no-cache"
qxlist = request.cookies("qxlist")
username = Request.Cookies("usernamea")
username1 = "123"
if username1="" then
	response.write "<script>alert('��¼��ſɲ�����');location.href='../login.asp'</script>"
end if
%>