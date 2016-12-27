<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Option Explicit%>
<%
dim connstr, conn
connstr="DBQ="&Server.Mappath("../data/#depot.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn=Server.CreateObject("ADODB.connection") 
conn.Open connstr 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>让ASP在线执行SQL语句 Editor www.Aspid.cn For 吟清</title>
</head>
<body>
<%
if request("Content")<>"" then
   call DoExeCuteSql()
     Else
%>
<form action="sql.asp" method="post" name="form" id="form"> 
<textarea name="Content" rows="5" wrap="OFF" id="Content" style="width:100%"></textarea> 
<br /> 
<input name="Submit" type="submit" value="执行SQL语句"> 
<input name="Rest" type="reset" value="重写"> 
</form> 
<% End If %> 
</body>
</html>
<%
Sub DoExeCuteSql()
Dim Content
Content=Request("Content")
Err.Clear
On Error Resume Next
Conn.BeginTrans
Conn.ExeCute(Content)
response.write content
If Err.Number<>0 Then
Conn.Rollback
Response.Write("<script>alert(""< 执行失败>\nSQL语句有误,请检查你的SQL语句.\nFor Aspid.cn"");window.history.back();</script>")
Else
Conn.CommitTrans
Response.Write("<script>alert(""<执行成功>\nSQL语句执行完毕\nFor Aspid.cn"");window.history.back();</script>")
End If
Response.End
End Sub
%>