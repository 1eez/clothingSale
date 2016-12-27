<%@ codepage="936" %>
<%
scharset = "gb2312"
cklist = request.cookies("cklist")
qxlist = request.cookies("qxlist")
'On Error Resume Next
connstr="DBQ="&Server.Mappath("../data/shopdata.asp")&";DRIVER={Microsoft Access Driver (*.mdb)};"
set conn=Server.CreateObject("ADODB.connection")
'response.write connstr
'response.end
conn.Open connstr
If Err.Number <> 0 Then
	Err.Clear
	Conn.Close
	Set Conn = Nothing
	Response.Write "对不起,您的数据库连接出错,请与管理员联系!"
	Response.End
End If
if request("ptype")<>"printd" then
Dim Ft_Post,Ft_Get,Ft_In,Ft_Inf,Ft_Xh,Ft_db,Ft_dbstr,Kill_IP,WriteSql
Ft_In = "'|exec |insert |delete |count |chr |mid |truncate |char |declare "
Kill_IP=True
WriteSql=True
Ft_Inf = split(Ft_In,"|")

set t=Server.CreateObject("ADODB.recordset")
q = "select * from tSoftInfo"
t.open q, conn, 1, 1
	dotnumber = t("number")
	dotprice = t("price")
	dotmoney = t("money")
	billpage = t("billpage")
t.close
set t=nothing

If Request.Form<>"" Then
	For Each Ft_Post In Request.Form
		For Ft_Xh=0 To Ubound(Ft_Inf)
			If Instr(LCase(Request.Form(Ft_Post)),Ft_Inf(Ft_Xh))<>0 Then
				If WriteSql=True Then
					Response.Write "<Script Language=JavaScript>alert('请不要在参数中包含非法字符尝试注入！');</Script>"
					Response.Write "<Script Language=JavaScript>history.go(-1);</Script>"
					Response.End
				End If
			End If
		Next
	Next
End If
If Request.QueryString<>"" Then
	For Each Ft_Get In Request.QueryString
		For Ft_Xh=0 To Ubound(Ft_Inf)
			If Instr(replace(LCase(Request.QueryString(Ft_Get)),"<br><li>",""),Ft_Inf(Ft_Xh))<>0 Then
				If WriteSql=True Then
					Response.Write "<Script Language=JavaScript>alert('请不要在参数中包含非法字符尝试注入！');</Script>"
					Response.Write "<Script Language=JavaScript>history.go(-1);</Script>"
					Response.End
				End If
			End If
		Next
	Next
End If
end if
Sub connClose()
	conn.close
	Set conn=Nothing
End Sub
%>