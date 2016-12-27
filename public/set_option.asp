<!-- #include file="../public/conn.asp" -->
<!-- #include file="public.asp" -->
<%
num1 = request.form("num1")
num2 = request.form("num2")
auto = request.form("auto")
notry = request.form("notry")
p_type = request("p_type")
fuchuku = request("fuchuku")
if notry<>"1" then
	notry="0"
end if
autocode = request.form("autocode")
if num1<>"" and num2<>"" then
	sql = "update t_appinfo set fuchuku='"&fuchuku&"',p_type='"&p_type&"',dotprice='"&request("dotprice")&"',dotmoney='"&request("dotmoney")&"',dotnumber='"&request("dotnumber")&"',notry="&notry&",num1="&num1&",printnum="&num2&",autocode='"&autocode&"',auto='"&auto&"'"
	conn.execute sql
	manageLog "软件选项设置修改"
end if
set t = server.createobject("adodb.recordset")
sql = "select * from t_appinfo"
t.open sql, conn, 1, 1
num1 = t("num1")
num2 = t("printnum")
notry = t("notry")
dotnumber=t("dotnumber")
dotprice=t("dotprice")
dotmoney=t("dotmoney")
fuchuku=t("fuchuku")
p_type=t("p_type")
if notry="True" then
	cnotry="checked"
end if
autocode = t("autocode")
auto = t("auto")
if auto="1" then
	f_check="checked"
end if
if p_type="price" then
	p_check="selected"
end if
if fuchuku="1" then
	fc_check="checked"
end if
%>
<html>
<title>选项设置</title>
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<h1>选项设置</h1><hr>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<form action="set_option.asp" method="post">
<% if trim(session("loginnameb"))<>"user" then %>
<input type="checkbox" name="notry" value="1" <%=cnotry%>>软件正式启用<br>
<% end if %>
每页显示记录条数：<input type="text" style="text-align:right" name="num1" value="<%=num1%>" size=4><br>
单据打印一页最多显示记录数：<input type="text" style="text-align:right" name="num2" value="<%=num2%>" size=4><br>
自动编码前缀名称：<input type="text" name="autocode" value="<%=autocode%>" size=4><input type="checkbox" value=1 name="auto" <%=f_check%>>自动编号
<br>小数点位数：数量：<input type="text" style="text-align:right" name="dotnumber" value="<%=dotnumber%>" size=2>
单价：<input type="text" style="text-align:right" name="dotprice" value="<%=dotprice%>" size=2>
金额：<input type="text" style="text-align:right" name="dotmoney" value="<%=dotmoney%>" size=2>
<br><input name="fuchuku" type="checkbox" value="1" <%=fc_check%>>支持负出库，库存数量允许为负数
<hr><center>
<input class=dh type="submit" value=保存>&nbsp;<input class=dh type="button" value="关闭" onclick=window.opener=null;window.close()></center>
</form>
</body>
</html>